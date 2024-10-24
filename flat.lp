%Hard coded limit for path generating
lim(14).

move(move_forward).
move(move_left).
move(move_right).
move(wait).



% Generate actions
% action(trainID, Move, TimeStep)
{ action(ID, M, T) : move(M), T = TS..N } N :- start(ID, _, TS, _),  lim(N).


% position(trainID, TimeStep, (X,Y))

% start and waits
position(ID, (X,Y), F, T) :- start(ID, (X,Y), T, F).
position(ID, (X,Y), F, TN) :- position(ID, (X,Y), F, TO), action(ID, wait, TO) , TN = TO+1.

% straights
position(ID, (XN,YN), dir(n), TN) :- position(ID, (XO,YO), dir(n), TO), action(ID, move_forward, TO), cell((XO,YO), TID), trans(TID, dir(n), dir(n), move_forward), XN=XO-1, YN=YO, TN=TO+1.
position(ID, (XN,YN), dir(e), TN) :- position(ID, (XO,YO), dir(e), TO), action(ID, move_forward, TO), cell((XO,YO), TID), trans(TID, dir(e), dir(e), move_forward), XN=XO, YN=YO+1, TN=TO+1.
position(ID, (XN,YN), dir(s), TN) :- position(ID, (XO,YO), dir(s), TO), action(ID, move_forward, TO), cell((XO,YO), TID), trans(TID, dir(s), dir(s), move_forward), XN=XO+1, YN=YO, TN=TO+1.
position(ID, (XN,YN), dir(w), TN) :- position(ID, (XO,YO), dir(w), TO), action(ID, move_forward, TO), cell((XO,YO), TID), trans(TID, dir(w), dir(w), move_forward), XN=XO, YN=YO-1, TN=TO+1.

% curves
position(ID, (XN,YN), dir(e), TN) :- position(ID, (XO,YO), dir(n), TO), action(ID, move_forward, TO), cell((XO,YO), TID), trans(TID, dir(n), dir(e), move_forward), XN=XO, YN=YO+1, TN=TO+1.
position(ID, (XN,YN), dir(w), TN) :- position(ID, (XO,YO), dir(n), TO), action(ID, move_forward, TO), cell((XO,YO), TID), trans(TID, dir(n), dir(w), move_forward), XN=XO, YN=YO-1, TN=TO+1.
position(ID, (XN,YN), dir(n), TN) :- position(ID, (XO,YO), dir(e), TO), action(ID, move_forward, TO), cell((XO,YO), TID), trans(TID, dir(e), dir(n), move_forward), XN=XO-1, YN=YO, TN=TO+1.
position(ID, (XN,YN), dir(s), TN) :- position(ID, (XO,YO), dir(e), TO), action(ID, move_forward, TO), cell((XO,YO), TID), trans(TID, dir(e), dir(s), move_forward), XN=XO+1, YN=YO, TN=TO+1.
position(ID, (XN,YN), dir(e), TN) :- position(ID, (XO,YO), dir(s), TO), action(ID, move_forward, TO), cell((XO,YO), TID), trans(TID, dir(s), dir(e), move_forward), XN=XO, YN=YO+1, TN=TO+1.
position(ID, (XN,YN), dir(w), TN) :- position(ID, (XO,YO), dir(s), TO), action(ID, move_forward, TO), cell((XO,YO), TID), trans(TID, dir(s), dir(w), move_forward), XN=XO, YN=YO-1, TN=TO+1.
position(ID, (XN,YN), dir(n), TN) :- position(ID, (XO,YO), dir(w), TO), action(ID, move_forward, TO), cell((XO,YO), TID), trans(TID, dir(w), dir(n), move_forward), XN=XO-1, YN=YO, TN=TO+1.
position(ID, (XN,YN), dir(s), TN) :- position(ID, (XO,YO), dir(w), TO), action(ID, move_forward, TO), cell((XO,YO), TID), trans(TID, dir(w), dir(s), move_forward), XN=XO+1, YN=YO, TN=TO+1.

% left turns
position(ID, (XN,YN), dir(w), TN) :- position(ID, (XO,YO), dir(n), TO), action(ID, move_left, TO), cell((XO,YO), TID), trans(TID, dir(n), dir(w), move_left), XN=XO, YN=YO-1, TN=TO+1.
position(ID, (XN,YN), dir(n), TN) :- position(ID, (XO,YO), dir(e), TO), action(ID, move_left, TO), cell((XO,YO), TID), trans(TID, dir(e), dir(n), move_left), XN=XO-1, YN=YO, TN=TO+1.
position(ID, (XN,YN), dir(e), TN) :- position(ID, (XO,YO), dir(s), TO), action(ID, move_left, TO), cell((XO,YO), TID), trans(TID, dir(s), dir(e), move_left), XN=XO, YN=YO+1, TN=TO+1.
position(ID, (XN,YN), dir(s), TN) :- position(ID, (XO,YO), dir(w), TO), action(ID, move_left, TO), cell((XO,YO), TID), trans(TID, dir(w), dir(s), move_left), XN=XO+1, YN=YO, TN=TO+1.

%right turns
position(ID, (XN,YN), dir(e), TN) :- position(ID, (XO,YO), dir(n), TO), action(ID, move_right, TO), cell((XO,YO), TID), trans(TID, dir(n), dir(e), move_right), XN=XO, YN=YO+1, TN=TO+1.
position(ID, (XN,YN), dir(s), TN) :- position(ID, (XO,YO), dir(e), TO), action(ID, move_right, TO), cell((XO,YO), TID), trans(TID, dir(e), dir(s), move_right), XN=XO+1, YN=YO, TN=TO+1.
position(ID, (XN,YN), dir(w), TN) :- position(ID, (XO,YO), dir(s), TO), action(ID, move_right, TO), cell((XO,YO), TID), trans(TID, dir(s), dir(w), move_right), XN=XO, YN=YO-1, TN=TO+1.
position(ID, (XN,YN), dir(n), TN) :- position(ID, (XO,YO), dir(w), TO), action(ID, move_right, TO), cell((XO,YO), TID), trans(TID, dir(w), dir(n), move_right), XN=XO-1, YN=YO, TN=TO+1.



%constraints

% every train has a position for the last time step
:- lim(T), train(ID), not position(ID, _, _,T).

% for all preciding timesteps there is a predicate of this type for this train
:- action(ID, _, TA), not action(ID, _, TB), start(ID, _, TS, _), TA == TB+1, TA>TS.
:- position(ID, _, _, TA), not position(ID, _, _, TB), start(ID, _, TS, _), TA == TB+1, TA>TS.

% at every time step ther is only one predicate of this type each train
:- action(ID, MA, T), action(ID, MB, T), MA != MB.
:- position(ID, (XA, YA), F, T), position(ID, (XB, YB), F, T), XA != XB.
:- position(ID, (XA, YA), F, T), position(ID, (XB, YB), F, T), YA != YB.

% every action is a valid move according to the transitions allowed by the tracks
:- position(ID, (X,Y), F, T), cell((X,Y), TID), not trans(TID, F, _, M), action(ID, M, T), not M = wait.

% two trains cant occupy the same position at the same time
:- position(IDA, (X,Y), _, T), position(IDB, (X,Y), _, T), IDA != IDB.

% a train cannot move into a cell where a train was in the previous time step
:- position(IDA, (X,Y), _, TA), position(IDB, (X,Y), _, TB), IDA != IDB, TB=TA+1.

% the train reaches the end point
:- end(ID, (X,Y), LA), not position(ID, (X,Y), _, _).

% the train stops at the end point
:- end(ID, (XA,YA), _), position(ID, (XA,YA), _, TA), position(ID, (XB,YB), _, TB), XA != XB, TB>TA.
:- end(ID, (XA,YA), _), position(ID, (XA,YA), _, TA), position(ID, (XB,YB), _, TB), YA != YB, TB>TA.

#show position/4.
#show action/3.