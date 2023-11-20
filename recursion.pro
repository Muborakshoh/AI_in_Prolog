domains 
m = long
n = real

predicates
nondeterm conv_int_real(long, real)
nondeterm sum_i(m,m, m)
nondeterm sum_2i_1(m, m) 
nondeterm e(m,n)
nondeterm log2(m,n)
nondeterm pi_4(m,n)
nondeterm pi_6(m,n)
nondeterm pi_12(m,n)
nondeterm pi_8(m,n)
nondeterm e_x(m,n,n)
nondeterm sinx(m,n,n)
nondeterm cosx(m,n,n)
nondeterm arctg(m,n,n)
nondeterm f(m, m)
nondeterm pow(n,n,n)

clauses
conv_int_real (N, R):- N=R.

sum_i(M,M,M).
sum_i(M,N, Result) :- M<N, Next = M+1, sum_i(Next, N, X), Result = M+X.

sum_2i_1(N, R) :- N=0, R=0.
sum_2i_1(N, R):- N>0, Next = N-1, sum_2i_1(Next, P),  R = P+2*N-1. 


f(0,1) :- !.
f(N, R) :- N1 = N-1, f(N1, P), R=P*N.  

e(N,R) :- N=0, R=1.
e(N, R) :-N>0, Next = N-1, e(Next, F) ,f(N, P), R= F+1/P.

pow(_,0,1).
pow(X,Y,Z) :-Y>0 , N1 = Y-1, pow(X,N1, P) ,Z=P*X.

log2(N,R) :- N=0, R=0.
log2(N, R) :-N>0, Next = N-1, log2(Next, F) , pow(-1, Next, Z), R = F+Z/N .

pi_4(N,R) :- N=0, R=0.
pi_4(N, R) :-N>0, Next = N-1, log2(Next, F) , pow(-1, Next, Z), R = F+Z/(2*N-1) .

pi_6(N,R) :- N=0, R=0.
pi_6(N, R) :-N>0, Next = N-1, pi_6(Next, F) , P=N,pow(P, 2, Z), R = F+1/Z .

pi_12(N,R) :- N=0, R=0.
pi_12(N, R) :-N>0, Next = N-1, pow(-1, Next,P), pi_12(Next, T) ,I=N,pow(I,2,Z), R=T+P/Z.

pi_8(N,R) :- N=0, R=0.
pi_8(N, R) :-N>0, Next = N-1,T = 2*N-1,pow(T, 2,Z), pi_8(Next, P),R=P+1/Z.

e_x(N,_,R) :- N=0, R=1.
e_x(N,X,R) :- N>0, Next = N-1,conv_int_real (N, M),f(N, Z), pow(X,M, T), e_x(Next, X, Y), R=Y+T/Z.
 

sinx(1, X, R) :- R = X.
sinx(N, X, R) :-N > 1,Next = N - 1,P = 2 * Next + 1,pow(X, P, Z),f(P, Y),pow(-1, Next, G),sinx(Next, X, I),R = I + (Z * G) / Y.

cosx(N,_,R) :- N=0, R=1.
cosx(N,X,R) :- N>0, Next = N-1, P = 2*N,pow(X,P, Z), U = N,pow(-1, U,G),f(P,Y), cosx(Next, X, I), R=I+(Z*G)/Y.

arctg(N,X,R) :- N=0, R=X.
arctg(N,X,R) :- N>0, Next = N-1, P = 2*N-1,pow(X,P, Z), pow(-1, Next,G),arctg(Next, X, I), R=I+(Z*G)/(2*N-1).



goal
%sum_i(1,10, Result).
%e(20, Result).
%cosx(10,90,Result).
%sum_2i_1(10, Result).
%pi_8(10,Result).
%log2(10,Result).
%sinx(10,1,Result).
%cosx(10,1,Result).
