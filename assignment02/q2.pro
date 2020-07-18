% non-recursive function which gets called by the user.
% starts by calling the recursive function with a count of 0.
count_vars(L, N) :-
    count_vars_rec(L, 0, N).

% If the input list is empty, use the current calculated value of N.
count_vars_rec([], N, N).

% Tail recursive function 
% If the item at the head of the list is instantiated then add one to
% the current count and pass this sum into subsequent calls.
% Otherwise just pass the current count as an argument.
count_vars_rec([H|T], C, N) :-
    var(H), !, count_vars_rec(T, C, N)
    ;
    CC is C + 1,
    count_vars_rec(T, CC, N).