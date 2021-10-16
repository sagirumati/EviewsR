%path=@runpath
cd %path
wfopen R\WORKFILE
pageselect PAGE
%z=@wlookup("y x","series")
%graphType="line(contract=mean,b)"
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
