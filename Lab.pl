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
% Fully relational.
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
split(L, N, L1, L2) :- split(L, N, [], L1, L2).
split(L, 0, L1, L1, L).
split([X | Xs], N, L1Temp, L1, L2) :- NNew is N - 1, append(L1Temp, [X], L1New), split(Xs, NNew, L1New, L1, L2).
% 1.7
rotate([X | Xs], R) :- append(Xs, [X], R).
% 1.8
die(X) :- die(1, 6, X).
die(S, _, S).
die(C, E, X) :- C < E, CNext is C + 1, die(CNext, E, X).
% 1.9
% Can't make it stop early.
three_dice(N, L) :- three_dice(N, L, L).
three_dice(0, L, L) :- !.
three_dice(N, L, L) :-
  NN is N - 1,
  three_dice(NN, [D1, D2, D3], L),
  die(D1), die(D2), die(D3).

% 2.2
dropFirst(X, [X | T], T) :- !.
dropFirst(X, [H | Xs], [H | L]) :- dropFirst(X, Xs, L).

dropLast(X, [H | Xs], [H | L]) :- dropLast(X, Xs, L), !.
dropLast(X, [X | T], T).

dropAll(_, [], []).
dropAll(X, [X | T], L) :- dropAll(X, T, L), !.
dropAll(X, [H | Xs], [H | L]) :- dropAll(X, Xs, L).

% 3.1
% fromList(+List, -Graph)
fromList([_], []).
fromList([H1, H2 | T], [e(H1, H2) | L]) :- fromList([H2 | T], L).
% 3.2
fromCircList([H | T], G) :- fromCircList(H, [H | T], G).
fromCircList(F, [E], [e(E, F)]).
fromCircList(F, [H1, H2 | T], [e(H1, H2) | L]) :- fromCircList(F, [H2 | T], L).