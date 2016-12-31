:- discontiguous(level/1).
:- discontiguous(mapWidth/2).
:- discontiguous(mapHeight/2).
:- discontiguous(map/4).
:- discontiguous(mapInput/3).
:- discontiguous(mapItem/3).
:- discontiguous(nextLevel/2).

level(l1).

mapWidth(l1, 6).
mapHeight(l1, 4).
map(l1, outE, 0, 1).
map(l1, we, 1, 1).
map(l1, ne, 3, 2).
map(l1, outW, 5, 2).
mapInput(l1, 0, 1).
mapItem(l1, we, 2).
mapItem(l1, sw, 1).

nextLevel(l1, l2).

level(l2).
mapWidth(l2, 5).
mapHeight(l2, 5).
map(l2, outE, 0, 1).
map(l2, nw, 1, 1).
map(l2, outN, 2, 4).
mapInput(l2, 0, 1).
mapItem(l2, se, 2).
mapItem(l2, sw, 2).
mapItem(l2, ne, 1).
mapItem(l2, sw, 1).
mapItem(l2, ns, 1).

nextLevel(l2, l3).

level(l3).
mapWidth(l3, 6).
mapHeight(l3, 4).
map(l3, outE, 0, 1).
map(l3, ns, 3,1).
map(l3, outW, 5,1).
mapInput(l3, 0,1).
mapItem(l3, sw, 2).
mapItem(l3, ne, 1).
mapItem(l3, we, 1).
mapItem(l3, nwe, 1).
mapItem(l3, nw, 1).
mapItem(l3, se, 1).
mapItem(l3, nse, 1).




schemaCheck(mapWidth, forall(mapWidth(L, W), (level(L),W>0))).
schemaCheck(mapHeight, forall(mapHeight(L, H), (level(L),H>0))).

schemaCheck(levelMap, forall(map(L, P, X, Y), (
	mapWidth(L, W),
	mapHeight(L, H),
	level(L),
	pipeType(P),
	X>=0, X<W,
	Y>=0, Y<H
))).

schemaCheck(mapInput, forall(mapInput(L, X, Y), (
	mapWidth(L, W),
	mapHeight(L, H),
	level(L),
	X>=0, X<W,
	Y>=0, Y<H
))).

schemaCheck(mapItem, forall(mapItem(L, P, C), (
	level(L),
	pipeType(P),
	C>0
))).

schemaCheck(nextLevel, forall(nextLevel(A,B), (level(A), level(B)))).

schemaCheck(levelStructure, forall(level(L),(
	mapWidth(L, _), mapHeight(L, _),
	map(L, _, _, _),
	mapInput(L, _, _),
	mapItem(L, _, _)
))).