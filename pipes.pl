%% Pipe types dict (for checking only).
pipeType(ne).
pipeType(se).
pipeType(sw).
pipeType(nw).
pipeType(nwe).
pipeType(swe).
pipeType(nse).
pipeType(nsw).
pipeType(nswe).
pipeType(we).
pipeType(ns).
pipeType(outN).
pipeType(outS).
pipeType(outW).
pipeType(outE).
pipeType(none).

%% Unicode box-drawing equivalents for map display.
pipeImage(ne, '\u255a').
pipeImage(se, '\u2554').
pipeImage(sw, '\u2557').
pipeImage(nw, '\u255d').
pipeImage(nwe, '\u2569').
pipeImage(swe, '\u2566').
pipeImage(nse, '\u2560').
pipeImage(nsw, '\u2563').
pipeImage(nswe, '\u256c').
pipeImage(we, '\u2550').
pipeImage(ns, '\u2551').
pipeImage(outN, '\u2568').
pipeImage(outS, '\u2565').
pipeImage(outW, '\u2561').
pipeImage(outE, '\u255e').
%% pipeImage(none, '\u00b7').
pipeImage(none, ' ').

%% Direction dict
direction(n).
direction(s).
direction(w).
direction(e).

%% Connections
xconnection(n, s).
xconnection(w, e).
connection(X,Y) :- xconnection(X,Y); xconnection(Y,X).

%% Outputs
pipeOutput(ne, n).
pipeOutput(ne, e).

pipeOutput(se, s).
pipeOutput(se, e).

pipeOutput(sw, s).
pipeOutput(sw, w).

pipeOutput(nw, n).
pipeOutput(nw, w).

pipeOutput(nwe, n).
pipeOutput(nwe, w).
pipeOutput(nwe, e).

pipeOutput(swe, s).
pipeOutput(swe, w).
pipeOutput(swe, e).

pipeOutput(nse, n).
pipeOutput(nse, s).
pipeOutput(nse, e).

pipeOutput(nsw, n).
pipeOutput(nsw, s).
pipeOutput(nsw, w).

pipeOutput(nswe, n).
pipeOutput(nswe, s).
pipeOutput(nswe, w).
pipeOutput(nswe, e).

pipeOutput(we, w).
pipeOutput(we, e).

pipeOutput(ns, n).
pipeOutput(ns, s).

pipeOutput(outN, n).
pipeOutput(outS, s).
pipeOutput(outW, w).
pipeOutput(outE, e).


%% File validation
schemaCheck(pipeImage, forall(pipeImage(P,_),pipeType(P))).
schemaCheck(pipeOutput, forall(pipeOutput(P, D),(pipeType(P), direction(D)))).
schemaCheck(pipeConnection, forall(xconnection(A, B),(direction(A),direction(B)))).