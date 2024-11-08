:- use_module([library(lists), io]).

% is true if the position is contained in the list of valid positions

% represents the empty board
empty_board([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x]).

% represents a possible board
board([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]).

valid_position(Point) :- empty_board(Board), member(Point, Board).

% valid horizontal rows
is_row(a, b, c).
is_row(d, e, f).
is_row(g, h, i).
is_row(j, k, l).
is_row(m, n, o).
is_row(p, q, r).
is_row(s, t, u).
is_row(v, w, x).

% valid vertical rows
is_row(a, j, v).
is_row(d, k, s).
is_row(g, l, p).
is_row(b, e, h).
is_row(q, t, s).
is_row(i, m, r).
is_row(f, n, u).
is_row(c, o, x).

% ,

% is_player1/1 succeds when the argument is the player character y
is_player1(y).

% is_player2/1 succeds when the argument is the player character z
is_player2(z).

% is_merel/1 succeds when the argument is either of the player characters
is_merel(Player) :- is_player1(Player).
is_merel(Player) :- is_player2(Player).

% other_player/2 succeds when both its arguments are player representation charcaters, but they are different
other_player(Player1, Player2) :- is_merel(Player1),
                                  is_merel(Player2),
                                  \+ (Player1 = Player2).

% succeeds when its first argument is a pair made up of its second, a point, and its third, a merel.
pair(Point-Merel, Point, Merel).

% succeeds when its first argument is a merel/point pair and its second is a representation of the merel positions on the board. Argument 2 is assumed to be instantiated.
merel_on_board(Merel_point_pair, Merel_position) :-
            pair(Merel_point_pair, _, _),
            valid_position(Merel_position).


% succeeds when its three arguments are (in order) a connected row, vertical or horizontal, in the board
row(Point1, Point2, Point3) :- is_row(Point1, Point2, Point3).

% succeeds when its two arguments are the names of points on the board which are connected by a line (i.e., there is a valid move between them)
connected(Point1, Point2) :- is_row(Point1, Point2, _).
connected(Point1, Point2) :- is_row(Point2, Point1, _).
connected(Point1, Point2) :- is_row(_, Point2, Point1).
connected(Point1, Point2) :- is_row(_, Point1, Point2).

% succeeds when its argument represents the initial state of the board
initial_board(State) :- empty_board(State).