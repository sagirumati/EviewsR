string graphs="" 

for %y  y x
freeze(graph_{%y},mode=overwrite) {%y}.line
'%z="*"+%y
'%newgraph=@wlookup(%z,"graph")
%newgraph=@wlookup(%z,"graph")
%newgraph=@wunique(%newgraph)
graphs=graphs+" "+ %newgraph
next
