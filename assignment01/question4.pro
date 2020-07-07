get_length([], 0).

get_length([_|Tail], Sum) :-
    get_length(Tail, L2),
    Sum is 1 + L2.

sum_list([], 0).

sum_list([X|Tail], Sum) :-
    sum_list(Tail, RecSum),
    Sum is X + RecSum.

average(List, Avg) :-
    sum_list(List, Sum),
    get_length(List, Length),
    Avg is Sum / Length.