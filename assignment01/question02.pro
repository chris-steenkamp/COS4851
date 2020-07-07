exp(Base, Exponent, Result) :-
    % Base case 1 is any positive integer raised to the power 0 should return 1.
    Exponent =:= 0,
    Base >= 0,
    Result is 1
    ;
    % Base case 2 is 0 raised to any positive power should return 0.
    Base =:= 0,
    Exponent > 0, % raising to 0 is handled in base case 1.
    Result is 0
    ;
    % all other positive bases and exponents get handled recursively.
    Base > 0,
    Exponent > 0,
    NewExponent is Exponent - 1, % recursively calculate smaller powers of the base.
    exp(Base, NewExponent, RecursiveResult),
    Result is Base * RecursiveResult. % Multiply the base by the recursively caluclated result and assign to Result.