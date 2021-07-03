%path=@runpath
cd %path
wfopen R\WORKFILE
pageselect PAGE
%z=@wlookup("X Y","series")
if %z="" then
            %z=""
    else
        for %y {%z}
      graph graph_{%y}.line {%y}
      next
endif
%z=@wlookup("*X *Y","graph")
graph graph33a4a6e626bmerge.merge {%z}
graph33a4a6e626bmerge.align(2,1,1)

