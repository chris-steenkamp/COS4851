add_element(X,L,L1) :-
    member(X, L),!, L1=L
    ;
    L1=[X|L].

    