% State is represented by two lists and the locations of farmer and goat
initial(state([n,n,n,n], [], left, left)).
goal(state([], [s,s,s,s], right, right)).

solveBFS :-
    initial(Start),
    bfs([[Start]], Solution),
    write(Solution),
    nl.

bfs([[Node|Path]|_], [Node|Path]) :-
    goal(Node),!.

bfs([Path|Paths], Solution) :-
    generate_successors(Path, SuccessorPaths),
    append(Paths, SuccessorPaths, NewPaths),
    bfs(NewPaths, Solution).

% find all successor nodes reachable from the current node and store them
generate_successors([Node|Path], SuccessorPaths) :-
    findall([NewNode, Node | Path],
        (s(Node, NewNode), not(member(NewNode, [Node | Path]))),
        SuccessorPaths),!.

% Succsessor function if moving from S1 to S2 is safe
s(S1, S2) :-
    move(S1, S2),
    safe(S2).

% Move farmer from left to right
move(state([n|L],R, left, G), state(L,R2, right, G)) :-
    append([s], R, R2).

% Move farmer and goat from left to right
move(state([n,n|L],R, left, left), state(L,R2, right, right)) :-
    append([s,s], R, R2).

% Move farmer and not goat from left to right
move(state([n,n|L],R, left, G), state(L,R2, right, G)) :-
    append([s,s], R, R2).
    
% Move farmer from right to left
move(state(L,[s|R], right, G), state(L2,R, left, G)) :-
    append([n], L, L2).

% Move farmer and goat from right to left
move(state(L,[s,s|R], right, right), state(L2,R, left, left)) :-
    append([n,n], L, L2).

% Move farmer and not goat from right to left
move(state(L,[s,s|R], right, G), state(L2,R, left, G)) :-
    append([n,n], L, L2).
    
% Farmer is on same side as goat.
safe(state(_, _, FarmerSide, FarmerSide)).
% Goat is on its own on right side.
safe(state(L, _, left, right)) :-
    length(L, 3).
% Goat is on its own on left side.
safe(state(_, R, right, left)) :-
    length(R, 3).