in_list(X, [X|_]).

in_list(X, [_|T]) :-
    in_list(X, T).

% the difference between the empty set and anything is the empty set.
difference([], _, []).

% if an element is in A and also in the resultant list L then it mustn't be in B.
% the remaining elements of A and L must also be processed and checked.
difference([AH|AT], B, [AH|LT]) :-
    not(in_list(AH, B)),
    difference(AT, B, LT).

% if an element of A is also in B, then it can't be in L, so we process the
% remaining elements of A.
difference([AH|AT], B, L) :-
    in_list(AH, B),
    difference(AT, B, L).
