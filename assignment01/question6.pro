interleave([],L, L).

interleave([H|T],[],[H|T]).

interleave([L1H|L1T], [L2H|L2T], [L1H,L2H|L]) :-
    interleave(L1T, L2T, L).


transpose([],[],[]).

transpose([L1H|L1T], [L2H|L2T], [(L1H,L2H)|L]) :-
    transpose(L1T, L2T, L).

inner_prod([],[],0).

inner_prod([L1H|L1T], [L2H|L2T], Result) :-
    inner_prod(L1T, L2T, RecursiveResult),
    Result is L1H * L2H + RecursiveResult.