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
split(L2, 0, L1, L1, L2).
split([X | Xs], N, L1Temp, L1, L2) :- NN is N - 1, append(L1Temp, [X], LL), split(Xs, NN, LL, L1, L2).
% 1.7
rotate([H | T], R) :- rotate(T, H, R).
rotate([], H, [H]).
rotate([E | T], H, [E | R]) :- rotate(T, H, R).
% 1.8
die(X) :- die(1, 6, X).
die(S, _, S).
die(C, E, X) :- C < E, CNext is C + 1, die(CNext, E, X).
% 1.9
three_dice(N, [D1, D2, D3]) :- die(D1), die(D2), die(D3), DD is D1 + D2 + D3, DD =:= N.

% 2.2
dropFirst(X, [X | T], T) :- !.
dropFirst(X, [H | Xs], [H | L]) :- dropFirst(X, Xs, L).

dropLast(X, [H | Xs], [H | L]) :- dropLast(X, Xs, L), !.
dropLast(X, [X | T], T).

dropAll(_, [], []).
dropAll(X, [X | T], L) :- !, dropAll(X, T, L).
dropAll(X, [H | Xs], [H | L]) :- dropAll(X, Xs, L).

% 3.1
% fromList(+List, -Graph)
fromList([_], []).
fromList([H1, H2 | T], [e(H1, H2) | L]) :- fromList([H2 | T], L).
% 3.2
fromCircList([H | T], G) :- fromCircList(H, [H | T], G).
fromCircList(F, [E], [e(E, F)]).
fromCircList(F, [H1, H2 | T], [e(H1, H2) | L]) :- fromCircList(F, [H2 | T], L).
% 3.3
outDegree(G, N, D) :- outDegree(G, N, 0, D).
outDegree([], _, D, D).
outDegree([e(N, _) | G], N, DTemp, D) :- DD is DTemp + 1, outDegree(G, N, DD, D), !.
outDegree([_ | G], N, DTemp, D) :- outDegree(G, N, DTemp, D).
% 3.4
% Not working
dropNode(G, N, OG) :- dropAll(e(N, _), G, G2), dropAll(e(_, N), G2, OG).
% 3.5
reaching([], _, []).
reaching([e(N, F) | G], N, [F | L]) :- reaching(G, N, L), !.
reaching([_ | G], N, L) :- reaching(G, N, L).
% 3.6
nodes(G, L) :- nodes(G, [], L).
nodes([], L, L).
nodes([e(E, F) | G], LTemp, L) :- member(E, LTemp), not(member(F, LTemp)), !, nodes(G, [F | LTemp], L).
nodes([e(E, F) | G], LTemp, L) :- not(member(E, LTemp)), member(F, LTemp), !, nodes(G, [E | LTemp], L).
nodes([e(E, F) | G], LTemp, L) :- not(member(E, LTemp)), not(member(F, LTemp)), !, nodes(G, [E, F | LTemp], L).
nodes([_ | G], LTemp, L) :- nodes(G, LTemp, L).
% 3.7
anypath([e(N1, N2) | _], N1, N2, [e(N1, N2)]).
anypath([e(N1, N3) | G], N1, N2, [e(N1, N3) | LL]) :- anypath(G, N3, N2, LL).
anypath([_ | G], N1, N2, L) :- anypath(G, N1, N2, L).
% 3.8
allreaching([], _, []).
allreaching(G, N, LL) :- findall(N2, anypath(G, N, N2, _), LL).
