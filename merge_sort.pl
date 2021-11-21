rev_sort([],[]).
rev_sort([X],[X]).
rev_sort([F,S|T],Sorted) :-  
   split([F,S|T],List1,List2),
   rev_sort(List1,Sorted1),
   rev_sort(List2,Sorted2),
   merge(Sorted1,Sorted2,Sorted).

split([],[],[]).
split([A],[A],[]).
split([A,B|Tail],[A|Tail1],[B|Tail2]) :- split(Tail,Tail1,Tail2).

merge(X,[],X).
merge([],X,X).
merge([H|T],[H1|T1],[H|X]) :-  H >= H1, 
	merge(T,[H1|T1],X).
merge([H|T],[H1|T1],[H1|X]) :-  H < H1,  
	merge([H|T],T1,X).


is_graphic([L]) :-
	rev_sort([L],[H|T]),
	is_len_ok([H|T]),
	dec(H,[H|T]).
	%no_negatives(L).

is_len_ok([H|T]) :-
	list_len(T,A),
	H =< A.

list_len(List,Len) :- list_len(List,0,Len).
list_len([],Len,Len).
list_len([_|Tail],X,Len) :-
  Y is X+1,
  list_len(Tail,Y,Len).
  
dec(0,L,L).
dec(H,[F|T],NL) :-
	NH is H-1,
	F1 is F-1,
	dec(NH,T,NL1),
	append([F1],NL1,NL).
	
%no_negatives(List) :- 
	