:- discontiguous(schemaCheck/2).
:- include(settings).
:- include(lang).
:- include(pipes).
:- include(levels).
:- include(logic).
:- include(map).

doSchemaCheck() :- setting(schemaCheck), forall(
	schemaCheck(Module, Check), (Check; error(schemaCheckFailed, [Module]),nl)
), debug('schemas for modules check complete').
:- doSchemaCheck.

:- writeMsg(projectLoaded), nl, nl, writeMsg([bg(yellow)], instructions, []), nl, nl.

startLevel(l1).
init() :- startLevel(Level), initLevel(Level).

:- init.