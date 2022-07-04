%eviews_path=%C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR\vignettes="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR\vignettes"
cd %eviews_path
%options=%wf=EviewsR_workfile,page=EviewsR_page,FALSE="wf=EviewsR_workfile,page=EviewsR_page,FALSE"
%save_path=%=""
%frequency=%m="m"
%subperiod_opts=%=""
%start_date=%1990="1990"
%end_date=%2022="2022"
!num_cross_sections=NA
!num_observations=NA
%save_path=%=""
%wf=@wreplace(%wf,"* ","*")
  '%page=@wreplace(%page,"* ","*")
  %subperiod_opts=@wreplace(%subperiod_opts,"* ","*")

  @stripcommas(%options)

  if %subperiod_opts<>"" then
  %subperiod_opts="("+%subperiod_opts+")"
  endif

  if %frequency="u" or %frequency="U" then
  wfcreate({%options}) {%frequency} {!num_observations}
  else
  wfcreate({%options}) {%frequency}{%subperiod_opts} {%start_date} {%end_date} {!num_cross_sections}
  endif

  if !num_cross_sections=NA then
  !num_cross_sections=1
  endif


  %wf=@wfname

  if %save_path<>"" then
  %save_path=%save_path+"\"
  endif

  wfsave {%save_path}{%wf}

  exit
  
