:- module(evalutate, [eval/4, exp_calc/3]).
%% ============================ Evaluator ===================================
% eval(F, D, X, V) is true if V is the value by plugging X into variable D in F
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



eval(sin(D), D, X, 0) :-
    X mod 180 =:= 0,
    !.
eval(_*sin(D), D, X, 0) :-
    X mod 180 =:= 0,
    !.
eval(cos(D), D, X, 0) :-
    X mod 360 =:= 90,
    !.
eval(cos(D), D, X, 0) :-
    X mod 360 =:= 270,
    !.
eval(_*cos(D), D, X, 0) :-
    X mod 360 =:= 90,
    !.
eval(_*cos(D), D, X, 0) :-
    X mod 360 =:= 270,
    !.
eval(tan(D), D, X, 0) :-
    X mod 180 =:= 0,
    !.
eval(_*tan(D), D, X, 0) :-
    X mod 180 =:= 0,
    !.



eval(sin(D), D, X, V) :-
    R is (X * pi / 180),
    V is sin(R).
eval(-sin(D), D, X, -V) :-
    R is (X * pi / 180),
    V is sin(R).
eval(A*sin(D), D, X, V) :-
    eval(A, D, X, EA),
    R is (X * pi / 180),
    S is sin(R),
    V is EA*S.
eval(cos(D), D, X, V) :-
    R is (X * pi / 180),
    V is cos(R).
eval(-cos(D), D, X, -V) :-
    R is (X * pi / 180),
    V is cos(R).    
eval(A*cos(D), D, X, V) :-
    eval(A, D, X, EA),
    R is (X * pi / 180),
    C is cos(R),
    V is EA*C.
eval(tan(D), D, X, V) :-
    R is (X * pi / 180),
    S = sin(R),
    C = cos(R),
    dif(C, 0),
    V is S/C.
eval(-tan(D), D, X, -V) :-
    R is (X * pi / 180),
    S = sin(R),
    C = cos(R),
    dif(C, 0),
    V is S/C. 
eval(A*tan(D), D, X, V) :-
    eval(A, D, X, EA),
    R is (X * pi / 180),
    S = sin(R),
    C = cos(R),
    dif(C, 0),
    T is S/C,
    V is EA*T.
eval(csc(D), D, X, _) :-
    eval(sin(D), D, X, S),
    S = 0,
    !,
    fail.
eval(csc(D), D, X, V) :-
    eval(sin(D), D, X, S),
    V is 1/S.
eval(-csc(D), D, X, _) :-
    eval(sin(D), D, X, S),
    S = 0,
    !,
    fail.
eval(-csc(D), D, X, -V) :-
    eval(sin(D), D, X, S),
    V is 1/S.
eval(_*csc(D), D, X, _) :-
    eval(sin(D), D, X, S),
    S = 0,
    !,
    fail.
eval(A*csc(D), D, X, V) :-
    eval(A, D, X, EA),
    eval(sin(D), D, X, S),
    C is 1/S,
    V is EA*C.
eval(sec(D), D, X, _) :-
    eval(cos(D), D, X, S),
    S = 0,
    !,
    fail.
eval(sec(D), D, X, V) :-
    eval(cos(D), D, X, S),
    V is 1/S.
eval(-sec(D), D, X, _) :-
    eval(cos(D), D, X, S),
    S = 0,
    !,
    fail.
eval(-sec(D), D, X, -V) :-
    eval(cos(D), D, X, S),
    V is 1/S.
eval(_*sec(D), D, X, _) :-
    eval(cos(D), D, X, S),
    S = 0,
    !,
    fail.
eval(A*sec(D), D, X, V) :-
    eval(A, D, X, EA),
    eval(cos(D), D, X, S),
    C is 1/S,
    V is EA*C.


eval(cot(D), D, X, _) :-
    eval(tan(D), D, X, S),
    S = 0,
    !,
    fail.
eval(cot(D), D, X, V) :-
    eval(tan(D), D, X, S),
    V is 1/S.
eval(-cot(D), D, X, _) :-
    eval(tan(D), D, X, S),
    S = 0,
    !,
    fail.
eval(-cot(D), D, X, -V) :-
    eval(tan(D), D, X, S),
    V is 1/S.
eval(_*cot(D), D, X, _) :-
    eval(tan(D), D, X, S),
    S = 0,
    !,
    fail.
eval(A*cot(D), D, X, V) :-
    eval(A, D, X, EA),
    eval(tan(D), D, X, S),
    C is 1/S,
    V is EA*C.




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