cell((0,0), 16386).
cell((1,0), 20994).
cell((2,0), 4608).
cell((0,1), 16458).
cell((1,1), 33825).
cell((2,1), 6672).
cell((0,2), 72).
cell((1,2), 2136).
cell((2,2), 2064).

train(0).

start(0, (2,2), 1, e).
end(0, (2,0), 12).

train(1).

start(1, (0,0), 1, w).
end(1, (0,2), 13).
% try with LA = 20 instead of 13 to see unnessecary wiating happen