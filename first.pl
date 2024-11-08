command(Y,Z)       :- startcommand(Y,Z).
command(Y,Z)       :- stopcommand(Y,Z).
command(Y,Z)       :- savecommand(Y,Z).

startcommand(W,Z)  :- ’C’( W, start, X ),
                      ’C’( X, 1, Y ),
                      ’C’( Y, player, Z ).
startcommand(W,Z)  :- ’C’( W, start, X ),
                      number_gt_1(X,Y),
                      ’C’( Y, player, Z ).
                 
stopcommand(Y,Z)   :- ’C’( Y, stop, Z ).
savecommand(X,Z)   :- ’C’( X, save, Y ),
                      saveablething(Y,Z).

saveablething(Y,Z) :- ’C’( Y, game, Z ).
saveablething(X,Z) :- ’C’( X, player, Y ),
                      number(Y,Z).
                      
number(Y,Z)        :- ’C’( Y, X, Z ),
                      integer(X),
                      X>0.
               
number gt 1(Y,Z)   :- ’C’( Y, X, Z ),
                      integer(X),
                      X>1.