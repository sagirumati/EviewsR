%path=@runpath
cd %path
%wf_name=" smati   "
%wf_name=@wreplace(%wf_name,"* *","**")
%page_name="academy   "
%page_name=@wreplace(%page_name,"* *","**")
%prompt=""
%frequency="m"
%subperiod_opts="January"
%start_date="1990"
%end_date="2020"
!num_cross_sections=0
!num_observations=10
%save=""
%save_path=""
if %frequency="u" or %frequency="U" then
wfcreate(wf={%wf_name},page={%page_name},{%prompt}) {%frequency} {!num_observations}
else
wfcreate(wf={%wf},page={%page},{%prompt}) {%frequency}({%subperiod_opts}) {%start_date} {%end_date} {!num_cross_sections}
endif

if %wf_name="" then
%wf_name=@wfname
endif
if %save="T" or %save="TRUE" then
     wfsave {%save_path}\{%wf_name}
endif


