breed(zappa, labrador).
breed(penka, labrador).
breed(oscar, beagle).
breed(domino, dalmation).
breed(daisy, boxer).
breed(snoopy, beagle).
breed(lady, basset).
breed(gina, german_shepherd).

service(beagle, hunting).
service(basset, hunting).
service(labrador, guide_dog).
service(german_shepherd, watch_dog).
service(boxer, guard_dog).
service(dalmation, carriage_dog).

% Get the breed, name and service of a dog in the database.
dog_information(Breed, Name, Service) :-
  service(Breed, Service),
  breed(Name, Breed).


% Given a ternary predicate p(X,Y,Z), return the set of X for which Y and Z are true.
satisfy(P,L) :-
  functor(P, F, 3),
  arg(1, P, X),
  arg(2, P, Y),
  arg(3, P, Z),
  T =.. [F|[X, Y, Z]],
  setof(X, Y ^ Z ^ T, L).