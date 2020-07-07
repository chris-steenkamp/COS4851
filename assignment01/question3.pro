student('Keira Clancy', 'female', 4, []).
student('Chris Steenkamp', 'male', 12, ['soccer']).
student('David Steenkamp', 'male', 9, ['cricket']).
student('Jayson Clancy', 'male', 7, ['cricket', 'hockey']).

gender(Name, Gender) :-
    student(Name, Gender, _, _).

grade(Name, Grade) :-
    student(Name, _, Grade, _).

sports(Name, Sports) :-
    student(Name, _, _, Sports).

member(X, [X|_]).
member(X, [_|Tail]) :-
    member(X, Tail).

who_plays(Sport, Student) :-
    student(Student, _, _, List),
    member(Sport, List).