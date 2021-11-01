%wf="eviewsr"
%page=""
%table_name="eviewsr"
%save_path=".\EVIEWS2ed848f63568"
%runpath=@runpath
  cd %runpath
  open {%wf}

  if %page<>"" then
  pageselect {%page}
  endif

  {%table_name}.save(t=csv) {%table_name}
