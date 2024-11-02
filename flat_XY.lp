% given predicates
% start(ID, (Y,X), EarliestDeparture, Direction)
% end(ID, (Y,X), LatestArrival)
% cell((Y,X), TrackID)

% created predicates
% action(train(ID), Move, Timestep)
% position(ID, (Y,X), Direction, Timestep)
% trans(TrackID, IncomingDirection, OutgoingDirection, Move)



% valid moves
move(move_forward).
move(move_left).
move(move_right).
move(wait).



% Generate actions for path
% action(train(ID), Move, Timestep)
{ action(train(ID), M, T) : move(M), T = ED..LA } N :- start(ID, _, ED, _),  end(ID, _, LA), N=LA-ED.



% deduce positions from actions taken

% start and waits
position(ID, (X,Y), D, T) :- start(ID, (X,Y), T, D).
position(ID, (X,Y), D, TN) :- position(ID, (X,Y), D, TO), action(train(ID), wait, TO) , TN = TO+1.

% straights
position(ID, (XN,YN), n, TN) :- position(ID, (XO,YO), n, TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, n, n, move_forward), XN=XO-1, YN=YO, TN=TO+1.
position(ID, (XN,YN), e, TN) :- position(ID, (XO,YO), e, TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, e, e, move_forward), XN=XO, YN=YO+1, TN=TO+1.
position(ID, (XN,YN), s, TN) :- position(ID, (XO,YO), s, TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, s, s, move_forward), XN=XO+1, YN=YO, TN=TO+1.
position(ID, (XN,YN), w, TN) :- position(ID, (XO,YO), w, TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, w, w, move_forward), XN=XO, YN=YO-1, TN=TO+1.

% curves
position(ID, (XN,YN), e, TN) :- position(ID, (XO,YO), n, TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, n, e, move_forward), XN=XO, YN=YO+1, TN=TO+1.
position(ID, (XN,YN), w, TN) :- position(ID, (XO,YO), n, TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, n, w, move_forward), XN=XO, YN=YO-1, TN=TO+1.
position(ID, (XN,YN), n, TN) :- position(ID, (XO,YO), e, TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, e, n, move_forward), XN=XO-1, YN=YO, TN=TO+1.
position(ID, (XN,YN), s, TN) :- position(ID, (XO,YO), e, TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, e, s, move_forward), XN=XO+1, YN=YO, TN=TO+1.
position(ID, (XN,YN), e, TN) :- position(ID, (XO,YO), s, TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, s, e, move_forward), XN=XO, YN=YO+1, TN=TO+1.
position(ID, (XN,YN), w, TN) :- position(ID, (XO,YO), s, TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, s, w, move_forward), XN=XO, YN=YO-1, TN=TO+1.
position(ID, (XN,YN), n, TN) :- position(ID, (XO,YO), w, TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, w, n, move_forward), XN=XO-1, YN=YO, TN=TO+1.
position(ID, (XN,YN), s, TN) :- position(ID, (XO,YO), w, TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, w, s, move_forward), XN=XO+1, YN=YO, TN=TO+1.

% left turns
position(ID, (XN,YN), w, TN) :- position(ID, (XO,YO), n, TO), action(train(ID), move_left, TO), cell((XO,YO), TID), trans(TID, n, w, move_left), XN=XO, YN=YO-1, TN=TO+1.
position(ID, (XN,YN), n, TN) :- position(ID, (XO,YO), e, TO), action(train(ID), move_left, TO), cell((XO,YO), TID), trans(TID, e, n, move_left), XN=XO-1, YN=YO, TN=TO+1.
position(ID, (XN,YN), e, TN) :- position(ID, (XO,YO), s, TO), action(train(ID), move_left, TO), cell((XO,YO), TID), trans(TID, s, e, move_left), XN=XO, YN=YO+1, TN=TO+1.
position(ID, (XN,YN), s, TN) :- position(ID, (XO,YO), w, TO), action(train(ID), move_left, TO), cell((XO,YO), TID), trans(TID, w, s, move_left), XN=XO+1, YN=YO, TN=TO+1.

%right turns
position(ID, (XN,YN), e, TN) :- position(ID, (XO,YO), n, TO), action(train(ID), move_right, TO), cell((XO,YO), TID), trans(TID, n, e, move_right), XN=XO, YN=YO+1, TN=TO+1.
position(ID, (XN,YN), s, TN) :- position(ID, (XO,YO), e, TO), action(train(ID), move_right, TO), cell((XO,YO), TID), trans(TID, e, s, move_right), XN=XO+1, YN=YO, TN=TO+1.
position(ID, (XN,YN), w, TN) :- position(ID, (XO,YO), s, TO), action(train(ID), move_right, TO), cell((XO,YO), TID), trans(TID, s, w, move_right), XN=XO, YN=YO-1, TN=TO+1.
position(ID, (XN,YN), n, TN) :- position(ID, (XO,YO), w, TO), action(train(ID), move_right, TO), cell((XO,YO), TID), trans(TID, w, n, move_right), XN=XO-1, YN=YO, TN=TO+1.



%constraints

% the train reaches the end point
:- end(ID, (X,Y), _), not position(ID, (X,Y), _, _).

% the train reaches the end point before or at the latest arrival
:- end(ID, _, LA), position(ID, _, _,T), T>LA.

% the train dissapeears after reaching the endpoint
:- end(ID, (X,Y), _), position(ID, (X,Y), _, TA), position(ID, _, _, TB), TB>TA.

% for all preciding timesteps there is a predicate of this type for this train
:- action(train(ID), _, TA), not action(train(ID), _, TB), start(ID, _, TS, _), TA == TB+1, TA>TS.
:- position(ID, _, _, TA), not position(ID, _, _, TB), start(ID, _, TS, _), TA == TB+1, TA>TS.

% at every time step ther is only one predicate of this type each train
:- action(train(ID), MA, T), action(train(ID), MB, T), MA != MB.
:- position(ID, (XA, YA), D, T), position(ID, (XB, YB), D, T), XA != XB.
:- position(ID, (XA, YA), D, T), position(ID, (XB, YB), D, T), YA != YB.

% every action is a valid move according to the transitions allowed by the tracks
:- position(ID, (X,Y), D, T), cell((X,Y), TID), not trans(TID, D, _, M), action(train(ID), M, T), not M = wait.

% two trains cant occupy the same position at the same time
:- position(IDA, (X,Y), _, T), position(IDB, (X,Y), _, T), IDA != IDB.

% a train cannot move into a cell where a train was in the previous time step
:- position(IDA, (XA,YA), _, TA), position(IDB, (XB,YB), _, TA), position(IDA, (XB,YB), _, TB), position(IDB, (XA,YA), _, TB), IDA != IDB, TB=TA+1.



% optimizations

% minimize number of actions taken
#minimize { 1 : action(train(ID), _, _) }.



% show statements
%#show position/4.
#show action/3.



% TODO:

% MUST HAVE
% change starting behaviour to spawn in after an move_forward action if the cell is empty