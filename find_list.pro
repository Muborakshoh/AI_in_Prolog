domains
dog_list=symbol*

predicates
dogs(dog_list)
nondeterm find_list(symbol,dog_list)

clauses
dogs(["layka","pitbul","dog","bolonka","alabay"]).
find_list(X,[X|_]).
find_list(X,[_|Y]):-find_list(X,Y).

goal
A="dog",
dogs(X),
find_list(A,X),write("yes"),nl.