:- module(ivp, [calc_c/5,ivp/5]).
:- use_module(evaluate).
:- use_module(integrator).




%% ============================ Initial Value Problem (Calculating C) ===================================

% +C
% plus_c(X, Y) is true if Y is X plus c
plus_c(X, X+c).

% remove C
% remove_c(X, Y) is true if Y is X with c removed
remove_c(X+c, X).

% find Antiderative
% find_ad(F, X, ADF) is true if ADF is the anti-derivative (w/ constant) of F with respect to X
find_ad(F, X, ADF) :-
    integrate(F, X, R), 
    plus_c(R, ADF).


% calculate C
%calc_c(ADF, D, X, Y, C) is true if C is the value of the constant in ADF (with respect to D) when Y is the value of plugging X into ADF
calc_c(ADF, D, X, Y, C) :-
    remove_c(ADF, RC),
    eval(RC, D, X, V),
    C is Y - V.




% IVP
% ivp(F, D, X, Y, R) is true if F is the derative of the unknown function R with respect to D, and Y is the value of R at a specific point X
ivp(F, D, X, Y, RC+C) :-
    find_ad(F, D, ADF), % get ADF, which is the antiderivative of F with respect to D
    remove_c(ADF, RC),
    calc_c(ADF, D, X, Y, C). % get the value of C in ADF