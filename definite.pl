:- module(definite, [definite/4]).
%% ============================ Evaluator ===================================
% RESTRICTIONS ON FUNCTIONS
% TRIG: Sin and Cos defined everywhere. Tan is indefined at pi/2 + npi where n is an integer
%       Csc is undefined at npi, Sec is undefined at pi/2 + npi, and Cot is undefined for npi
% definite(X, A, B, R) X: Expression, A: Start, B: End, R: Result
% Works best of inputs with pi are the same in format as the ones above


% Errors
definite(log(_, _), A, _, error('non-positive input')) :- A =< 0.
definite(log(_, _), _, B, error('non-positive input')) :- B =< 0.
definite(log(Base, _), _, _, error('non-positive base')) :- Base =< 0.

% Base case (f(A) - f(A) = 0) 
definite(_,A,A,0).
definite(X,_,_,X) :- number(X).

% Basic polynomials
definite(x, A, B, R) :- R is (B - A). 
definite(X^1, A,B,R) :- definite(X,A,B,R).
definite(_^0, A,B,R) :- definite(1,A,B,R).
definite(X^(-1), A,B,R) :- definite(1/X,A,B,R).

% ------------------
definite(X^N, A, B, R) :- 
    integer(N), 
    N > 1,
    N1 is (N - 1), 
    definite(X^N1, A, B,  R1),
    definite(X,A,B,R2),
    R is (R1*R2).

definite(X^N, A, B, R) :- 
    integer(N), 
    N < -1,
    N1 is (-N),
    definite(X^N1, A, B,  R1),
    R is (1/R1).

% ------------------

% Exponentials 
definite(X^x, 0, B, X^B - 1) :- integer(X).
definite(X^x, A, 0, 1  - X^A) :- integer(X).
definite(X^x, A, B, X^B - X^A) :- integer(X).

% Logarithms
definite(log(Base,x), 1, B, log(Base, B)).
definite(log(Base,x), A, 1, -log(Base,A)).

% Trig fxns
definite(sin(x), N*pi,M*pi, 0) :- 
    integer(N),
    integer(M).
definite(sin(x), N*pi,B, sin(B)) :- 
    integer(N).
definite(sin(x), A,M*pi, -sin(A)) :- 
    integer(M).
definite(sin(x), A, B, (sin(B) - sin(A))).

definite(cos(x), pi/2 + N*pi, pi/2 + M*pi, 0) :- 
    integer(N),
    integer(M).
definite(cos(x), pi/2 - N*pi, pi/2 - M*pi, 0) :- 
    integer(N),
    integer(M).
definite(cos(x), pi/2 + N*pi,B, cos(B)) :- 
    integer(N).
definite(cos(x), pi/2 - N*pi,B, cos(B)) :- 
    integer(N).
definite(cos(x), A,pi/2 + M*pi, -cos(A)) :- 
    integer(M).
definite(cos(x), A,pi/2 - M*pi, -cos(A)) :- 
    integer(M).
definite(cos(x), A,B, (cos(B) - cos(A))).

definite(tan(x), A, B, R) :- definite(sin(x)/cos(x), A, B, R).
definite(sec(x), A, B, R) :- definite(1/cos(x), A, B, R).
definite(csc(x), A, B, R) :- definite(1/sin(x), A, B, R).

% General structure
definite(X1+X2,A,B,R) :- definite(X1,A,B,R1), definite(X2,A,B,R2), R is (R1 + R2).
definite(X1-X2,A,B,R) :- definite(X1,A,B,R1), definite(X2,A,B,R2), R is (R1 - R2).
definite(X1*X2,A,B,R) :- definite(X1,A,B,R1), definite(X2,A,B,R2), R is (R1 * R2).
definite(X1/X2,A,B,R) :- definite(X1,A,B,R1), definite(X2,A,B,R2), dif(R2,0) ,R is (R1 / R2).


