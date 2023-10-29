
:- [citydata].
:- [cidades].
:- [tpi1].

% example


:- configure_search(tpi1).


:- search(cidades,braga,faro,depth,Solution), 
   writeln('Depth':Solution),
   size_info(NT,T), writeln('Non terminals':NT / 'Terminals':T),
   solution_node(ID), node(ID,_,_,Data), writeln('Solution node':Data),
   lastID(LastID), writeln('LastID':LastID), nl.

:- search(cidades,braga,faro,breadth,Solution), 
   writeln('Breadth':Solution),
   size_info(NT,T), writeln('Non terminals':NT / 'Terminals':T),
   solution_node(ID), node(ID,_,_,Data), writeln('Solution node':Data),
   lastID(LastID), writeln('LastID':LastID), nl.

:- search(cidades,braga,faro,astar,Solution), 
   writeln('A*':Solution),
   size_info(NT,T), writeln('Non terminals':NT / 'Terminals':T),
   solution_node(ID), node(ID,_,_,Data), writeln('Solution node':Data),
   lastID(LastID), writeln('LastID':LastID), nl.

:- search(cidades,braga,faro,(astar,180),Solution), 
   writeln(('A*',maxsize=180):Solution),
   size_info(NT,T), writeln('Non terminals':NT / 'Terminals':T),
   solution_node(ID), node(ID,_,_,Data), writeln('Solution node':Data),
   lastID(LastID), writeln('LastID':LastID), nl.

%

:- orderdelivery_search(lisboa,[faro,beja,evora,portalegre],breadth,Solution),
   findall(C,member((C,_),Solution),Path),
   writeln('Breadth':Path),
   size_info(NT,T), writeln('Non terminals':NT / 'Terminals':T),
   solution_node(ID), node(ID,_,_,Data), writeln('Solution node':Data),
   lastID(LastID), writeln('LastID':LastID), nl.

:- orderdelivery_search(lisboa,[beja,evora,portalegre],breadth,Solution),
   findall(C,member((C,_),Solution),Path),
   writeln('Breadth':Path),
   size_info(NT,T), writeln('Non terminals':NT / 'Terminals':T),
   solution_node(ID), node(ID,_,_,Data), writeln('Solution node':Data),
   lastID(LastID), writeln('LastID':LastID), nl.

:- orderdelivery_search(lisboa,[beja,evora,portalegre],astar,Solution),
   findall(C,member((C,_),Solution),Path),
   writeln('A*':Path),
   size_info(NT,T), writeln('Non terminals':NT / 'Terminals':T),
   solution_node(ID), node(ID,_,_,Data), writeln('Solution node':Data),
   lastID(LastID), writeln('LastID':LastID), nl.

:- orderdelivery_search(aveiro,[coimbra,porto,braga,leiria],astar,Solution),
   findall(C,member((C,_),Solution),Path),
   writeln('A*':Path),
   size_info(NT,T), writeln('Non terminals':NT / 'Terminals':T),
   solution_node(ID), node(ID,_,_,Data), writeln('Solution node':Data),
   lastID(LastID), writeln('LastID':LastID), nl.


