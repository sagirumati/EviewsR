%path=@runpath
cd %path
wfopen R\WORKFILE
pageselect PAGE
%z=@wlookup("x y z","series")
if %z="" then
            %z=""
    else
        for %y {%z}
      graph graph_{%y}.line {%y}
      next
endif
string q=@wreplace("ABC AB", "*B*", "*X*")
string k=@replace(%z,"q","y")
%mergeName="graphs_of_"+@replace(%z," ","_")

%z=@wlookup("graph_*","graph")
graph {%mergeName}.merge {%z}


