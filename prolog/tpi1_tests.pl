
:- [citydata].
:- [cidades].
:- [tpi1].


:- configure_search(basic).

:- search(cidades,braga,faro,breadth,Solution), 
   writeln(Solution).

:- search(cidades,braga,faro,depth,Solution), 
   writeln(Solution).

:- orderdelivery_search(lisboa,[faro,beja,evora,portalegre],breadth,Solution),
   findall(C,member((C,_),Solution),Path),
   writeln(Path).


:- configure_search(tpi1).

:- search(cidades,braga,faro,breadth,Solution), 
   writeln(Solution),
   solution_node(ID), node(ID,_,_,Data), writeln(Data),
   lastID(LastID), writeln(LastID).

:- search(cidades,braga,faro,depth,Solution), 
   writeln(Solution),
   solution_node(ID), node(ID,_,_,Data), writeln(Data),
   lastID(LastID), writeln(LastID).

:- orderdelivery_search(lisboa,[faro,beja,evora,portalegre],breadth,Solution),
   findall(C,member((C,_),Solution),Path),
   writeln(Path),
   solution_node(ID), node(ID,_,_,Data), writeln(Data),
   lastID(LastID), writeln(LastID).

:- orderdelivery_search(lisboa,[beja,evora,portalegre],breadth,Solution),
   findall(C,member((C,_),Solution),Path),
   writeln(Path),
   solution_node(ID), node(ID,_,_,Data), writeln(Data),
   lastID(LastID), writeln(LastID).

:- orderdelivery_search(lisboa,[beja,evora,portalegre],astar,Solution),
   findall(C,member((C,_),Solution),Path),
   writeln(Path),
   solution_node(ID), node(ID,_,_,Data), writeln(Data),
   lastID(LastID), writeln(LastID).

:- orderdelivery_search(aveiro,[coimbra,porto,braga,leiria],astar,Solution),
   findall(C,member((C,_),Solution),Path),
   writeln(Path),
   solution_node(ID), node(ID,_,_,Data), writeln(Data),
   lastID(LastID), writeln(LastID).


