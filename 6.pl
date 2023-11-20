domains
    list = integer*.

predicates
    move_first_to_end(list, list).

clauses
    move_first_to_end([First|Rest], Result) :-
        append(Rest, [First], Result).


    append([], Y, Y).
    append([X|Xs], Y, [X|Z]) :-
        append(Xs, Y, Z).

goal
    move_first_to_end([1,2,3,4,5], Result).
