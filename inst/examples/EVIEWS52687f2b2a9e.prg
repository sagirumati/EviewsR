%wf="eviewsr1"
%page=""
%table_name="SAGIRU"
%save_path=".\EVIEWS52682daa7ab7"
%runpath=@runpath
  cd %runpath
  open {%wf}

  if %page<>"" then
  pageselect {%page}
  endif

  {%table_name}.save(t=csv) {%table_name}
