%path=@runpath
cd %path
wfopen r/workfile
pageselect page
%z=@wlookup("x y","series")
%graphType="line"
if %z="" then
            %z=""
    else
        for %y {%z}
      graph graph_{%y}.{%graphType} {%y}
      next
endif
%mergeName="graphs_of_"+@replace(%z," ","_")
%z=@wlookup("graph_*","graph")
graph {%mergeName}.merge {%z}
{%mergeName}.align(2,1,1)

