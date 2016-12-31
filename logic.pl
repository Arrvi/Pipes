
:- dynamic currentLevel/1.
:- dynamic xcurrentMap/3.
:- dynamic hotbar/2.
:- dynamic input/2.

setPipe(Pipe, X, Y) :- retract(xcurrentMap(_, X, Y)), assert(xcurrentMap(Pipe, X, Y)).
setPipe(Pipe, X, Y) :- assert(xcurrentMap(Pipe, X, Y)).

clearLevel() :- 
	abolish(xcurrentMap/3), 
	abolish(currentLevel/1), 
	abolish(hotbar/2), 
	abolish(input/2).

currentMap(Pipe, X, Y) :- xcurrentMap(Pipe, X, Y); not(xcurrentMap(_, X, Y)), Pipe=none.

initMap(Level) :- forall(map(Level, Pipe, X, Y), assert(xcurrentMap(Pipe, X, Y))).
initHotbar(Level) :- forall(mapItem(Level, Pipe, Count), assert(hotbar(Pipe, Count))).
initInput(Level) :- mapInput(Level, X, Y), assert(input(X, Y)).

initLevel(Level) :- not(level(Level)), error(noSuchLevel).
initLevel(Level) :- 
	debug('Loading ~w', [Level]),
	clearLevel,
	debug('cleared map'),
	initMap(Level), 
	debug('created map'),
	initHotbar(Level), 
	debug('created hotbar'),
	initInput(Level), 
	debug('selected input'),
	assert(currentLevel(Level)),
	(levelName(Level, LevelName); LevelName=Level),
	writeMsg([bg(green)], levelLoaded, [LevelName]), nl, nl,
	writeMap, !.

addToHotbar(Pipe) :- Pipe=none.
addToHotbar(Pipe) :- hotbar(Pipe, N), N2 is N+1, retract(hotbar(Pipe, N)), assert(hotbar(Pipe, N2)).
removeFromHotbar(Pipe) :- Pipe=none.
removeFromHotbar(Pipe) :- hotbar(Pipe, N), N > 0, N2 is N-1, retract(hotbar(Pipe, N)), assert(hotbar(Pipe, N2)).


isFixed(X,Y) :- currentLevel(Level), map(Level, FixedPipe, X, Y).
fixedPipe(Pipe, X, Y) :- currentLevel(Level), map(Level, FixedPipe, X, Y); Pipe=none.

placePipe(NewPipe, X, Y) :- 
	debug('trying to place [~w] at ~w ~w', [NewPipe,X,Y]),
	((
		hotbar(NewPipe, Count), Count > 0, debug('enough of [~w] in hotbar', [NewPipe]); 
		NewPipe=none, debug('removing pipe')
	); error(noItemInHotbar, [NewPipe]), false),
	currentMap(OldPipe, X, Y),
	debug('current pipe is [~w]',[OldPipe]),
	(
		OldPipe = none, debug('no pipe in place'); 
		fixedPipe(FixedPipe, X,Y), debug('originally it was [~w]', [FixedPipe]), (
			not(OldPipe=FixedPipe), addToHotbar(OldPipe), debug('transfered ~w from map to hotbar', [OldPipe]);
			error(cannotReplaceFixedPipe), nl, false
		)
	),
	removeFromHotbar(NewPipe),
	debug('~w removed from hotbar', [NewPipe]),
	setPipe(NewPipe, X, Y),
	debug('placed at ~w ~w', [X,Y]),
	writeMap, !.

removePipe(X, Y) :- placePipe(none, X, Y).

:- dynamic xcheckMap/2.
:- dynamic brokenPipe/2.

up(SX, SY, DX, DY) :- DX is SX, DY is SY-1.
down(SX, SY, DX, DY) :- DX is SX, DY is SY+1.
left(SX, SY, DX, DY) :- DX is SX-1, DY is SY.
right(SX, SY, DX, DY) :- DX is SX+1, DY is SY.

inDirection(Dir, SX, SY, DX, DY) :- Dir=n, up(SX, SY, DX, DY).
inDirection(Dir, SX, SY, DX, DY) :- Dir=s, down(SX, SY, DX, DY).
inDirection(Dir, SX, SY, DX, DY) :- Dir=w, left(SX, SY, DX, DY).
inDirection(Dir, SX, SY, DX, DY) :- Dir=e, right(SX, SY, DX, DY).

check(X, Y) :- xcheckMap(X,Y), debug('skip ~w ~w (already checked)', [X,Y]).
check(X, Y) :- currentMap(none, X, Y), debug('skip ~w ~w (none)',[X,Y]), assert(xcheckMap(X, Y)).
check(X, Y) :- assert(xcheckMap(X, Y)), debug('checking ~w ~w', [X,Y]), forall(
	(currentMap(Pipe, X, Y), pipeOutput(Pipe, Output)),
	(
		inDirection(Output, X, Y, CX, CY),
		debug('direction ~w (~w ~w)', [Output, CX, CY]),
		currentMap(CPipe, CX, CY),  
		connection(Output, COutput),
		debug('checking for matching output ~w - ~w', [Output, COutput]),
		(
			pipeOutput(CPipe, COutput),
			debug('matched');

			assert(brokenPipe(X,Y)), writeMsg(connectionBroken, [X, Y, CX, CY, Pipe, CPipe]), nl, false
		),
		!,
		check(CX, CY)
	)
).

check() :- 
	retractall(xcheckMap(_,_)), 
	input(X, Y), 
	debug('Starting check at ~w ~w', [X, Y]),
	check(X, Y).

submitLevel() :-
	check,
	(
		currentLevel(Level), nextLevel(Level, Next), 
		writeMsg(allConnectionsCorrect), initLevel(Next);
		writeMsg(gameOver)
	); writeMap.

resetLevel() :- currentLevel(Level), initLevel(Level).