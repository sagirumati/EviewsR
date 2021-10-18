%path=@runpath
cd %path
wfopen r/workfile
pageselect page
%z=@wlookup("x y","series")
%graphType="line"

group EviewsR_group {%z}

 for %y {%z}
      graph graph_{%y}.{%graphType} {%y}
      next
endif
%mergeName="graphs_of_"+@replace(%z," ","_")
%z=@wlookup("graph_*","graph")
graph {%mergeName}.merge {%z}
{%mergeName}.align(2,1,1)


