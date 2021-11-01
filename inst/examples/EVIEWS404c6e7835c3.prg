%wf="eviewsr"
%page=""
%table_name="eviewsr"
%save_path=".\EVIEWS404c29d53677"
%runpath=@runpath
  cd %runpath
  open {%wf}

  if %page<>"" then
  pageselect {%page}
  endif

  {%table_name}.save(t=csv) {%table_name}
