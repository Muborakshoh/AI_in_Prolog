domains
list=real*

predicates
nondeterm read_list(integer,list)
nondeterm new_list(list,list)
nondeterm result

clauses
read_list(0,[]).
read_list(N,[S|E]):-readreal(S),N1=N-1,read_list(N1,E).
new_list([],[]).
new_list([S1|E1],[S2|E2]):-S2=S1*2,new_list(E1,E2).
result:-
    write("Enter count elements of list: "),
    readint(N),
    read_list(N,L),
    new_list(L,NL),
    write("Current list"),nl,
    write(L),nl,nl,
    write("New List"),nl,
    write(NL),nl.
goal
result.