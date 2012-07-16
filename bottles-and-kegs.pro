
% BOTTLES AND KEGS SOLVER
% by Alex Nisnevich
%
% Compiled under GNU Prolog (gprolog) 1.3.0.
% Uses FD for finite-domain constraint solving.
% Valid for values up to 1000.
%
% Run with
%   prolog --entry-goal "consult('bottles-and-kegs.pro')"
% Then run
%   fd_set_vector_max(1000).
%
% Example usage:
% ?- for(X, 1, 1000), sequence('bottles', 'bottles', 'kegs', X).
% X = 81 ?

forall(X) :- fd_domain(X, 1, 1000).

is_bottle(N) :- forall(X), forall(N), N #=# X * 7.
is_bottle(N) :- fd_domain(X, 0, 999), forall(N), N #=# (X * 10) + 7. % ab7
is_bottle(N) :- fd_domain(X, 0, 99), fd_domain(Y, 70, 79), forall(N), N #=# (X * 100) + Y. % a7b
is_bottle(N) :- fd_domain(N, 700, 799). % 7ab

is_keg(N) :- forall(X), forall(N), N #=# X * 5.
is_keg(N) :- fd_domain(X, 0, 99), fd_domain(Y, 50, 59), forall(N), N #=# (X * 100) + Y. % a5b
is_keg(N) :- fd_domain(N, 500, 599). % 5ab

bk(N, N) :- \+ is_bottle(N), \+ is_keg(N).
bk(N, 'bottles') :- is_bottle(N).
bk(N, 'kegs') :- is_keg(N).
bk(N, 'bottles and kegs') :- is_bottle(N), is_keg(N).

sequence(A, B) :- forall(X), forall(Y), Y #=# X + 1, bk(X, A), bk(Y, B).
sequence(A, B, C) :- forall(X), forall(Y), forall(Z), Y #=# X + 1, Z #=# X + 2, bk(X, A), bk(Y, B), bk(Z, C).
sequence(A, B, C, D) :- forall(X), forall(Y), forall(Z), forall(W), Y #=# X + 1, Z #=# X + 2, W #=# X + 3, bk(X, A), bk(Y, B), bk(Z, C), bk(W, D).
sequence(A, B, C, D, E) :- forall(X), forall(Y), forall(Z), forall(W), forall(V), Y #=# X + 1, Z #=# X + 2, W #=# X + 3, V #=# X + 4, bk(X, A), bk(Y, B), bk(Z, C), bk(W, D), bk(V, E).
