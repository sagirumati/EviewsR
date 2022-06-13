string graphs="" 

for %y  y x
freeze(graph_{%y},mode=overwrite) {%y}.line
'%z="*"+%y
'%newgraph=@wlookup(%z,"graph")
%newgraph=@wlookup("*","graph")
%newgraph=@wnotin(%newgraph,graphs)
'graphs=@wdrop(graphs,%newgraph)
graphs=graphs+" "+ %newgraph
next
