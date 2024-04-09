:- module(derivatives, [deriv/3]).


%% ====================== Derivatives taken from David's algebra.pl
% deriv(E,X,DE) is true if DE is the derivative of E with respect to X

deriv(X,X,1).
deriv(C,X,0) :- atomic(C), dif(C,X).
deriv(A+B,X,DA+DB) :-
    deriv(A,X,DA),
    deriv(B,X,DB).
deriv(A-B,X,DA-DB) :-
    deriv(A,X,DA),
    deriv(B,X,DB).
deriv(A*B,X,A*DB+B*DA) :-
    deriv(A,X,DA),
    deriv(B,X,DB).
deriv(A/B,X,(B*DA-A*DB)/(B*B)) :-
    deriv(A,X,DA),
    deriv(B,X,DB).

deriv(-A,X,-DA) :-
    deriv(A,X,DA).
deriv(A^B,X,B*(A^(B-1))*DA) :-  % only works when B does not involve X
    deriv(A,X,DA).
deriv(sin(E),X,cos(E)*DE) :-
    deriv(E,X,DE).
deriv(cos(E),X,-sin(E)*DE) :-
    deriv(E,X,DE).
deriv(exp(E),X,exp(E)*DE) :-
    deriv(E,X,DE).
deriv(log(E),X,DE/E) :-
  deriv(E,X,DE).
