%wf="sagir"
%page=""
%table_name="sagiru"
%save_path=".\EVIEWS3b0c5da05242"
%runpath=@runpath
  cd %runpath
  open {%wf}

  if %page<>"" then
  pageselect {%page}
  endif

  {%table_name}.save(t=csv) {%table_name}
