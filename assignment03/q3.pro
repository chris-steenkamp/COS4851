% States are represented by number of missionaries, cannibals and boat on north shore
initial(state(3,3,1)).

% All missionaries and cannibals + boat is across the river.
goal(state(0,0,0)).

% Breadth first algorithm which uses a queue to store the paths to be explored.
% It does this by asserting generated nodes at the end of the database and then
% retracts them as they are processed.
solveBFSQ :-
    initial(Start),
    % Start by pushing the initial starting node into the queue.
    assertz(queue([Start])),
    bfsq(Solution),
    write(Solution),nl.

% If goal node is in path then we have a solution.
bfsq([Node|Path]) :-
    queue([Node|Path]),
    goal(Node),
    % Clear the queue to prevent the remaining unexplored paths from being
    % processed (unless we want to generate alternative solutions).
    clear_queue.



% Perform breadth-first by generating all potential successor nodes
% and pushing them into the queue for processing.
bfsq(Solution) :-
    % Find the first path which is in the queue.
    queue(Path),
    % We don't want to backtrack if the current path is a dead-end.
    !,
    % generate all successor nodes into the queue
    generate_successors(Path),
    % Pop this path from the queue as we have processed it.
    retract(queue(Path)),
    bfsq(Solution).

% Remove all existing paths from the queue.
clear_queue :-
    findall(_, (queue(Path), retract(queue(Path))), _).

% find all successor nodes from Node and add them to the queue only if they are
% not already part of any existing path.
generate_successors([Node|Path]) :-
    s(Node, NewNode),
    % make sure there are no other paths which already contain NewNode.
    not(bagof(_, (queue(OtherPath),member(NewNode, OtherPath)), _)),
    % Add NewNode to head of path and push this new path into the queue.
    assertz(queue([NewNode, Node | Path])),
    % force a failure to backtrack and generate the next successor.
    fail;
    % If there no (more) successors we are done and can return.
    true.

% State transition is valid if there is a safe move from S1 to S2
s(S1, S2) :-
    move(S1, S2),
    safe(S2).

% Move one missionary across
move(state(M,C,1), state(M2,C,0)) :-
    M > 0,
    M2 is M - 1.

% Move two missionaries across
move(state(M,C,1), state(M2,C,0)) :-
    M > 1,
    M2 is M - 2.

% Move one cannibal across
move(state(M,C,1), state(M,C2,0)) :-
    C > 0,
    C2 is C - 1.

% Move two cannibals across
move(state(M,C,1), state(M,C2,0)) :-
    C > 1,
    C2 is C - 2.

% Move one of each across
move(state(M,C,1), state(M2,C2,0)) :-
    C > 0,
    M > 0,
    C2 is C - 1,
    M2 is M - 1.

% Move one missionary back
move(state(M,C,0), state(M2,C,1)) :-
    M < 3,
    M2 is M + 1.

% Move two missionaries back
move(state(M,C,0), state(M2,C,1)) :-
    M < 2,
    M2 is M + 2.

% Move one cannibal back
move(state(M,C,0), state(M,C2,1)) :-
    C < 3,
    C2 is C + 1.

% Move two cannibals back
move(state(M,C,0), state(M,C2,1)) :-
    C < 2,
    C2 is C + 2.

% Move one of each back
move(state(M,C,0), state(M2,C2,1)) :-
    C < 3,
    M < 3,
    C2 is C + 1,
    M2 is M + 1.

% All missionaries are on one side.
safe(state(3,_,_)).

% All missionaries are on the other side.
safe(state(0,_,_)).

% An even number of missionaries and cannibals on either side.
safe(state(X,X,_)).