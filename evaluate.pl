:- module(evalutate, [eval/4, exp_calc/3]).
%% ============================ Evaluator ===================================
% eval(F, D, X, V) is true if V is the value by plugging X into variable D in F
% for trig, only sin and cos are considered at this point.
eval(K, _, _, K) :-
    number(K).
eval(D, D, X, X) :-
    atomic(D).
eval(A+B, D, X, V) :-
    eval(A, D, X, VA),
    eval(B, D, X, VB),
    V is VA + VB.
eval(A-B, D, X, V) :-
    eval(A, D, X, VA),
    eval(B, D, X, VB),
    V is VA - VB.
eval(A*B, D, X, V) :-
    eval(A, D, X, VA),
    eval(B, D, X, VB),
    V is VA * VB.
eval(A/B, D, X, V) :-
    dif(B, 0),
    eval(A, D, X, VA),
    eval(B, D, X, VB),
    V is VA / VB.
eval(D^N, D, X, V) :-
    exp_calc(X, N, V).


eval(sin(D), D, X, V) :-
    R is (X * pi / 180),
    V is sin(R).

eval(-sin(D), D, X, -V) :-
    R is (X * pi / 180),
    V is sin(R).

eval(A*sin(D), D, X, EA* V) :-
    eval(A, D, X, EA),
    R is (X * pi / 180),
    V is sin(R).

eval(cos(D), D, X, V) :-
    R is (X * pi / 180),
    V is cos(R).

eval(-cos(D), D, X, -V) :-
    R is (X * pi / 180),
    V is cos(R).    

eval(A*cos(D), D, X, EA* V) :-
    eval(A, D, X, EA),
    R is (X * pi / 180),
    V is cos(R).


eval(log(e, abs(D)), D, X, V) :-
    X >= 0,
    V is log(X) / log(e).

eval(log(e, abs(D)), D, X, V) :-
    X < 0,
    V is log(-X) / log(e).

eval(log(B, A), _, _, V) :-
    number(B),
    number(A),
    B > 0,
    A >= 0, 
    V is log(A) / log(B).

eval(log(e, A), _, _, V) :-
    number(A),
    A >= 0, 
    V is log(A).

eval(log(B, D), D, X, V) :-
    B > 0,
    X >=0, 
    V is log(X) / log(B).
    



    


% exp_calc(X, N, V) is true if V is X^N.
exp_calc(_, 0, 1).
exp_calc(X, N, V) :-
    N1 is N - 1, 
    N > 0,
    exp_calc(X, N1, V1),
    V is X * V1. 
exp_calc(X, N, 1/V) :-
    N < 0,
    P = - N,
    P1 is P - 1,
    exp_calc(X, P1, V1),
    V is X * V1. 