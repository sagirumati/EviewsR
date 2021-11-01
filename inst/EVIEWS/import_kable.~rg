%wf=""
%page=""
%table_name=""
%path=""

%runpath=@runpath
cd %runpath
open {%wf}

if %page<>"" then
pageselect {%page}
endif 

{%table_name}.save(t=csv) {%path}\{%table_name}
