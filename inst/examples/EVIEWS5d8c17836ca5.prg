%wf="eviewsr1"
%page=""
%table_name="SAGIRU"
%save_path=".\EVIEWS5d8c105c2ede"
%runpath=@runpath
  cd %runpath
  open {%wf}

  if %page<>"" then
  pageselect {%page}
  endif

  {%table_name}.save(t=csv) {%table_name}
exit
