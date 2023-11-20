predicates
nondeterm summa_i(long,long,long)
nondeterm summ_series(long,long,long)
nondeterm factorial(long,real)
nondeterm exp_series(long,long,real,real)
nondeterm log2(real,real)
nondeterm pi_over_4(long,real)
nondeterm pi_over_4_calculate(long,long,real,real,real)
nondeterm pi_over_6(long,real)
nondeterm pi_over_6_sum(long,long,real,real)
nondeterm exp(real, integer, real)
nondeterm exp_sum(long,long,long,real,real,real)
nondeterm power(real, long, real)
nondeterm sin_taylor(real, long, real)
nondeterm cos_taylor(real, long, real)
nondeterm arctan_taylor(real, long, real)
nondeterm sin_sum(long,long,long,real,real)
nondeterm cos_sum(long,long,long,real,real)
nondeterm arctan_sum(long,long,long,real,real)

clauses
  summa_i(M,N,Summ):-M>N,!,Summ=0.
  summa_i(M,N,Summ):-M<=N,NextM=M+1,summa_i(NextM,N,PartialSumm),Summ=M+PartialSumm.
  
  summ_series(M,N,Summ):-M>N,!,Summ=0.
  summ_series(M,N,Summ):-M<=N,Term=2*M-1,NextM=M+1,summ_series(NextM,N,PartialSumm),
              Summ=Term+PartialSumm.
            
  factorial(0,1).
  factorial(N,F):-N>0,N1=N-1,factorial(N1,F1),F=N*F1.
  
  exp_series(_,N,Term,Sum):-N=0,!,Sum=1+Term.
  exp_series(X,N,Term,Sum):-N>0,factorial(N,_),TermNext=Term*X/N,NNext=N-1,
  exp_series(X,NNext,TermNext,PartialSum),Sum=Term+PartialSum.
  
  log2(X,Y):-Y = log(X)/log(2).
  
   pi_over_4(N, PiOver4):-pi_over_4_calculate(0, N, 1.0, 0.0, PiOver4).

    pi_over_4_calculate(I, N, Sign, Acc, Result) :-
        I > N, !,
        Result = Acc.
    pi_over_4_calculate(I, N, Sign, Acc, Result) :-
        Term = Sign / (2.0*I + 1),
        AccNext = Acc + Term,
        SignNext = -Sign,
        INext = I + 1,
        pi_over_4_calculate(INext, N, SignNext, AccNext, Result).
        
   pi_over_6(N, Result) :-
        pi_over_6_sum(1, N, 0, Result).

    pi_over_6_sum(I, N, Acc, Result) :-
        I > N, !,
        Result = Acc.
    pi_over_6_sum(I, N, Acc, Result) :-
        AccNext = Acc + 1 / (I * I),
        INext = I + 1,
        pi_over_6_sum(INext, N, AccNext, Result).
        
    power(_, 0, 1).
    power(X, N, P) :- 
        N > 0, 
        N1 = N - 1, 
        power(X, N1, P1), 
        P = X * P1.

    sin_taylor(X, N, Result) :-
        sin_sum(X, N, 0, 0, Result).

    sin_sum(X, N, I, Sum, Result) :-
        I > N, !,
        Result = Sum.
    sin_sum(X, N, I, Sum, Result) :-
        I1 = 2 * I + 1,
        power(X, I1, XPow),
        factorial(I1, Fact),
        Term = XPow / Fact,
        NewSum = Sum + ((-1) ** I) * Term,
        I2 = I + 1,
        sin_sum(X, N, I2, NewSum, Result).

    cos_taylor(X, N, Result) :-
        cos_sum(X, N, 0, 0, Result).

    cos_sum(X, N, I, Sum, Result) :-
        I > N, !,
        Result = Sum.
    cos_sum(X, N, I, Sum, Result) :-
        I1 = 2 * I,
        power(X, I1, XPow),
        factorial(I1, Fact),
        Term = XPow / Fact,
        NewSum = Sum + ((-1) ** I) * Term,
        I2 = I + 1,
        cos_sum(X, N, I2, NewSum, Result).

    arctan_taylor(X, N, Result) :-
        arctan_sum(X, N, 0, 0, Result).

    arctan_sum(X, N, I, Sum, Result) :-
        I > N, !,
        Result = Sum.
    arctan_sum(X, N, I, Sum, Result) :-
        I1 = 2 * I + 1,
        power(X, I1, XPow),
        Term = XPow / I1,
        NewSum = Sum + ((-1) ** I) * Term,
        I2 = I + 1,
        arctan_sum(X, N, I2, NewSum, Result).        
    
goal
  %1.summa_i(1,1000,Summ),
  %2.summ_series(1,3,Summ).
  %3.exp_series(1,20,1,E).
  %4.log2(8,Result).
  %5.pi_over_4(10,X). 
  %6.pi_over_6(100,X).
  sin_taylor(1.57, 10, SinResult),
    cos_taylor(1.57, 10, CosResult),
    arctan_taylor(0.5, 10, ArctanResult).
  
  