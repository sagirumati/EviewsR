%wf="sagir"
%page=""
%table_name="sagiru"
%save_path=".\EVIEWS7a5caba15c5"
%runpath=@runpath
  cd %runpath
  open {%wf}

  if %page<>"" then
  pageselect {%page}
  endif

  {%table_name}.save(t=csv) {%table_name}
