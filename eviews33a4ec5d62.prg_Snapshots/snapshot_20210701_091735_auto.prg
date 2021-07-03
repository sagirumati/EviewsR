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
%z=@wlookup("graph_*","graph")
graph graph33a44f25208cmerge.merge {%z}

