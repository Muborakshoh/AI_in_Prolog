domains
    list = real*.

predicates
nondeterm move_first_to_end(list, list)
nondeterm move_last_to_start(list OriginalList, list ResultList)
nondeterm append(list,list,list)
nondeterm append1(list,list,list)
nondeterm append2(list,list,list)
nondeterm append3(list,list,list)
nondeterm remove_last_two(list, list)
nondeterm remove_first_occurrence(integer Element, list OriginalList, list ResultList)
nondeterm  remove_all_occurrences(integer, list, list)
nondeterm remove_duplicates(list Input, list Output)
nondeterm member(integer Elem, list List)
nondeterm sum_list(list, integer, integer)
nondeterm average(list, real)
nondeterm reverse_list(list, list).
nondeterm reverse_list1(list, list).
nondeterm reverse_list2(list, list).
nondeterm make_palindrome(list, list).
nondeterm shift_left(list, list).
nondeterm shift_right(list, list).
nondeterm shift_left_n(list, integer, list).
nondeterm shift_right_n(list, integer, list).
nondeterm length(list,integer)
nondeterm perform_shift_left_n(list,integer,list)
nondeterm perform_shift_right_n(list,integer,list)
nondeterm shift_left1(list, list).
nondeterm shift_right1(list, list).
nondeterm shift_left_n1(list, integer, list).
nondeterm shift_right_n1(list, integer, list).
nondeterm append4(list, list, list).
nondeterm split_list(list, list, list).
nondeterm split_list_helper(list,list,list,list)
nondeterm split_list1(list,integer,list,list)
nondeterm sum_odd_elements(list,integer)
nondeterm sum_even_elements(list,integer)
nondeterm print_first_n_positive_elements(list,integer)
nondeterm count_positive_negative_elements(list,integer,integer)
nondeterm difference_between_max_and_min(list,integer)
nondeterm find_min(list,long,long)
nondeterm find_max(list,long,long)
nondeterm average1(list,integer)
nondeterm decrease_by_average(list,list,real)
nondeterm sum_list(list,real)
nondeterm length_list(list,real)
nondeterm remove_until_element(list,integer,list)
nondeterm remove_from_element_to_end(list,integer,list)
nondeterm remove_after_element(list,integer,list)
nondeterm replace_elements(list,integer,integer,list)

clauses
%---------------------------------------------------------------------------
    move_first_to_end([First|Rest], Result) :-
        append(Rest, [First], Result).
    append([], Y, Y).
    append([X|Xs], Y, [X|Z]) :-
        append(Xs, Y, Z).
%----------------------------------------------------------------------------        
    move_last_to_start(OriginalList, [Last|RestWithoutLast]) :-
        append1(RestWithoutLast, [Last], OriginalList).
    
    append1([], List, List).
    append1([Head|Tail], List, [Head|Result]) :-
        append1(Tail, List, Result).
        
    remove_last_two([_, _], []).
    remove_last_two([First, Second|Tail], [First|ResultTail]) :-
        remove_last_two([Second|Tail], ResultTail).
%--------------------------------------------------------------------------        
   remove_first_occurrence(_, [], []). 

remove_first_occurrence(X, [X | Tail], Tail). 

remove_first_occurrence(X, [Head | Tail], [Head | ResultTail]) :-
    X <> Head, 
    remove_first_occurrence(X, Tail, ResultTail).
%--------------------------------------------------------------------------        
    remove_all_occurrences(_, [], []). 

remove_all_occurrences(X, [X | Tail], ResultTail) :-
    remove_all_occurrences(X, Tail, ResultTail). 

remove_all_occurrences(X, [Head | Tail], [Head | ResultTail]) :-
    X <> Head, 
    remove_all_occurrences(X, Tail, ResultTail).
%--------------------------------------------------------------------------        
    remove_duplicates([], []).
    remove_duplicates([Head|Tail], Result) :-
        member(Head, Tail), !,
        remove_duplicates(Tail, Result).
    remove_duplicates([Head|Tail], [Head|Result]) :-
        remove_duplicates(Tail, Result).

    member(Elem, [Elem|_]).
    member(Elem, [_|Tail]) :-
        member(Elem, Tail).
%------------------------------------------------------------------------    
    sum_list([], Sum, Count) :-
        Sum = 0,
        Count = 0.
    sum_list([H|T], Sum, Count) :-
        sum_list(T, TailSum, TailCount),
        Sum = H + TailSum,
        Count = TailCount + 1.

    average(List, Average) :-
        sum_list(List, Sum, Count),
        Count > 0,
        Average = Sum / Count.
%-------------------------------------------------------------------------
make_palindrome(OriginalList, PalindromeList) :-
        reverse_list(OriginalList, ReversedList),
        append2(OriginalList, ReversedList, PalindromeList).

    reverse_list([], []).
    reverse_list([Head|Tail], ReversedList) :-
        reverse_list(Tail, ReversedTail),
        append2(ReversedTail, [Head], ReversedList).

    append2([], List, List).
    append2([Head|Tail], List, [Head|Rest]) :-
        append2(Tail, List, Rest).   
%------------------------------------------------------------------------- 
 
    shift_left([], []).
    shift_left([H|T], Result) :-
        append3(T, [H], Result).

    
    shift_right(List, Result) :-
        reverse_list1(List, [RH|RT]),
        append3([RH], RT, ReversedShifted),
        reverse_list1(ReversedShifted, Result).

    
    shift_left_n(List, N, Result) :-
        length(List, Length),
        ActualShift = N mod Length,
        perform_shift_left_n(List, ActualShift, Result).

    perform_shift_left_n(List, 0, List).
    perform_shift_left_n(List, N, Result) :-
        N > 0,
        shift_left(List, Shifted),
        N1 = N - 1,
        perform_shift_left_n(Shifted, N1, Result).

    
    shift_right_n(List, N, Result) :-
        length(List, Length),
        ActualShift = N mod Length,
        perform_shift_right_n(List, ActualShift, Result).

    perform_shift_right_n(List, 0, List).
    perform_shift_right_n(List, N, Result) :-
        N > 0,
        shift_right(List, Shifted),
        N1 = N + 1,
        perform_shift_right_n(Shifted, N1, Result).

    
    append3([], L, L).
    append3([H|T], L, [H|R]) :-
        append3(T, L, R).

    reverse_list1([], []).
    reverse_list1([H|T], R) :-
        reverse_list1(T, RT),
        append3(RT, [H], R).

    
    length([], 0).
    length([_|T], L) :-
        length(T, LT),
        L = LT + 1.
%---------------------------------------------------------------------------------  
shift_left1([], []).
    shift_left1([Head|Tail], Result) :-
        append4(Tail, [Head], Result).

    shift_right1(List, Result) :-
        reverse_list2(List, [Last|ReversedTail]),
        reverse_list2(ReversedTail, NewTail),
        append4([Last], NewTail, Result).

    shift_left_n1(List, N, Result) :-
        N > 0,
        shift_left1(List, ShiftedOnce),
        N1 = N - 1,
        shift_left_n1(ShiftedOnce, N1, Result).
    shift_left_n1(List, 0, List).

    shift_right_n1(List, N, Result) :-
        N > 0,
        shift_right1(List, ShiftedOnce),
        N1 = N - 1,
        shift_right_n1(ShiftedOnce, N1, Result).
    shift_right_n1(List, 0, List).

    append4([], List, List).
    append4([Head|Tail], List, [Head|Rest]) :-
        append4(Tail, List, Rest).

    reverse_list2([], []).
    reverse_list2([Head|Tail], ReversedList) :-
        reverse_list2(Tail, ReversedTail),
        append4(ReversedTail, [Head], ReversedList).
%-------------------------------------------------------------------    
split_list(List, Left, Right) :-
        split_list_helper(List, List, Left, Right).

    split_list_helper(Tail, [], [], Tail).
    split_list_helper(Tail, [_], [], Tail).
    split_list_helper([H|T], [_, _|RestTail], [H|Left], Right) :-
        split_list_helper(T, RestTail, Left, Right).
%-------------------------------------------------------------------------
split_list1([], _, [], []). 
split_list1([Head | Tail], Pivot, Smaller, Larger) :-
    Head <= Pivot,
    split_list1(Tail, Pivot, RestSmaller, Larger),
    Smaller = [Head | RestSmaller].
split_list1([Head | Tail], Pivot, Smaller, Larger) :-
    Head > Pivot,
    split_list1(Tail, Pivot, Smaller, RestLarger),
    Larger = [Head | RestLarger].
%-----------------------------------------------------------------------------------------
sum_odd_elements([], 0). 
sum_odd_elements([_], 0). 
sum_odd_elements([_, H | T], Sum) :-
    sum_odd_elements(T, RestSum),
    Sum = H + RestSum.


sum_even_elements([], 0). 
sum_even_elements([H], H). 
sum_even_elements([H, _ | T], Sum) :-
    sum_even_elements(T, RestSum),
    Sum = H + RestSum.
%-----------------------------------------------------------------------------------------------------------------
print_first_n_positive_elements(_, 0). 
print_first_n_positive_elements([], _). 
print_first_n_positive_elements([Head | Tail], N) :-
    Head > 0,
    write(Head), write(" "), 
    NewN = N - 1, 
    print_first_n_positive_elements(Tail, NewN).
print_first_n_positive_elements([_ | Tail], N) :-
    print_first_n_positive_elements(Tail, N). 
%-----------------------------------------------------------------------------------------------------------------
count_positive_negative_elements([], 0, 0). 
count_positive_negative_elements([Head | Tail], PositiveCount, NegativeCount) :-
    Head > 0,
    count_positive_negative_elements(Tail, RestPositiveCount, NegativeCount),
    PositiveCount = RestPositiveCount + 1. 
count_positive_negative_elements([Head | Tail], PositiveCount, NegativeCount) :-
    Head < 0,
    count_positive_negative_elements(Tail, PositiveCount, RestNegativeCount),
    NegativeCount = RestNegativeCount + 1. 
count_positive_negative_elements([Head | Tail], PositiveCount, NegativeCount) :-
    Head = 0,
    count_positive_negative_elements(Tail, PositiveCount, NegativeCount).
%-------------------------------------------------------------------------------------------------------------------
find_max([], Max, Max). 
find_max([Head | Tail], CurrentMax, Max) :-
    Head > CurrentMax,
    find_max(Tail, Head, Max). 
find_max([Head | Tail], CurrentMax, Max) :-
    Head <= CurrentMax,
    find_max(Tail, CurrentMax, Max).
find_min([], Min, Min).
find_min([Head | Tail], CurrentMin, Min) :-
    Head < CurrentMin,
    find_min(Tail, Head, Min). 
find_min([Head | Tail], CurrentMin, Min) :-
    Head >= CurrentMin,
    find_min(Tail, CurrentMin, Min). 
difference_between_max_and_min(List, Difference) :-
    List = [Head | _], 
    find_max(List, Head, Max), 
    find_min(List, Head, Min), 
    Difference = Max - Min.
%----------------------------------------------------------------------------------------------------
sum_list([],0).
length_list([],0).
average1(List, Avg) :-
    sum_list(List, Sum), 
    length_list(List, Length), 
    Avg = Sum / Length. 
decrease_by_average([], [], _). 
decrease_by_average([Head | Tail], [NewHead | NewTail], Avg) :-
    NewHead = Head - Avg, 
    decrease_by_average(Tail, NewTail, Avg).
%---------------------------------------------------------------------------------------------------
remove_until_element([X | Tail], X, Tail). 

remove_until_element([_ | Tail], X, ResultTail) :-
    remove_until_element(Tail, X, ResultTail).  
%------------------------------------------------------------------------------------------------
remove_from_element_to_end([X | Tail], X, []). 

remove_from_element_to_end([Head | Tail], X, [Head | ResultTail]) :-
    remove_from_element_to_end(Tail, X, ResultTail). 

remove_from_element_to_end([], _, []).
%--------------------------------------------------------------------------------------------
remove_after_element([X | Rest1], X, [X]). 

remove_after_element([Head | Tail], X, [Head | ResultTail]) :-
    remove_after_element(Tail, X, ResultTail).

%-------------------------------------------------------------------------------------------------
replace_elements([], _, _, []). 

replace_elements([X | Tail], X, Y, [Y | ResultTail]) :-
    replace_elements(Tail, X, Y, ResultTail). 

replace_elements([Head | Tail], X, Y, [Head | ResultTail]) :-
    X <> Head, 
    replace_elements(Tail, X, Y, ResultTail).
%-------------------------------------------------------------------------------------------------
goal
    %1.X=[1,2,3,4,5],
    %move_first_to_end(X, Result).
    %write("List after moving first element to the end: ", Result), nl.
    
    %X=[1,2,3,4,5],
    %2.move_last_to_start(X, Result),
    %write("List after moving last element to the start: ", Result), nl.
    %X=[1,2,3,4,5],
    %3remove_last_two(X, Result).
    %write("List after removing last two elements: ", Result), nl.
    
    %X=[1,2,7,2,4,3,5,4,5,1],readint(Y),
    %4.remove_first_occurrence(Y, X,Result).
    %write("List removing first occurrence of element: ", Result), nl.
    
    %X=[1,3,5,3,7,3,3],readint(Y),
    %remove_all_occurrences(Y, X, Result).
    %write("List after removing all occurrences of element: ", Result), nl.
    
    %X=[1, 2, 2, 3, 3, 4, 4, 5, 5, 6],
    %remove_duplicates(X, Result).
    %write("List after removing duplicates: ", Result), nl.
    
    %X=[1, 2, 3, 4, 5]
    %7.average(X, Avg),
    %write("The average is: ", Avg), nl.
    
    %X=[1,1 ,2,2, 3],
    %8.make_palindrome(X, Palindrome).
    
    
    %X=[1, 2, 3, 4, 5],
    %9,1shift_left1(X, LeftOnce),
    %shift_right1(X, RightOnce).
    %readint(Y),
    %shift_left_n1(X, Y, LeftTwice),
    %shift_right_n1(X, Y, RightTwice).
    
    %X=[1, 2, 3, 4, 5, 6, 7]
    %11.split_list(X, LeftHalf, RightHalf),
    %write("Left half: ", LeftHalf), nl,
    %write("Right half: ", RightHalf), nl.  
    
    %X=[5, 2, 8, 3, 9, 1],readint(Y),
   % split_list1(X, Y, Smaller, Larger). 
    
    %X=[1, 2, 3, 4, 5],
    %13.sum_odd_elements(X, OddSum),
    %sum_even_elements(X, EvenSum). 
    
    %X=[1, -2, 3, -4, 5, -6],readint(Y),
    %14.print_first_n_positive_elements(X, Y).
    
    %X=[1, -2, 13, -3, 15, -1,8,0],
    %15.count_positive_negative_elements(X, PositiveCount, NegativeCount).
    
    %X=[5, 2, 8, 3, 9, 1],
    %16.difference_between_max_and_min(X, Difference).
    
   % X=[5, 2, 8, 3, 9, 1],
    %17.average(X, Avg),
    %decrease_by_average(X, NewList, Avg).
    
    %X=[1, 2, 3, 4, 5],readint(Y),
    %remove_until_element(X, Y,Result).
    
    %X=[1, 2, 3, 4, 5],readint(Y),
    %19.remove_from_element_to_end(X, Y, ResultList).
    
    %X=[1, 2, 3, 4, 5],readint(Y),
    %20.remove_after_element(X, Y, ResultList).
    
    %21.X=[1, 2, 3, 2, 4, 2],readint(Y),readint(Z),
    %replace_elements(X, Y, Z, ResultList).
    
