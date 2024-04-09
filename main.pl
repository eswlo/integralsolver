:- use_module(evaluate).
:- use_module(derivatives).
:- use_module(integrator).
:- use_module(definite).
:- use_module(ivp).

% =====================
% To use this, type [main], then "begin."
% Follow the instructions. Because of the way read works, if you just do . with nothing before it, it will crash.



begin :-
    write("============================================================================================================
") , nl,
    write("                                \033[33mHello! Welcome to our CPSC 312 Project!\033[0m                                
") ,nl,
    write("============================================================================================================
") , nl,
    write("\033[31m(>^-^)>\033[0m"), nl,
    write("\033[32m(>^-^)>\033[0m"), nl,
    write("\033[33m(>^-^)>\033[0m"), nl,
    write("\033[34m(>^-^)>\033[0m"), nl,
    write("\033[35m(>^-^)>\033[0m"), nl,
    write("\033[36m(>^-^)>\033[0m"), nl,
    write("\033[37m(>^-^)>\033[0m"), nl,
    main_menu.

main_menu :-
    write("============================================================================================================
") , nl,
    write("                                \033[33mWhat would you like to do?\033[0m                                
") ,nl,
    write("============================================================================================================
") , nl,
    write("1. Find anti-derivative"), nl,
    write("2. Solve definite integral"), nl,
    write("3. Solve initial value problems"), nl,
    write("4. Exit"), nl,
    write("Please enter your selection: "),
    read(Selection),
    process_choice(Selection).

% Pattern matching for choices.

process_choice(1) :- 
    antiderivative_block.

process_choice(2) :- 
    definite_block.

process_choice(3) :-
    ivp_block.

process_choice(4) :- 
    write("============================================================================================================
") , nl,
    write("                                \033[33mThanks for using our calculator!\033[0m                                
") ,nl,
    write("============================================================================================================
") , nl.


process_choice(_) :- 
    write("Invalid Choice! Please try pick one of the available choices."), nl,
    main_menu.


% Method to be shared
block_end(Block) :-
    write("Would you like to perform the operation again? Type yes or anything else to return to main menu"),
    read(Answer),
    Answer == yes -> call(Block) ; main_menu.


antiderivative_block :-
    write("============================================================================================================
") , nl,
    write("                                \033[33mAnti-derivative\033[0m                                
") ,nl,
    write("============================================================================================================
") , nl,
    write("Please enter the expression to find its anti-derivative: "),
    read(Expression),
    write("Please enter the variable with respect to which the antiderivative is being calculated: "),
    read(Variable),
    integrate(Expression, Variable, IntegratedExpression) ->
        format("The anti-derivative of ~w with respect to ~w is: \033[33m~w\033[0m", [Expression, Variable, IntegratedExpression + c]),nl,block_end(antiderivative_block);
        format("The expression ~w cannot be integrated with respect to ~w", [Expression,Variable]), nl, block_end(antiderivative_block).

definite_block :-
    nl,
    write("============================================================================================================"), nl,
    write("                                \033[33mDefinite Integration\033[0m                                "), nl,
    write("============================================================================================================"), nl,
    write("Please enter the expression to integrate: "),
    read(Expression),
    write("Please enter the start of integration: "),
    read(Start),
    write("Please enter the end of integration: "),
    read(End),
    definite(Expression, Start, End, Result) ->
        format("The definite integral of ~w with start ~w and end ~w is: \033[33m~w\033[0m ", [Expression,Start,End,Result]), nl, block_end(definite_block);
        format("Definite Integration of ~w with start ~w and end ~w cannot be found",[Expression, Start, End]),nl,block_end(definite_block).

ivp_block :-
    nl,
    write("============================================================================================================"), nl,
    write("                                \033[33mSolve Initial Value Problem (IVP)\033[0m                                "), nl,
    write("============================================================================================================"), nl,
    write("Please enter the differential equation function for which to find the solution: "),
    read(Function),
    write("Please enter the variable with respect to which the differentiation is done: "),
    read(Variable),
    write("Please enter the initial value of the independent variable (e.g., x0)"), nl,
    write("note: for trig, the unit is degree: "),
    read(X),
    write("Please enter the initial value of the dependent variable (e.g., y0): "),
    read(Y),
    ivp(Function, Variable, X, Y, Result) ->
        format("The solution is: \033[33m~w\033[0m ", [Result]), nl, block_end(ivp_block);
        format("Solution not found"),nl,block_end(ivp_block).
    