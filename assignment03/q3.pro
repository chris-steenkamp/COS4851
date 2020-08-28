% States are represented by number of missionaries, cannibals and boat on north shore
initial([3,3,1]).

% All missionaries and cannibals + boat is across the river.
goal([0,0,0]).

solve :-
    initial(Start),
    bfs([], Start, Solution),
    write(Solution),nl.


% If goal node is in path then we have a solution.
bfs(Path, Node, [Node|Path]) :-
    goal(Node).

% If we can move from a node to another node and we have not
% already traversed that path then continue searching for goal.
bfs(Path, Node, Solution) :-
    s(Node, Node1),
    not(member(Node1, Path)),
    bfs([Node|Path], Node1, Solution).


% State transition is valid if there is a safe move from S1 to S2
s(S1, S2) :-
    move(S1, S2),
    safe(S2).


% Move one missionary across
move([M,C, 1], [M2, C, 0]) :-
    M > 0,
    M2 is M - 1.

% Move two missionaries across
move([M,C, 1], [M2, C, 0]) :-
    M > 1,
    M2 is M - 2.

% Move one cannibal across
move([M,C,1], [M, C2, 0]) :-
    C > 0,
    C2 is C - 1.

% Move two cannibals across
move([M,C,1], [M, C2, 0]) :-
    C > 1,
    C2 is C - 2.

% Move one of each across
move([M,C,1], [M2, C2, 0]) :-
    C > 0,
    M > 0,
    C2 is C - 1,
    M2 is M - 1.

% Move one missionary back
move([M,C, 0], [M2, C, 1]) :-
    M < 3,
    M2 is M + 1.

% Move two missionaries back
move([M,C, 0], [M2, C, 1]) :-
    M < 2,
    M2 is M + 2.

% Move one cannibal back
move([M,C,0], [M, C2, 1]) :-
    C < 3,
    C2 is C + 1.

% Move two cannibals back
move([M,C,0], [M, C2, 1]) :-
    C < 2,
    C2 is C + 2.

% Move one of each back
move([M,C,0], [M2, C2, 1]) :-
    C < 3,
    M < 3,
    C2 is C + 1,
    M2 is M + 1.

% All missionaries are on one side.
safe([3,_,_]).

% All missionaries are on the other side.
safe([0,_,_]).

% An even number of missionaries and cannibals on either side.
safe([X,X,_]).

