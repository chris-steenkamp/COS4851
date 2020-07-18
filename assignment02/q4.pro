split([],[],[]).

% non integers will fail with an error message.
split([H|_], _, _) :-
    not(integer(H)),!,write("Error! "), write(H), write(" is not an integer."),nl,fail.

% if a number can be the head of Postives, then it is at least 0.
split([H|T],[H|PosTail],Negatives) :-
    H >= 0,!,split(T,PosTail, Negatives).

% otherwise, if a number can be the head of Negatives, then it is < 0.
split([H|T],Positives,[H|NegTail]) :-
    split(T,Positives, NegTail).