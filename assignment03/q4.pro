initial(state([n,n,n,n], [], left, left)).
goal(state([], [s,s,s,s], right, right)).

g :-
    solveBFS.

solveBFS :-
    initial(Start),
    bfs([[Start]], Solution),
    write(Solution),
    nl.

bfs([[Node|Path]|_], [Node|Path]) :-
    goal(Node).

bfs([Path|Paths], Solution) :-
    generate_successors(Path, SuccessorPaths),
    append(Paths, SuccessorPaths, NewPaths),
    bfs(NewPaths, Solution).

generate_successors([Node|Path], SuccessorPaths) :-
    write('Looking for paths from '),write(Node),nl,
    bagof([NewNode, Node | Path],
        (s(Node, NewNode), not(member(NewNode, [Node | Path]))),
        % s(Node, NewNode),
        SuccessorPaths),
        write('From '),write(Node),write(' found '),write(SuccessorPaths),nl,!.
    
s(S1, S2) :-
    move(S1, S2),
    write('Found '),write(S2),nl,
    safe(S2),
    write(S2),write(' is safe.'),nl.

% Move farmer from left to right
move(state(L,R, left, G), state(L2,R2, right, G)) :-
    length(L, Length),
    Length > 0,
    select(n,L,L2),!,
    append([s], R, R2),
    write('Moving farmer left to right'),nl.

% Move farmer and goat from left to right
move(state(L,R, left, left), state(L2,R2, right, right)) :-
    length(L, Length),
    Length > 1,
    select(n,L,LTemp),!,
    select(n,LTemp,L2),!,
    append([s,s], R, R2),
    write('Moving farmer and goat left to right'),nl.

% Move farmer and not goat from left to right
move(state(L,R, left, G), state(L2,R2, right, G)) :-
    length(L, Length),
    Length > 1,
    select(n,L,LTemp),!,
    select(n,LTemp,L2),!,
    append([s,s], R, R2),
    write('Moving farmer not goat left to right'),nl.
    
% Move farmer from right to left
move(state(L,R, right, G), state(L2,R2, left, G)) :-
    length(R, Length),
    Length > 0,
    select(s,R,R2),!,
    append([n], L, L2),
    write('Moving farmer right to left'),nl.

% Move farmer and goat from right to left
move(state(L,R, right, right), state(L2,R2, left, left)) :-
    length(R, Length),
    Length > 1,
    select(s,R,RTemp),!,
    select(s,RTemp,R2),!,
    append([n,n], L, L2),
    write('Moving farmer and goat right to left'),nl.

% Move farmer and not goat from right to left
move(state(L,R, right, G), state(L2,R2, left, G)) :-
    length(R, Length),
    Length > 1,
    select(s,R,RTemp),!,
    select(s,RTemp,R2),!,
    append([n,n], L, L2),
    write('Moving farmer not goat right to left'),nl.
    

% Farmer is on same side as goat.
safe(state(L,R, FarmerSide, FarmerSide)).
% Goat is on its own on one side.
safe(state(L,R, left, right)) :-
    length(L, 3).
safe(state(L,R, right, left)) :-
    length(R, 3).