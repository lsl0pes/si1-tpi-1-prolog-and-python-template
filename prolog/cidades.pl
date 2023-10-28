
actions(cidades,City,LActions)
:- findall((City,Neighbor), connected(City,Neighbor,_), LActions ).

result(cidades,City,(City,Neighbor),Neighbor).

satisfies(cidades,City,City).

cost(cidades,City,(City,Neighbor),Cost)   % ex. 7
:- connected(City,Neighbor,Cost).

heuristic(cidades,City,GoalCity,Dist)
:- coordinates(City,X1,Y1),
   coordinates(GoalCity,X2,Y2),
   DX is X1-X2, DY is Y1-Y2,
   Dist is round(sqrt(DX^2 + DY^2)).

