% nothing occurs anywhere in an empty list.
occurs(_, [], _) :- !, fail.

% If X is atomic, L is not a variable, and N is an integer,
% then return true if X occurs at postition N in L.
occurs(N, L, X) :-
    integer(N),
    nonvar(L),
    atomic(X),
    !,
    % create a "list" term which has as arguments all the elements of L
    L2 =.. [list|L],
    % determine if X is the Nth argument of the newly created term L2
    arg(N, L2, X).