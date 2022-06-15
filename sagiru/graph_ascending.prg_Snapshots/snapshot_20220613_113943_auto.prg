string graphs="" 
string existing=@wlookup("*","graph")
string newgraph
genr z=rnd
for %y z y x
freeze(graph_{%y},mode=overwrite) {%y}.line
'%z="*"+%y
'%newgraph=@wlookup(%z,"graph")
newgraph=@wlookup("*","graph")
'%newgraph=@wnotin(%newgraph,existing)
newgraph=@wdrop(newgraph,existing)
existing=@wdrop(existing,newgraph)
'graphs=@wdrop(graphs,%newgraph)
graphs=graphs+" "+ newgraph
graphs=@wunique(graphs)
next


