% assignment predicates
% start(ID, (Y,X), EarliestDeparture, Direction)
% end(ID, (Y,X), LatestArrival)
% cell((Y,X), TrackID)

% custom predicates
% action(train(ID), Move, Timestep)
% position(ID, (Y,X), Direction, Timestep)
% trans(TrackID, IncomingDirection, OutgoingDirection, Move)



% valid moves
move(move_forward).
move(move_left).
move(move_right).
move(wait).



% Generate actions for path
{ action(train(ID), M, T) : move(M), T = ED..LA } N :- start(ID, _, ED, _),  end(ID, _, LA), N=LA-ED.



% deduce positions from actions

% start and waits
position(ID, (Y,X), D, T) :- start(ID, (Y,X), T, D).
position(ID, (Y,X), D, TN) :- position(ID, (Y,X), D, TO), action(train(ID), wait, TO) , TN = TO+1.

% straights
position(ID, (YN,XN), n, TN) :- position(ID, (YO,XO), n, TO), action(train(ID), move_forward, TO), cell((YO,XO), TID), trans(TID, n, n, move_forward), XN=XO-1, YN=YO, TN=TO+1.
position(ID, (YN,XN), e, TN) :- position(ID, (YO,XO), e, TO), action(train(ID), move_forward, TO), cell((YO,XO), TID), trans(TID, e, e, move_forward), XN=XO, YN=YO+1, TN=TO+1.
position(ID, (YN,XN), s, TN) :- position(ID, (YO,XO), s, TO), action(train(ID), move_forward, TO), cell((YO,XO), TID), trans(TID, s, s, move_forward), XN=XO+1, YN=YO, TN=TO+1.
position(ID, (YN,XN), w, TN) :- position(ID, (YO,XO), w, TO), action(train(ID), move_forward, TO), cell((YO,XO), TID), trans(TID, w, w, move_forward), XN=XO, YN=YO-1, TN=TO+1.

% curves
position(ID, (YN,XN), e, TN) :- position(ID, (YO,XO), n, TO), action(train(ID), move_forward, TO), cell((YO,XO), TID), trans(TID, n, e, move_forward), XN=XO, YN=YO+1, TN=TO+1.
position(ID, (YN,XN), w, TN) :- position(ID, (YO,XO), n, TO), action(train(ID), move_forward, TO), cell((YO,XO), TID), trans(TID, n, w, move_forward), XN=XO, YN=YO-1, TN=TO+1.
position(ID, (YN,XN), n, TN) :- position(ID, (YO,XO), e, TO), action(train(ID), move_forward, TO), cell((YO,XO), TID), trans(TID, e, n, move_forward), XN=XO-1, YN=YO, TN=TO+1.
position(ID, (YN,XN), s, TN) :- position(ID, (YO,XO), e, TO), action(train(ID), move_forward, TO), cell((YO,XO), TID), trans(TID, e, s, move_forward), XN=XO+1, YN=YO, TN=TO+1.
position(ID, (YN,XN), e, TN) :- position(ID, (YO,XO), s, TO), action(train(ID), move_forward, TO), cell((YO,XO), TID), trans(TID, s, e, move_forward), XN=XO, YN=YO+1, TN=TO+1.
position(ID, (YN,XN), w, TN) :- position(ID, (YO,XO), s, TO), action(train(ID), move_forward, TO), cell((YO,XO), TID), trans(TID, s, w, move_forward), XN=XO, YN=YO-1, TN=TO+1.
position(ID, (YN,XN), n, TN) :- position(ID, (YO,XO), w, TO), action(train(ID), move_forward, TO), cell((YO,XO), TID), trans(TID, w, n, move_forward), XN=XO-1, YN=YO, TN=TO+1.
position(ID, (YN,XN), s, TN) :- position(ID, (YO,XO), w, TO), action(train(ID), move_forward, TO), cell((YO,XO), TID), trans(TID, w, s, move_forward), XN=XO+1, YN=YO, TN=TO+1.

% left turns
position(ID, (YN,XN), w, TN) :- position(ID, (YO,XO), n, TO), action(train(ID), move_left, TO), cell((YO,XO), TID), trans(TID, n, w, move_left), XN=XO, YN=YO-1, TN=TO+1.
position(ID, (YN,XN), n, TN) :- position(ID, (YO,XO), e, TO), action(train(ID), move_left, TO), cell((YO,XO), TID), trans(TID, e, n, move_left), XN=XO-1, YN=YO, TN=TO+1.
position(ID, (YN,XN), e, TN) :- position(ID, (YO,XO), s, TO), action(train(ID), move_left, TO), cell((YO,XO), TID), trans(TID, s, e, move_left), XN=XO, YN=YO+1, TN=TO+1.
position(ID, (YN,XN), s, TN) :- position(ID, (YO,XO), w, TO), action(train(ID), move_left, TO), cell((YO,XO), TID), trans(TID, w, s, move_left), XN=XO+1, YN=YO, TN=TO+1.

%right turns
position(ID, (YN,XN), e, TN) :- position(ID, (YO,XO), n, TO), action(train(ID), move_right, TO), cell((YO,XO), TID), trans(TID, n, e, move_right), XN=XO, YN=YO+1, TN=TO+1.
position(ID, (YN,XN), s, TN) :- position(ID, (YO,XO), e, TO), action(train(ID), move_right, TO), cell((YO,XO), TID), trans(TID, e, s, move_right), XN=XO+1, YN=YO, TN=TO+1.
position(ID, (YN,XN), w, TN) :- position(ID, (YO,XO), s, TO), action(train(ID), move_right, TO), cell((YO,XO), TID), trans(TID, s, w, move_right), XN=XO, YN=YO-1, TN=TO+1.
position(ID, (YN,XN), n, TN) :- position(ID, (YO,XO), w, TO), action(train(ID), move_right, TO), cell((YO,XO), TID), trans(TID, w, n, move_right), XN=XO-1, YN=YO, TN=TO+1.



%constraints

% train reaches endpoint
:- end(ID, (Y,X), _), not position(ID, (Y,X), _, _).

% no position after latest arrival
:- end(ID, _, LA), position(ID, _, _,T), T>LA.

% no position after reaching endpoint
:- end(ID, (Y,X), _), position(ID, (Y,X), _, TA), position(ID, _, _, TB), TB>TA.

% all actions and positions must have a predecessor (excluding start)
:- action(train(ID), _, TA), not action(train(ID), _, TB), start(ID, _, TS, _), TB == TA-1, TA>TS.
:- position(ID, _, _, TA), not position(ID, _, _, TB), start(ID, _, TS, _), TB == TA-1, TA>TS.

% unique actions and positions at every time step
:- action(train(ID), MA, T), action(train(ID), MB, T), MA != MB.
:- position(ID, (YA, XA), D, T), position(ID, (YB, XB), D, T), XA != XB.
:- position(ID, (YA, XA), D, T), position(ID, (YB, XB), D, T), YA != YB.

% train makes valid transition on non-wait move
:- position(ID, (Y,X), D, T), cell((Y,X), TID), not trans(TID, D, _, M), action(train(ID), M, T), not M = wait.

% multiple trains cannot occupy same position at same time
:- position(IDA, (Y,X), _, T), position(IDB, (Y,X), _, T), IDA != IDB.

% two trains cannot swap positions
:- position(IDA, (YA,XA), _, TA), position(IDB, (YB,XB), _, TA), position(IDA, (YB,XB), _, TB), position(IDB, (YA,XA), _, TB), IDA != IDB, TB=TA+1.



% optimizations

% minimize number of actions
#minimize { 1 : action(train(ID), _, _) }.



% show statements
#show position/4.
%#show action/3.



% TODO:

% MUST HAVE
% change starting behaviour to spawn in after an move_forward action if the cell is empty