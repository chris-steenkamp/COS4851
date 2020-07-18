student('Clancy', 'Keira', hons, [cos4807,cos4840,cos4851]).
student('Steenkamp', 'Chris', hons, [cos4807,cos4892,cos4851]).
student('Frikkadel', 'Frikkie', hons, [cos4840,cos4892,cos4851]).
student('Steenkamp', 'David', und, [cos3701,cos2614, cos3751]).
student('Clancy', 'Jayson', und, [cos2601,cos2611,cos2614]).

% True when First is the prefix of Name.
get_first_name(Name, First) :-
    name(Name, FullName),
    name(First, FirstName),
    append(FirstName, _, FullName).


% True when Surname is the suffix of Name.
get_surname(Name, Surname) :-
    name(Name, FullName),
    name(Surname, Last),
    append(_, Last, FullName).


% Get the list of modules for all students with full name Name.
modules(Name, List) :-
    student(Surname, First, _, List),
    get_first_name(Name, First),
    get_surname(Name, Surname).


% list all students who take cos4851 but not cos4807
half_logical(Names) :-
    findall(FirstName, (student(_, FirstName, _, Modules), 
        member(cos4851, Modules), not(member(cos4807, Modules))), Names).
    
    