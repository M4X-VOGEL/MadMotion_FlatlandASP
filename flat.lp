%Hard coded limit for path generating
lim(12).

move(move_forward).
move(move_left).
move(move_right).
move(wait).



% Generate actions
% action(trainID, Move, TimeStep)
{ action(train(ID), M, T) : move(M), T = 0..N } N :- train(ID),  lim(N).



% position(trainID, TimeStep, (X,Y))

% start and waits
position(train(ID), (X,Y), F, T) :- start(train(ID), (X,Y), T, F).
position(train(ID), (X,Y), F, TN) :- position(train(ID), (X,Y), F, TO), action(train(ID), wait, TO) , TN = TO+1.

% straights
position(train(ID), (XN,YN), dir(n), TN) :- position(train(ID), (XO,YO), dir(n), TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, dir(n), dir(n), move_forward), XN=XO-1, YN=YO, TN=TO+1.
position(train(ID), (XN,YN), dir(e), TN) :- position(train(ID), (XO,YO), dir(e), TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, dir(e), dir(e), move_forward), XN=XO, YN=YO+1, TN=TO+1.
position(train(ID), (XN,YN), dir(s), TN) :- position(train(ID), (XO,YO), dir(s), TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, dir(s), dir(s), move_forward), XN=XO+1, YN=YO, TN=TO+1.
position(train(ID), (XN,YN), dir(w), TN) :- position(train(ID), (XO,YO), dir(w), TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, dir(w), dir(w), move_forward), XN=XO, YN=YO-1, TN=TO+1.

% curves
position(train(ID), (XN,YN), dir(e), TN) :- position(train(ID), (XO,YO), dir(n), TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, dir(n), dir(e), move_forward), XN=XO, YN=YO+1, TN=TO+1.
position(train(ID), (XN,YN), dir(w), TN) :- position(train(ID), (XO,YO), dir(n), TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, dir(n), dir(w), move_forward), XN=XO, YN=YO-1, TN=TO+1.
position(train(ID), (XN,YN), dir(n), TN) :- position(train(ID), (XO,YO), dir(e), TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, dir(e), dir(n), move_forward), XN=XO-1, YN=YO, TN=TO+1.
position(train(ID), (XN,YN), dir(s), TN) :- position(train(ID), (XO,YO), dir(e), TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, dir(e), dir(s), move_forward), XN=XO+1, YN=YO, TN=TO+1.
position(train(ID), (XN,YN), dir(e), TN) :- position(train(ID), (XO,YO), dir(s), TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, dir(s), dir(e), move_forward), XN=XO, YN=YO+1, TN=TO+1.
position(train(ID), (XN,YN), dir(w), TN) :- position(train(ID), (XO,YO), dir(s), TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, dir(s), dir(w), move_forward), XN=XO, YN=YO-1, TN=TO+1.
position(train(ID), (XN,YN), dir(n), TN) :- position(train(ID), (XO,YO), dir(w), TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, dir(w), dir(n), move_forward), XN=XO-1, YN=YO, TN=TO+1.
position(train(ID), (XN,YN), dir(s), TN) :- position(train(ID), (XO,YO), dir(w), TO), action(train(ID), move_forward, TO), cell((XO,YO), TID), trans(TID, dir(w), dir(s), move_forward), XN=XO+1, YN=YO, TN=TO+1.

% left turns
position(train(ID), (XN,YN), dir(w), TN) :- position(train(ID), (XO,YO), dir(n), TO), action(train(ID), move_left, TO), cell((XO,YO), TID), trans(TID, dir(n), dir(w), move_left), XN=XO, YN=YO-1, TN=TO+1.
position(train(ID), (XN,YN), dir(n), TN) :- position(train(ID), (XO,YO), dir(e), TO), action(train(ID), move_left, TO), cell((XO,YO), TID), trans(TID, dir(e), dir(n), move_left), XN=XO-1, YN=YO, TN=TO+1.
position(train(ID), (XN,YN), dir(e), TN) :- position(train(ID), (XO,YO), dir(s), TO), action(train(ID), move_left, TO), cell((XO,YO), TID), trans(TID, dir(s), dir(e), move_left), XN=XO, YN=YO+1, TN=TO+1.
position(train(ID), (XN,YN), dir(s), TN) :- position(train(ID), (XO,YO), dir(w), TO), action(train(ID), move_left, TO), cell((XO,YO), TID), trans(TID, dir(w), dir(s), move_left), XN=XO+1, YN=YO, TN=TO+1.

%right turns
position(train(ID), (XN,YN), dir(e), TN) :- position(train(ID), (XO,YO), dir(n), TO), action(train(ID), move_right, TO), cell((XO,YO), TID), trans(TID, dir(n), dir(e), move_right), XN=XO, YN=YO+1, TN=TO+1.
position(train(ID), (XN,YN), dir(s), TN) :- position(train(ID), (XO,YO), dir(e), TO), action(train(ID), move_right, TO), cell((XO,YO), TID), trans(TID, dir(e), dir(s), move_right), XN=XO+1, YN=YO, TN=TO+1.
position(train(ID), (XN,YN), dir(w), TN) :- position(train(ID), (XO,YO), dir(s), TO), action(train(ID), move_right, TO), cell((XO,YO), TID), trans(TID, dir(s), dir(w), move_right), XN=XO, YN=YO-1, TN=TO+1.
position(train(ID), (XN,YN), dir(n), TN) :- position(train(ID), (XO,YO), dir(w), TO), action(train(ID), move_right, TO), cell((XO,YO), TID), trans(TID, dir(w), dir(n), move_right), XN=XO-1, YN=YO, TN=TO+1.



%constraints

% for al preciding timesteps there is a predicate of this type for this train
:- action(TR, _, TA), not action(TR, _, TB), TA == TB+1, TA!=0.
:- position(TR, _, _, TA), not position(TR, _, _, TB), TA == TB+1, TA!=0.

% at every time step ther is exactly one predicate of this type each train
:- action(TR, MA, T), action(TR, MB, T), MA != MB.
:- position(TR, (XA, YA), F, T), position(TR, (XB, YB), F, T), XA != XB.
:- position(TR, (XA, YA), F, T), position(TR, (XB, YB), F, T), YA != YB.

% every action is a valid move according to the transitions allowed by the tracks
:- position(TR, (X,Y), F, T), cell((X,Y), TID), not trans(TID, F, _, M), action(TR, M, T), not M = wait.

% two trains cant occupy the same position at the same time
:- position(TRA, (X,Y), F, T), position(TRB, (X,Y), F, T), TRA != TRB.

% the train reaches the end point
:- end(TR, (X,Y), LA), not position(TR, (X,Y), _, _).

% the train stops at the end point
:- end(TR, (XA,YA), _), position(TR, (XA,YA), _, TA), position(TR, (XB,YB), _, TB), XA != XB, TB>TA.
:- end(TR, (XA,YA), _), position(TR, (XA,YA), _, TA), position(TR, (XB,YB), _, TB), YA != YB, TB>TA.



%#show position/4.
#show action/3.
