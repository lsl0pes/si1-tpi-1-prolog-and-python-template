
:- [tree_search].


% Search domain "orderdelivery"

actions(orderdelivery,(City,_),LActions)
:- findall((City,Neighbor), connected(City,Neighbor,_), LActions ).

result(orderdelivery,........
:- 

satisfies(orderdelivery,..............
:- .........

cost(orderdelivery,.........
:- ................

heuristic(orderdelivery,............
:- ........................


% search wrapper that abstracts away from the exact contents
% of the state representation;

orderdelivery_search(City,TargetCities,Strategy,Solution)
:- .............


% additional search functionalities

search_step(Domain,ID,OpenNodes,Goal,Strategy,NewOpenNodes)
:- search_version(tpi1),
   .....

make_node(Domain,State,Goal,ParentID,A,NewID)
:- search_version(tpi1),
   .....

astar_add_to_open(OpenNodes,LNewNodes,NewOpenNodes)
:- ............


