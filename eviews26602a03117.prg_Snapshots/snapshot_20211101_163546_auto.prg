%wf="sagir"
%page=""
%table_name="sagiru"
%save_path=".\EVIEWS26604d4f196a"
%runpath=@runpath
  cd %runpath
  open {%wf}

  if %page<>"" then
  pageselect {%page}
  endif

  {%table_name}.save(t=csv) {%table_name}

