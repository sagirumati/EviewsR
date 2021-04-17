%path=@runpath
cd %path
wfopen WORKFILE
pageselect PAGE
%z=@wlookup("x y","series")
for %y {%z}
      if %z=" " then
      %z=" "
      else
      graph graph_{%y}.line {%y}
      endif
      next
%z=@wlookup("x y","series")
