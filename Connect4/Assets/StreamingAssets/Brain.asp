%gameControllerSensor(gameController,objectIndex(Index),grid(gc(progressiveNumber(Value)))).
%gameControllerSensor(gameController,objectIndex(Index),grid(ground(Index1,Index2,cell(content(Value))))).
%gameControllerSensor(gameController,objectIndex(Index),grid(ground(Index1,Index2,cell(x(Value))))).
%gameControllerSensor(gameController,objectIndex(Index),grid(ground(Index1,Index2,cell(y(Value))))).


cell(Y,X,V) :- gameControllerSensor(gameController,objectIndex(Index),grid(ground(X,Y,cell(content(V))))).
numOfRows(N) :- #max{X : cell(X,_,_)}=M, N=M+1.
numOfColumns(N) :- #max{Y : cell(_,Y,_)}=M, N=M+1.
row(X) :- cell(X,_,_).
column(X) :- cell(_,X,_).

empty(X,Y) :- cell(X,Y,0).
filled(X,Y,P) :- cell(X,Y,P), P!=0.

bottomRow(Y,R) :- column(Y), #max{X : cell(X,Y,0)}=R.
playableCell(X,Y) :- empty(X,Y), bottomRow(Y,X).

sameRow(X,Y1,X,Y2) :- cell(X,Y1,_), cell(X,Y2,_), Y2=Y1+1.
sameColumn(X1,Y,X2,Y) :- cell(X1,Y,_), cell(X2,Y,_), X2=X1-1.
sameDiagA(X1,Y1,X2,Y2) :- cell(X1,Y1,_), cell(X2,Y2,_), X2=X1+1, Y2=Y1-1.
sameDiagB(X1,Y1,X2,Y2) :- cell(X1,Y1,_), cell(X2,Y2,_), X2=X1+1, Y2=Y1+1.

groupFour(X1,Y1,X2,Y2,X3,Y3,X4,Y4) :- sameRow(X1,Y1,X2,Y2), sameRow(X2,Y2,X3,Y3), sameRow(X3,Y3,X4,Y4).
groupFour(X1,Y1,X2,Y2,X3,Y3,X4,Y4) :- sameColumn(X1,Y1,X2,Y2), sameColumn(X2,Y2,X3,Y3), sameColumn(X3,Y3,X4,Y4).
groupFour(X1,Y1,X2,Y2,X3,Y3,X4,Y4) :- sameDiagA(X1,Y1,X2,Y2), sameDiagA(X2,Y2,X3,Y3), sameDiagA(X3,Y3,X4,Y4).
groupFour(X1,Y1,X2,Y2,X3,Y3,X4,Y4) :- sameDiagB(X1,Y1,X2,Y2), sameDiagB(X2,Y2,X3,Y3), sameDiagB(X3,Y3,X4,Y4).

possibleFour(X1,Y1,P) :- groupFour(X1,Y1,X2,Y2,X3,Y3,X4,Y4), filled(X2,Y2,P), filled(X3,Y3,P), filled(X4,Y4,P), empty(X1,Y1).
possibleFour(X2,Y2,P) :- groupFour(X1,Y1,X2,Y2,X3,Y3,X4,Y4), filled(X1,Y1,P), filled(X3,Y3,P), filled(X4,Y4,P), empty(X2,Y2).
possibleFour(X3,Y3,P) :- groupFour(X1,Y1,X2,Y2,X3,Y3,X4,Y4), filled(X1,Y1,P), filled(X2,Y2,P), filled(X4,Y4,P), empty(X3,Y3).
possibleFour(X4,Y4,P) :- groupFour(X1,Y1,X2,Y2,X3,Y3,X4,Y4), filled(X1,Y1,P), filled(X2,Y2,P), filled(X3,Y3,P), empty(X4,Y4).

possibleThree(X3,Y3,P) :- groupFour(X1,Y1,X2,Y2,X3,Y3,X4,Y4), filled(X1,Y1,P), filled(X2,Y2,P), empty(X3,Y3), empty(X4,Y4).
possibleThree(X4,Y4,P) :- groupFour(X1,Y1,X2,Y2,X3,Y3,X4,Y4), filled(X1,Y1,P), filled(X3,Y3,P), empty(X2,Y2), empty(X4,Y4).
possibleThree(X2,Y2,P) :- groupFour(X1,Y1,X2,Y2,X3,Y3,X4,Y4), filled(X1,Y1,P), filled(X4,Y4,P), empty(X2,Y2), empty(X3,Y3).
possibleThree(X1,Y1,P) :- groupFour(X1,Y1,X2,Y2,X3,Y3,X4,Y4), filled(X2,Y2,P), filled(X3,Y3,P), empty(X1,Y1), empty(X4,Y4).
possibleThree(X1,Y1,P) :- groupFour(X1,Y1,X2,Y2,X3,Y3,X4,Y4), filled(X2,Y2,P), filled(X4,Y4,P), empty(X1,Y1), empty(X3,Y3).
possibleThree(X2,Y2,P) :- groupFour(X1,Y1,X2,Y2,X3,Y3,X4,Y4), filled(X3,Y3,P), filled(X4,Y4,P), empty(X1,Y1), empty(X2,Y2).

possibleTwo(X2,Y2,P) :- groupFour(X1,Y1,X2,Y2,X3,Y3,X4,Y4), empty(X2,Y2), empty(X3,Y3), empty(X4,Y4), filled(X1,Y1,P).
possibleTwo(X3,Y3,P) :- groupFour(X1,Y1,X2,Y2,X3,Y3,X4,Y4), empty(X1,Y1), empty(X3,Y3), empty(X4,Y4), filled(X2,Y2,P).
possibleTwo(X2,Y2,P) :- groupFour(X1,Y1,X2,Y2,X3,Y3,X4,Y4), empty(X1,Y1), empty(X2,Y2), empty(X4,Y4), filled(X3,Y3,P).
possibleTwo(X3,Y3,P) :- groupFour(X1,Y1,X2,Y2,X3,Y3,X4,Y4), empty(X1,Y1), empty(X2,Y2), empty(X3,Y3), filled(X4,Y4,P).

removedCell(X,Y) :- possibleFour(X1,Y,2), playableCell(X,Y), X1=X-1, not possibleFour(X,Y,1), not possibleFour(X,Y,2).
removedCell(X,Y) :- possibleThree(X1,Y,2), playableCell(X,Y), X1=X-1, not possibleFour(X,Y,1), not possibleFour(X,Y,2).

bestCell(X,Y) | notBestCell(X,Y) :- playableCell(X,Y).
:- not #count{X,Y : bestCell(X,Y)}=1.

:~ bestCell(X,Y), removedCell(X,Y). [1@9,X,Y]
:~ possibleFour(X,Y,1), not bestCell(X,Y). [1@8,X,Y]
:~ possibleFour(X,Y,2), not bestCell(X,Y). [1@7,X,Y]
:~ possibleThree(X,Y,1), not bestCell(X,Y). [1@6,X,Y]
:~ possibleThree(X,Y,2), not bestCell(X,Y). [1@5,X,Y]
:~ possibleTwo(X,Y,1), not bestCell(X,Y). [1@4,X,Y]
:~ possibleTwo(X,Y,2), not bestCell(X,Y). [1@3,X,Y]
% :~ bestCell(X,Y). [X@2]
% :~ bestCell(X,Y). [Y@1]


setOnActuator(playerActuator(player,objectIndex(Index),aggiornaK(riga(X)))) :-objectIndex(playerActuator, Index), bestCell(X,_).
setOnActuator(playerActuator(player,objectIndex(Index),aggiornaK(col(Y)))) :-objectIndex(playerActuator, Index), bestCell(_,Y).
setOnActuator(playerActuator(player,objectIndex(Index),aggiornaK(aiProgressive(X)))) :-objectIndex(playerActuator, Index), gameControllerSensor(gameController,objectIndex(_),grid(gc(progressiveNumber(X)))).