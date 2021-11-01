%wf="eviewsr1"
%page=""
%table_name="SAGIRU"
%save_path=".\EVIEWSa8c5ec1327b"
%runpath=@runpath
  cd %runpath
  open {%wf}

  if %page<>"" then
  pageselect {%page}
  endif

  {%table_name}.save(t=csv) {%table_name}
exit
