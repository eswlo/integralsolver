:- module(integrator, [integrate/3]).
%% ============================ Integrator ===================================
% integrate(F,X,ADF) is true if ADF is the anti-derivative (w/o constant) of F with respect to X
%% ===========================================================================

% Rules 
% ============================================================
is_trig(sin(E), E).
is_trig(cos(E), E).

integrate(A+B, X, ADA+ADB) :-
    integrate(A, X, ADA),
    integrate(B, X, ADB).

integrate(A-B, X, ADA-ADB) :-
    integrate(A, X, ADA),
    integrate(B, X, ADB).

integrate(K*X, X, K*AD) :-
    atomic(K),
    dif(K, X),
    integrate(X, X, AD).

integrate(X*K, X, K*AD) :-
    atomic(K),
    dif(K, X),
    integrate(X, X, AD).

integrate((A/B)*X, X, AD*(A/B)) :-
    atomic(A),
    atomic(B),
    dif(X, A),
    dif(X, B),
    dif(B, 0),
    integrate(X, X, AD).

integrate(K*F, X, K*AD) :-
    atomic(K),
    dif(K, X),
    integrate(F, X, AD).

integrate(F*G, X, F*ADG - AD) :-
    is_trig(G, _),
    integrate(G, X, ADG),
    deriv(F, X, DF),
    integrate(DF*ADG, X, AD).

integrate(-F, X, R) :- integrate(F,X,-R).

% Constants
% ============================================================
integrate(0, _, 0).

integrate(K, X, K*X) :-
    atomic(K), 
    dif(K, X).

integrate(A/B, X, (A/B)*X) :-
    atomic(A),
    atomic(B), 
    dif(A, X),
    dif(B, X),
    dif(B, 0).


% ============================================================
integrate(X, X, (X^2)*(1/2)).

integrate(X^N, X, (X^M)*(1/M)) :- % N > 0
    atomic(N), 
    dif(N, -1),
    M is N + 1.

integrate(X^N, X, X) :- % N = 0
    N = 0.

integrate(X^N, X, log(e, abs(X))) :- 
    N = -1.



% Trigonometric
% ============================================================
integrate(sin(X),X,cos(X)).
integrate(cos(X),X, -sin(X)).
integrate(tan(X),X, sec(X)^2).

integrate(cot(X),X, -csc(X)^2).
integrate(sec(X),X, sec(X)*tan(x)).
integrate(csc(X),X, -cot(X)*csc(x)).
% integrate(sec(X),X, log(e, abs(sec(X)+tan(x)))).
% integrate(csc(X),X, -log(e, abs(cot(X)*csc(x)))).

integrate(1/sin(X),X, R) :- integrate(csc(X),X, R).
integrate(1/cos(X),X, R) :- integrate(sec(X),X, R).
integrate(1/tan(X),X, R) :- integrate(cot(X),X, R).

% Logarithmic
% ============================================================
integrate(log(e, X), X, X*log(e, X) - X).

integrate(log(A, X),X, R/(log(e, A))) :- 
    atomic(A),
    integrate(log(e,X),X, R).

% Exponentials
% ============================================================
integrate(e^X,X, e^X).

