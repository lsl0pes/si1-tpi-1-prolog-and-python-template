
% The following code assumes a search domain implemented  
% by the following procedures:
% -- actions(Domain,State,LActions)
% -- result(Domain,State,Action,NewState)
% -- satisfies(Domain,State,Goal)
% -- cost(Domain,State,Action,Cost)
% -- heuristic(Domain,State,Goal,Heuristic)
% (to be implemented in specific applications)

% We allow each search domain to be located in a different file
:- multifile(actions/3).
:- multifile(result/4).
:- multifile(satisfies/3).
:- multifile(cost/4).
:- multifile(heuristic/4).

% search configuration

configure_search(Version)
:- retractall(search_version(_)),
   assert(search_version(Version)).

% Different versions can be implemented in different files;
% the following procedures depend on search version

:- multifile(search_step/6).
:- multifile(make_node/6).

% search algorithm

search(Domain,Initial,Goal,Strategy,Solution)
:- init_search(Domain,Initial,Goal,RootID),
   search_rec(Domain,[RootID],Goal,Strategy,Solution).

init_search(Domain,Initial,Goal,RootID)
:- retractall(node(_,_,_,_)), 
   retractall(lastID(_)), 
   retractall(solution_node(_)),
   %nl, writeln('new search now'), nl,
   make_node(Domain,Initial,Goal,none,none,RootID).

search_rec(Domain,[ID|_],Goal,_,Solution)
:- node(ID,State,_,_),
   satisfies(Domain,State,Goal), !,
   assert(solution_node(ID)),
   get_path(ID,Solution).
search_rec(Domain,[ID|OpenNodes],Goal,Strategy,Solution)
:- node(ID,_,_,_),
   search_step(Domain,ID,OpenNodes,Goal,Strategy,NewOpenNodes),
   %length(OpenNodes,N), writeln(' '-N),
   search_rec(Domain,NewOpenNodes,Goal,Strategy,Solution).


search_step(Domain,ID,OpenNodes,Goal,Strategy,NewOpenNodes)
:- search_version(basic),
   node(ID,State,_,_),
   actions(Domain,State,LActions),
   %writeln(State-LActions),
   findall(NewID, ( member(A,LActions), 
                    result(Domain,State,A,NewState),
                    get_path(ID,Path),
                    \+ member(NewState,Path),
                    make_node(Domain,NewState,Goal,ID,A,NewID) ), LNewNodes),
   add_to_open(OpenNodes,LNewNodes,Strategy,NewOpenNodes).


add_to_open(OpenNodes,LNewNodes,breadth,NewOpenNodes)
:- append(OpenNodes,LNewNodes,NewOpenNodes).
add_to_open(OpenNodes,LNewNodes,depth,NewOpenNodes)
:- append(LNewNodes,OpenNodes,NewOpenNodes).
add_to_open(OpenNodes,LNewNodes,astar,NewOpenNodes)
:- astar_add_to_open(OpenNodes,LNewNodes,NewOpenNodes).
add_to_open(OpenNodes,LNewNodes,(astar,Maxsize),NewOpenNodes)
:- astar_add_to_open(OpenNodes,LNewNodes,Nodes),
   manage_memory(Nodes,Maxsize,NewOpenNodes).

get_path(none,[]) :- !.
get_path(ID,Path)
:- node(ID,State,ParentID,_),
   get_path(ParentID,Path0),
   append(Path0,[State],Path).

% search nodes represented as facts in the Prolog database
% -- node(ID,State,ParentID,Extra), where Extra is version-dependent
% -- lastID(LastID), where LastID is the ID of the last node created

% create a new node
% -- make_node(Domain,State,Goal,ParentID,Action,NewID)

make_node(_,State,_,ParentID,_,NewID)
:- search_version(basic),
   ( retract(lastID(LastID)), !;
     LastID = 0 ),
   NewID is LastID+1,
   assert(node(NewID,State,ParentID,none)),
   assert(lastID(NewID)).

tree_size(Terminals,NonTerminals) % ex. 5
:- findall(ID, ( node(ID,_,_,_), \+ node(_,_,ID,_) ), L), length(L,Terminals),
   lastID(Total),NonTerminals is Total-Terminals.

avg_branching_factor(ABF) % ex. 6
:- tree_size(T,NT),
   ABF is (T+NT-1)/NT.

:- use_module(library(pairs)).
 
sort_nodes_by_evalfunc(Nodes,EvalFunc,SortedNodes)
:- map_list_to_pairs(EvalFunc, Nodes, Pairs),
   keysort(Pairs, SortedPairs),
   pairs_values(SortedPairs, SortedNodes).



:- set_prolog_flag(stack_limit, 8_000_000_000).
%:- set_prolog_flag(stack_limit, 8_589_934_592).
%:- set_prolog_flag(stack_limit, 60_179_869_184).


