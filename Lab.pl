% 1.1
search2(E, [X1, X2 | _]) :- [E, E] = [X1, X2].
search2(E, [_ | Xs]) :- search2(E, Xs).
% 1.2
search_two(E, [X1, X2, X3 | _]) :- [E, _, E] = [X1, X2, X3].
search_two(E, [_ | Xs]) :- search_two(E, Xs).
% 1.3
size(L, S) :- size(L, 0, S).
size([], N, N).
size([X | Xs], N, S) :- N2 is N + 1, size(Xs, N2, S).
% È completamente relazionale.
% 1.4
sum(L, S) :- sum(L, 0, S).
sum([], N, N).
sum([X | Xs], N, S) :- N2 is N + X, sum(Xs, N2, S).
% 1.5
max([X | Xs], Max, Min) :- max(Xs, X, X, Max, Min).
max([], Max, Min, Max, Min).
max([X | Xs], MaxTemp, MinTemp, Max, Min) :- X > MaxTemp, !, max(Xs, X, MinTemp, Max, Min).
max([X | Xs], MaxTemp, MinTemp, Max, Min) :- X < MinTemp, !, max(Xs, MaxTemp, X, Max, Min).
max([X | Xs], MaxTemp, MinTemp, Max, Min) :- max(Xs, MaxTemp, MinTemp, Max, Min).
% 1.6
split([], _, [], []).
split([X | Xs], N2, L1, L2) :-  