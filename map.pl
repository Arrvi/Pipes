writePipe(X, Y) :- 
	currentMap(Pipe, X, Y), 
	pipeImage(Pipe, Image),
	(input(X,Y),cwrite([bg(cyan)], Image, []);
	brokenPipe(X,Y),cwrite([bg(red)], Image, []);
	not(isFixed(X,Y)),cwrite([fg(cyan)], Image, []);
	write(Image)).

writeMapRow(Level, Y) :-
	mapWidth(Level, W),
	W2 is W-1,
	write(Y),
	forall(
		between(0, W2, X),
		writePipe(X, Y)
	).

writeMapGrid(Level) :- 
	mapHeight(Level, H),
	H2 is H-1,
	write('\\'),
	forall(
		(mapWidth(Level, W), W2 is W-1, between(0, W2, X)), 
		write(X)
	), nl,
	forall(
		between(0, H2, Y), 
		(writeMapRow(Level, Y), nl)
	).

writeHotbar() :- writeMsg(availableItems), nl, forall(
	hotbar(Pipe, Count), 
	(
		pipeImage(Pipe, Image), (Count > 0, Format=[]; Format=[hfg(black),bg(white)]),
		cwrite(Format, '~w (~w) x~w\n', [Image, Pipe, Count])
	)
).

writeMap() :- not(currentLevel(_)), error(noLevelLoaded), retractall(brokenPipe(_,_)).
writeMap() :- 
	currentLevel(Level), 
	writeMapGrid(Level), nl,
	writeHotbar, retractall(brokenPipe(_,_)).