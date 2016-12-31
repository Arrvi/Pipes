:- dynamic setting/1.

setting(useColor).
setting(debug).
setting(drawMap).
setting(schemaCheck).

set(Setting, Value) :- Value =:= 1, retract(setting(Setting)), assert(setting(Setting)); retract(setting(Setting)).

cwrite(Flags, Message, Attr) :- setting(useColor), ansi_format(Flags,Message,Attr); format(Message,Attr).

xerror(Message, Attr) :- cwrite([fg(red),bold], Message, Attr), !.
error(MsgID, Attr) :- message(MsgID, Message), xerror(Message, Attr).
error(MsgID) :- error(MsgID, []).

writeMsg(Format, MsgID, Attr) :- message(MsgID, Message), cwrite(Format, Message, Attr), !; true.
writeMsg(MsgID, Attr) :- writeMsg([], MsgID, Attr).
writeMsg(MsgID) :- writeMsg(MsgID, []).

debug(Message, Attr) :- setting(debug), cwrite([fg(blue)], Message, Attr), nl, !; true.
debug(Message) :- debug(Message, []).