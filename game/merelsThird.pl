:- use_module([library(lists), io]).

% initial board is just an empty list
% merels are added by adding a pair(Position, Merel) to the list
initial_board([]).

% valid positions on the board
valid_positions([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x]).

% the two players of the game
is_player1(■).
is_player2(□).

% succeeds if the argument is a player
is_merel(Player) :- is_player1(Player).
is_merel(Player) :- is_player2(Player).

% succeeds that the two arguments are the two (different) players
other_player(Player1, Player2) :- is_player1(Player1), is_player2(Player2).
other_player(Player1, Player2) :- is_player1(Player2), is_player2(Player1).

% succeeds if the first argument is of the form p(Point, Merel)
pair(p(Point, Merel), Point, Merel) :-  % succeeds if
        is_merel(Merel),                % Player is a valid player
        valid_positions(ValidPoints),   % unifies with the valid positions
        member(Point, ValidPoints).     % succeeds if Point is valid

% succeeds if the given pair is in the board
merel_on_board(Pair, Board) :-  % succeeds if
        pair(Pair, _, _),       % Pair is a valid pair
        member(Pair, Board).    % Pair is contained in Board

% Succeeds if the three arguments (pairs) are in a row
% Works by defining all the valid rows that are possible on a board
% The row succeeds if the same (valid) merel is on each position
% horizontal
row(p(a, X), p(b, X), p(c, X)) :- is_merel(X).
row(p(d, X), p(e, X), p(f, X)) :- is_merel(X).
row(p(g, X), p(h, X), p(i, X)) :- is_merel(X).
row(p(j, X), p(k, X), p(l, X)) :- is_merel(X).
row(p(m, X), p(n, X), p(o, X)) :- is_merel(X).
row(p(p, X), p(q, X), p(r, X)) :- is_merel(X).
row(p(s, X), p(t, X), p(u, X)) :- is_merel(X).
row(p(v, X), p(w, X), p(x, X)) :- is_merel(X).

% vertical
row(p(a, X), p(j, X), p(v, X)) :- is_merel(X).
row(p(d, X), p(k, X), p(s, X)) :- is_merel(X).
row(p(g, X), p(l, X), p(p, X)) :- is_merel(X).
row(p(b, X), p(e, X), p(h, X)) :- is_merel(X).
row(p(q, X), p(t, X), p(w, X)) :- is_merel(X).
row(p(i, X), p(m, X), p(r, X)) :- is_merel(X).
row(p(f, X), p(n, X), p(u, X)) :- is_merel(X).
row(p(c, X), p(o, X), p(x, X)) :- is_merel(X).

% Succeeds if two points are connected
% Checks if the two points are connected by checking if there's a valid row containing
% the points (next to each other). It checks both permutations so that
% connected(a,b) and connected(b,a) both succeeds
connected(Point1, Point2) :- row(p(Point1, _), p(Point2, _), _).
connected(Point1, Point2) :- row(p(Point2, _), p(Point1, _), _).
connected(Point1, Point2) :- row(_, p(Point2, _), p(Point1, _)).
connected(Point1, Point2) :- row(_, p(Point1, _), p(Point2, _)).

% Auxiliary predicate to count the number of times a certain item appears in a list
count(List, Item, Count) :-
    include(match(Item), List, Matches),
    length(Matches, Count).

% Match condition to match the merel
match(Item, p(_, Item)).

% Succeeds if the player has valid moves on the Board
has_legal_move(Board, Player) :-
                member(p(Point, Player), Board),                        % unifies with a pair in the Board
                connected(Point, AdjacentPoint),                        % unifies with an adjacent point next to the one retrieved in the previous clause
                other_player(Player, OtherPlayer),                      % unifies to get the other player
                \+ (member(p(AdjacentPoint, Player), Board)),           % succeeds if there's at least one point not occupied by Player
                \+ (member(p(AdjacentPoint, OtherPlayer), Board)).      % succeeds if there's at least one point not occupied by OtherPlayer


% Succeeds when Player is the winner on the given Board
% Succeeds if OtherPlayer has no legal moves on the board
and_the_winner_is(Board, Player) :-
    other_player(Player, OtherPlayer),          % unifies to get OtherPlayer
    \+ (has_legal_move(Board, OtherPlayer)).    % succeeds if OtherPlayer has no legal moves

% Succeeds if OtherPlayer has 2 or less merels on the Board
and_the_winner_is(Board, Player) :-             % succeeds if
        other_player(Player, OtherPlayer),      % unifies to get OtherPlayer
        count(Board, OtherPlayer, Counter),     % unifies to get the number of merels of OtherPlayer
        Counter =< 2.                           % succeeds if Counter is less or equal to 2


% board representation
% ----------------------------------------------------------------
% playthrough

% Succeeds if the 3 pairs are in the Board
merels_on_board(Pair1, Pair2, Pair3, Board) :-
        merel_on_board(Pair1, Board),           % succeeds if Pair1 is in the Board
        merel_on_board(Pair2, Board),           % succeeds if Pair2 is in the Board
        merel_on_board(Pair3, Board).           % succeeds if Pair3 is in the Board

% Succeeds if Player formed a mill on the Board on a particular Point
% Succeeds if Point is part of a row and Player has 3 merels on that row
% It has 3 clauses because Point might be in any of the 3 points of a row
is_mill(Board, Player, Point) :- row(p(Point, Player), p(Point1, Player), p(Point2, Player)),
                                 merels_on_board(p(Point, Player), p(Point1, Player), p(Point2, Player), Board).
is_mill(Board, Player, Point) :- row(p(Point1, Player), p(Point, Player), p(Point2, Player)),
                                 merels_on_board(p(Point, Player), p(Point1, Player), p(Point2, Player), Board).
is_mill(Board, Player, Point) :- row(p(Point1, Player), p(Point2, Player), p(Point, Player)),
                                 merels_on_board(p(Point, Player), p(Point1, Player), p(Point2, Player), Board).

% Predicate to start the game
play :- welcome,                        % displays welcome message
        initial_board(Board),           % unifies to get the empty Board
        display_board(Board),           % displays the Board
        is_player1(Player),             % unifies to get Player 1
        play(12, Player, Board).        % calls play/3 with 18 merels

% Succeeds if there there are no merels to be placed and there is a winner on the board
% Checks if both players are winning on the Board
play(0, Player, Board) :- and_the_winner_is(Board, Player),
                          report_winner(Player).
play(0, Player, Board) :- other_player(Player, OtherPlayer),
                          and_the_winner_is(Board, OtherPlayer),
                          report_winner(OtherPlayer).


play(0, Player, Board) :- get_legal_move(Player, OldPoint, NewPoint, Board),
                          play(0, Player, Board, OldPoint, NewPoint).

play(Merels, Player, Board) :- get_legal_place(Player, Point, Board),
                               play(Merels, Player, Board, Point).

play(0, Player, Board, OldPoint, NewPoint) :- 
                          other_player(Player, OtherPlayer),
                          append(Board, [p(NewPoint, Player)], NewBoard),
                          delete(NewBoard, p(OldPoint, Player), NewerBoard),
                          is_mill(NewerBoard, Player, NewPoint),
                          get_remove_point(Player, PointToRemove, NewerBoard),
                          delete(NewerBoard, p(PointToRemove, OtherPlayer), NewerErBoard),
                          display_board(NewerErBoard),
                          play(0, OtherPlayer, NewerErBoard).

play(0, Player, Board, OldPoint, NewPoint) :- 
                          other_player(Player, OtherPlayer),
                          append(Board, [p(NewPoint, Player)], NewBoard),
                          delete(NewBoard, p(OldPoint, Player), NewerBoard),
                          \+ (is_mill(NewerBoard, Player, NewPoint)),
                          display_board(NewerBoard),
                          play(0, OtherPlayer, NewerBoard).
                               

% merels left
% this is the case if a merel is placed and there is a mill, so it removes one
play(Merels, Player, Board, Point) :- append(Board, [p(Point, Player)], NewBoard),
                               other_player(Player, OtherPlayer),
                               is_mill(NewBoard, Player, Point),
                               get_remove_point(Player, PointToRemove, NewBoard),
                               delete(NewBoard, p(PointToRemove, OtherPlayer), NewerBoard),
                               LessMerels is Merels - 1,
                               display_board(NewerBoard),
                               play(LessMerels, OtherPlayer, NewerBoard).

% merelse left
% this is the case if a merel is placed and there is no mill
play(Merels, Player, Board, Point) :- append(Board, [p(Point, Player)], NewBoard),
                               \+ (is_mill(NewBoard, Player, Point)),
                               other_player(Player, OtherPlayer),
                               LessMerels is Merels - 1,
                               display_board(NewBoard),
                               play(LessMerels, OtherPlayer, NewBoard).