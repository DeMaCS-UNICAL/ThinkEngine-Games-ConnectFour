%For runtime instantiated GameObject, only the prefab mapping is provided. Use that one substituting the gameobject name accordingly.
 %Sensors.
%gameControllerSensor(gameController,objectIndex(Index),grid(gc(progressiveNumber(Value)))).
%gameControllerSensor(gameController,objectIndex(Index),grid(ground(Index1,Index2,cell(content(Value))))).
%gameControllerSensor(gameController,objectIndex(Index),grid(ground(Index1,Index2,cell(x(Value))))).
%gameControllerSensor(gameController,objectIndex(Index),grid(ground(Index1,Index2,cell(y(Value))))).
%Actuators:
setOnActuator(playerActuator(player,objectIndex(Index),aggiornaK(riga(Value)))) :-objectIndex(playerActuator, Index), .
setOnActuator(playerActuator(player,objectIndex(Index),aggiornaK(col(Value)))) :-objectIndex(playerActuator, Index), .
setOnActuator(playerActuator(player,objectIndex(Index),aggiornaK(aiProgressive(Value)))) :-objectIndex(playerActuator, Index), .
