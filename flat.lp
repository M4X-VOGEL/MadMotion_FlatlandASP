move(move_forward).
move(move_left).
move(move_right).
move(wait).



% Generate actions
% action(train(ID), Move, Timestep)
{ action(train(ID), M, T) : move(M), T = ED..LA } N :- start(ID, _, ED, _),  end(ID, _, LA), N=LA-ED.



% position(ID, (Y,X), Direction, Timestep)

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

% the train reaches the end point
:- end(ID, (Y,X), _), not position(ID, (Y,X), _, _).

% the train reaches the end point before the latest arrival or on time
:- end(ID, _, LA), position(ID, _, _,T), T>LA.

% the train dissapeears after reaching the endpoint
:- end(ID, (Y,X), _), position(ID, (Y,X), _, TA), position(ID, _, _, TB), TB>TA.

% for all preciding timesteps there is a predicate of this type for this train
:- action(train(ID), _, TA), not action(train(ID), _, TB), start(ID, _, TS, _), TA == TB+1, TA>TS.
:- position(ID, _, _, TA), not position(ID, _, _, TB), start(ID, _, TS, _), TA == TB+1, TA>TS.

% at every time step ther is only one predicate of this type each train
:- action(train(ID), MA, T), action(train(ID), MB, T), MA != MB.
:- position(ID, (YA, XA), D, T), position(ID, (YB, XB), D, T), XA != XB.
:- position(ID, (YA, XA), D, T), position(ID, (YB, XB), D, T), YA != YB.

% every action is a valid move according to the transitions allowed by the tracks
:- position(ID, (Y,X), D, T), cell((Y,X), TID), not trans(TID, D, _, M), action(train(ID), M, T), not M = wait.

% two trains cant occupy the same position at the same time
:- position(IDA, (Y,X), _, T), position(IDB, (Y,X), _, T), IDA != IDB.

% a train cannot move into a cell where a train was in the previous time step
:- position(IDA, (YA,XA), _, TA), position(IDB, (YB,XB), _, TA), position(IDA, (YB,XB), _, TB), position(IDB, (YA,XA), _, TB), IDA != IDB, TB=TA+1.



% optimization

% minimize waits
#minimize { 1 : action(_, wait, _) }.


% show statements
#show position/4.
%#show action/3.


% MUST HAVE
% change starting behaviour to spawn in after an moveforward action if the cell is empty
% why does it wait unnessecariyl for train 2 in env 2 if LA is way bigger then needed

% OPTIONAL
% train only waits if next track is not a straigh or simple curve