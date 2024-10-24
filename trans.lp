% trans(TrackID, Facing , Direction, Move)
% trans(TrackID, ComingFrom, GoingTO, Move)

% Type 1 tracks

% straigts
trans(32800, dir(s), dir(s), move_forward).
trans(32800, dir(n), dir(n), move_forward).
trans(1025, dir(e), dir(e), move_forward).
trans(1025, dir(w), dir(w), move_forward).

% curves
trans(4608, dir(e), dir(s), move_forward).
trans(4608, dir(n), dir(w), move_forward).

trans(16386, dir(n), dir(e), move_forward).
trans(16386, dir(w), dir(s), move_forward).

trans(72, dir(s), dir(e), move_forward).
trans(72, dir(w), dir(n), move_forward).

trans(2064, dir(e), dir(n), move_forward).
trans(2064, dir(s), dir(w), move_forward).



% Type 2 tracks

% left hand switches
trans(37408, dir(s), dir(s), move_forward).
trans(37408, dir(n), dir(n), move_forward).
trans(37408, dir(n), dir(w), move_left).
trans(37408, dir(e), dir(s), move_forward).

trans(17411, dir(e), dir(e), move_forward).
trans(17411, dir(w), dir(w), move_forward).
trans(17411, dir(n), dir(e), move_forward).
trans(17411, dir(w), dir(s), move_left).

trans(32872, dir(s), dir(s), move_forward).
trans(32872, dir(n), dir(n), move_forward).
trans(32872, dir(s), dir(e), move_left).
trans(32872, dir(w), dir(n), move_forward).

trans(3089, dir(w), dir(w), move_forward).
trans(3089, dir(e), dir(e), move_forward).
trans(3089, dir(e), dir(n), move_left).
trans(3089, dir(s), dir(w), move_forward).

% right hand switches
trans(49186, dir(n), dir(n), move_forward).
trans(49186, dir(s), dir(s), move_forward).
trans(49186, dir(n), dir(e), move_right).
trans(49186, dir(w), dir(s), move_forward).

trans(1097, dir(e), dir(e), move_forward).
trans(1097, dir(w), dir(w), move_forward).
trans(1097, dir(s), dir(e), move_forward).
trans(1097, dir(w), dir(n), move_right).

trans(34864, dir(s), dir(s), move_forward).
trans(34864, dir(n), dir(n), move_forward).
trans(34864, dir(s), dir(w), move_right).
trans(34864, dir(e), dir(n), move_forward).

trans(5633, dir(w), dir(w), move_forward).
trans(5633, dir(e), dir(e), move_forward).
trans(5633, dir(e), dir(s), move_right).
trans(5633, dir(n), dir(w), move_forward).



% Type 3 tracks
trans(33825, dir(s), dir(s), move_forward).
trans(33825, dir(n), dir(n), move_forward).
trans(33825, dir(e), dir(e), move_forward).
trans(33825, dir(w), dir(w), move_forward).



% Type 4 tracks
trans(38443, dir(n), dir(n), move_forward).
trans(38443, dir(s), dir(s), move_forward).
trans(38443, dir(e), dir(e), move_forward).
trans(38443, dir(w), dir(w), move_forward).
trans(38443, dir(e), dir(s), move_right).
trans(38443, dir(n), dir(w), move_left).

trans(50211, dir(n), dir(n), move_forward).
trans(50211, dir(s), dir(s), move_forward).
trans(50211, dir(e), dir(e), move_forward).
trans(50211, dir(w), dir(w), move_forward).
trans(50211, dir(n), dir(e), move_right).
trans(50211, dir(w), dir(s), move_left).

trans(33897, dir(n), dir(n), move_forward).
trans(33897, dir(s), dir(s), move_forward).
trans(33897, dir(e), dir(e), move_forward).
trans(33897, dir(w), dir(w), move_forward).
trans(33897, dir(s), dir(e), move_left).
trans(33897, dir(w), dir(n), move_right).

trans(35889, dir(n), dir(n), move_forward).
trans(35889, dir(s), dir(s), move_forward).
trans(35889, dir(e), dir(e), move_forward).
trans(35889, dir(w), dir(w), move_forward).
trans(35889, dir(e), dir(n), move_left).
trans(35889, dir(s), dir(w), move_right).



% Type 5 tracks
trans(38505, dir(n), dir(n), move_forward).
trans(38505, dir(s), dir(s), move_forward).
trans(38505, dir(e), dir(e), move_forward).
trans(38505, dir(w), dir(w), move_forward).
trans(38505, dir(s), dir(e), move_left).
trans(38505, dir(w), dir(n), move_right).
trans(38505, dir(e), dir(s), move_right).
trans(38505, dir(n), dir(w), move_left).

trans(52275, dir(n), dir(n), move_forward).
trans(52275, dir(s), dir(s), move_forward).
trans(52275, dir(e), dir(e), move_forward).
trans(52275, dir(w), dir(w), move_forward).
trans(52275, dir(s), dir(w), move_right).
trans(52275, dir(e), dir(n), move_left).
trans(52275, dir(w), dir(s), move_left).
trans(52275, dir(n), dir(e), move_right).



% Type 6 tracks
trans(20994, dir(n), dir(e), move_right).
trans(20994, dir(n), dir(w), move_left).
trans(20994, dir(e), dir(s), move_forward).
trans(20994, dir(w), dir(s), move_forward).

trans(16458, dir(w), dir(n), move_right).
trans(16458, dir(w), dir(s), move_left).
trans(16458, dir(n), dir(e), move_forward).
trans(16458, dir(s), dir(e), move_forward).

trans(2136, dir(s), dir(e), move_left).
trans(2136, dir(s), dir(w), move_right).
trans(2136, dir(w), dir(n), move_forward).
trans(2136, dir(e), dir(n), move_forward).

trans(6672, dir(e), dir(s), move_right).
trans(6672, dir(e), dir(n), move_left).
trans(6672, dir(s), dir(w), move_forward).
trans(6672, dir(n), dir(w), move_forward).