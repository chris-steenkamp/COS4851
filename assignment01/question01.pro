owns(waldo, oscar).
owns(sjanie, zappa).
owns(peter, domino).
owns(john, daisy).
owns(andre, penka).

breed(zappa, labrador).
breed(penka, labrador).
breed(oscar, beagle).
breed(domino, dalmation).
breed(daisy, boxer).

service(beagle, hunting).
service(basset, hunting).
service(labrador, guide_dog).
service(german_shepherd, watch_dog).

large(labrador).
medium(beagle).

count_breeds(C) :-
    aggregate_all(set(X), breed(_, X), L), % create a unique set of all the breeds
    length(L, C). % assign the length of the set to the variable C.
