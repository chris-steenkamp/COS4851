% Determine the sequence of moves to move N disks from
% an origin peg to a destination peg, using a temporary
% peg as a helper. Print the number of moves required.
tower_of_hanoi(N) :-
    move(N, origin, destination, temp, 0, C),
    write('Moving '),
    write(N),
    write(' disks would take '),
    write(C),
    write(' moves.'),
    nl.

% When there is more than one disk on the origin peg,
% move the top N - 1 disks to temp, then move the remaining
% disk to destination peg, then move N - 1 disks from temp
% peg to destination peg. Use tail recursion to count moves.
move(N, Origin, Destination, Temp, Acc, Count) :-
    N > 1,
    M is N - 1,
    move(M, Origin, Temp, Destination, Acc, C1), 
    move(1, Origin, Destination, Temp, C1, C2),
    move(M, Temp, Destination, Origin, C2, Count).
    
% Base case when there is only one disk on a peg to move.
move(1, Origin, Destination, _, Acc, Count) :-
    write('Move top disk from '),
    write(Origin),
    write(' to '),
    write(Destination),
    nl,
    Count is Acc + 1.