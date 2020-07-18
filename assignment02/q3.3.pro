% If X is atomic, L is not a variable, and N is an integer, then
% return true if the number of occurrences of X in L is equal to N.
occurrences(X, L, N) :-
    atomic(X),
    nonvar(L),
    integer(N),
    !,
    % create list of all occurrences of X within L
    findall(X, member(X, L) , L2),
    % check that length of new list is equal to N
    length(L2, N).