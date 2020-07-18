% number of occurrences of anything in an empty list is 0.
occurrences(_, [], 0).

% number of occurrences of X when X is the head is equal
% to 1 + the number of occurrences of X in the tail.
occurrences(X, [X|T], N) :-
    occurrences(X, T, N2),
    !,
    N is 1 + N2.

% number of occurrences of X when X is not the head is 
% equal to the number of occurrences of X in the tail.
occurrences(X, [_|T], N) :-
    occurrences(X, T, N).
