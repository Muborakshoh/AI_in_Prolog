domains 
person, g = symbol


predicates 
nondeterm parent(person, person)
nondeterm is_parents(person, person)
nondeterm parents(person, person)
nondeterm grantparents(person, person)
nondeterm gender(person,g)
nondeterm wife(person, person)
nondeterm has_parents(person) 
%nondeterm has_sibling(person)%has_sibling(X) :- parent(Parent, X),parent(Parent, Brother), gender(Brother,"male"), Brother<>X.
nondeterm has_sister_brother(person, person)
nondeterm grandchild(person, person)

clauses
parent("ivan","nina") .
parent("ivan","oleg") .
parent("anna","nina") .
parent("anna","oleg") .
parent("oleg","alla") .
parent("oleg","larisa") .
parent("vera","alla") .
parent("vera","larisa") .
parent("larisa","natalia") .
parent("victor","natalia") .

gender("ivan","male").
gender("anna","female").
gender("nina","female").

gender("oleg","male").
gender("vera","female").

gender("alla","female").
gender("larisa","female").
gender("victor","male").
gender("natalia","female").

is_parents(Person, Child) :- 
	parent(Person, Child), 
	write("Yes") ,nl,!; 
	write("No"), nl.
	
parents(X, Y)  :-  
	parent(X, Y).
	
grantparents(X,Y) :- 
	parent(Z, Y), 
	parent(X,Z).
	
wife(W,H) :-  
	parent(W,X), 
	parent(H, X), 
	gender(W, "female"),!.
	 
has_parents (X):- 
	parent(F,X),
	parent(M, X), 
	F<>M.
	

has_sister_brother(X,Y) :- 
	parent(Parent, X),
	parent(Parent, Sister), 
	gender(Sister,"female"), 
	Sister<>X, 
	Y=Sister,!.
	
grandchild(Grandchild, Grandparent) :- 
	parent(X, Grandchild), 
	parent(Grandparent, X).
      
       

goal
%grantparents(Grandparents,"vera").
%is_parents("ivan",C).
%wife(W,"ivan").
%has_sister_brother(X,"nina").
%has_parents("oleg").
%gender("oleg",Y).
%parents(X,"anna").
%grandchild(X,"anna").