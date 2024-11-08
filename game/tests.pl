:- use_module(merels).

% tests that valid_position is true when its argument is a valid point
:- valid_position(a).
:- valid_position(b).
:- valid_position(c).
:- valid_position(x).
:- \+ valid_position(y).
:- \+ valid_position(z).

% tests that the rows are correct
:- row(a, b, c).
:- row(d, e, f).
:- row(g, h, i).
:- row(j, k, l).
:- row(m, n, o).
:- row(p, q, r).
:- row(s, t, u).
:- row(v, w, x).
:- row(a, j, v).
:- row(d, k, s).
:- row(g, l, p).
:- row(b, e, h).
:- row(q, t, s).
:- row(i, m, r). %,
:- row(f, n, u).
:- row(c, o, x).
:- \+ row(a, b, d).
:- \+ row(g, a, x).
:- \+ row(i, y, j).


% tests that is_player1 is true only when x is the parameter
:- is_player1(y).
:- \+ is_player1(z).

% tests that is_player2 is true only when y is the parameter
:- is_player2(z).
:- \+ is_player2(y).

% tests that is_merel is true only when the parameter is either x or y
:- is_merel(y).
:- is_merel(z).
:- \+ is_merel(x).

% tests that other_player is true only when the parameters are two different existing players
:- other_player(y, z).
:- other_player(z, y).
:- \+ other_player(y, y).
:- \+ other_player(z, z).
:- \+ other_player(z, x).

% tests that pair is true when the pair is in the correct format
:- pair(first-second, first, second).
:- pair(first-first, first, first).
:- \+ pair(first-second, second, first).
:- \+ pair(first, first, second).

% tests that the first argument is a valid pair and the second argument is a valid position
:- merel_on_board(a-b, a).
:- merel_on_board(b-a, b).
:- merel_on_board(sium-ses, g).
:- merel_on_board(zio-ken, t).
:- \+ merel_on_board(sium, a).
:- \+ merel_on_board([ao, zi], a).
:- \+ merel_on_board(a-b, z).

% tests that connected is true if the two points are connected in the board
:- connected(a, b).
:- connected(b, a).
:- connected(a, j).
:- connected(j, a).
:- \+ connected(a, c).
:- \+ connected(a, d).
:- \+ connected(g, p).
:- \+ connected(r, u).

% tests that initial_board is true when the argument is the empty board
:- initial_board([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x]).
:- \+ initial_board([d,e,f,g,h,i,j,k,l,m,n,p,q,r,s,t,u,v,w,x]).
:- \+ initial_board([a,b,c,d,e,t,u,v,w,x]).
:- \+ initial_board([a,b,c,d,e,f,g,h,i,j,r,s,t,u,v,w,x]).