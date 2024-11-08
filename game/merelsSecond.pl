:- use_module([library(lists), io]).

empty_board([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x]).

is_point(X) :- empty_board(Board), member(X, Board).

is_player1(y).
is_player2(z).

is_merel(Player) :- is_player1(Player).
is_merel(Player) :- is_player2(Player).

other_player(Player1, Player2) :- is_player1(Player1), is_player2(Player2).
other_player(Player1, Player2) :- is_player1(Player2), is_player2(Player1).

pair(Point-Merel, Point, Merel) :- is_point(Point), is_merel(Merel).

/*
merel_on_board(Pair, Position) :-
        pair(Pair, Point, Merel),
        empty_board(Board),
        select(Point, Board, Merel, NewBoard),
        merel_on_board(Pair, NewBoard, sium).
*/

% merel_on_board(a-y, [y,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x]) true
% merel_on_board(a-y, [y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y,y]) true

% 1- get index of the Position in the first argument Pair
% 2- check that in the board provided, the merel is in that position

merel_on_board(Pair, Position) :-
        pair(Pair, Point, Merel),
        empty_board(Board),
        nth0(Index, Board, Point),
        nth0(Index, Position, Merel).



row(a, b, c).
row(d, e, f).
row(g, h, i).
row(j, k, l).
row(m, n, o).
row(p, q, r).
row(s, t, u).
row(v, w, x).

row(a, j, v).
row(d, k, s).
row(g, l, p).
row(b, e, h).
row(c, o, x).
row(q, t, s).
row(i, m, r).
row(f, n, u).

connected(Point1, Point2) :- row(Point1, Point2, _).
connected(Point1, Point2) :- row(Point2, Point1, _).
connected(Point1, Point2) :- row(_, Point2, Point1).
connected(Point1, Point2) :- row(_, Point1, Point2).

initial_board(Board) :- empty_board(Board).

count([],_,0).
count([Head|Tail], Head, Counter):- count(Tail, Head, X), Counter is 1 + X.
count([_|Tail], Item, Counter):- count(Tail, Item, Counter).

% first condition, if the other player has 2 or less merels on the board
and_the_winner_is(Board, Player1) :-
        other_player(Player1, Player2),
        count(Board, Player2, Counter),
        Counter =< 2.

% second condition, if the other player has no legal moves
% if, for every merel of Player2, all the possible connections are merels
and_the_winner_is(Board, Player1) :-
        other_player(Player1, Player2),










:- and_the_winner_is([y,z,z,d,z,f,g,h,i,z,k,l,m,n,o,p,q,r,s,t,u,v,w,x], z).
:- and_the_winner_is([a,z,c,d,z,f,g,h,z,j,k,l,m,y,o,p,q,r,y,t,u,v,w,x], z).
:- and_the_winner_is([a,b,c,d,z,z,g,y,i,j,k,l,m,y,o,p,q,r,s,t,z,v,w,x], z).
:- and_the_winner_is([a,b,y,d,z,f,y,h,i,z,k,l,m,n,o,z,q,r,s,t,u,v,z,x], z).
:- and_the_winner_is([a,b,c,d,e,z,g,h,y,j,k,y,m,n,z,p,z,r,s,t,u,v,w,x], z).
:- and_the_winner_is([a,y,c,d,y,f,g,z,i,j,k,l,z,n,o,p,q,r,s,t,z,v,z,x], z).
:- and_the_winner_is([y,z,c,d,e,f,g,h,y,j,z,l,m,n,o,z,q,z,s,t,u,v,w,x], z).
:- and_the_winner_is([a,b,c,d,y,f,z,h,i,j,y,l,m,z,o,p,q,z,s,t,u,v,w,z], z).
:- and_the_winner_is([a,z,y,d,e,f,y,h,i,j,k,l,z,n,z,p,z,r,s,t,z,v,w,x], z).
:- and_the_winner_is([a,b,c,d,e,y,g,h,i,z,y,l,m,n,o,p,q,z,z,t,u,v,w,z], z).

:- and_the_winner_is([z,b,y,z,y,f,g,h,i,j,y,l,m,n,o,p,q,y,s,t,u,v,w,x], y).
:- and_the_winner_is([a,b,c,z,y,z,g,y,i,j,k,l,y,n,o,p,q,r,s,t,u,v,w,x], y).
:- and_the_winner_is([a,y,c,d,e,f,z,y,z,j,k,l,m,n,o,p,q,r,s,t,u,y,w,x], y).
:- and_the_winner_is([y,b,c,d,y,f,g,h,i,z,y,l,m,n,o,p,q,r,s,t,u,v,w,x], y).
:- and_the_winner_is([a,b,y,d,e,y,g,h,i,j,k,l,y,n,z,p,q,r,s,t,u,y,w,z], y).
:- and_the_winner_is([a,b,c,d,e,f,y,h,i,j,y,l,m,n,o,p,q,r,y,t,u,v,w,z], y).
:- and_the_winner_is([a,y,c,y,e,f,g,h,i,j,k,l,m,n,y,p,q,r,s,z,z,v,w,x], y).
:- and_the_winner_is([a,b,c,y,e,f,g,y,i,j,k,l,z,n,o,p,q,y,s,t,u,z,w,x], y).
:- and_the_winner_is([y,b,c,d,e,y,g,h,i,z,k,l,y,n,o,p,q,r,s,t,u,v,y,x], y).
:- and_the_winner_is([a,b,c,d,e,f,y,z,i,y,k,l,m,n,o,y,q,r,s,z,u,v,w,x], y).