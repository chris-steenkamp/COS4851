% The difference of the empty set to any other set is the empty set.
% This is needed because setof predicate fails when an empty set is 
% given as input to A. Predicate findall would get around this but
% would return duplicates if they given inputs are lists, not sets.
difference([], _, []) :- !.

% The difference of any set X with the empty set is the original set X.
% This precicate avoids unnecessary computation if B is the empty set.
difference(A, [], A) :- !.

% Set L to the set of all X which are in A but not in B.
difference(A, B, L) :-
    setof(X, (member(X, A), not(member(X, B))), L).