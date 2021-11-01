%wf="eviewsr1"
%page=""
%table_name="SAGIRU"
%save_path=".\EVIEWS274c4c494739"
%runpath=@runpath
  cd %runpath
  open {%wf}

  if %page<>"" then
  pageselect {%page}
  endif

  {%table_name}.save(t=csv) {%table_name}
