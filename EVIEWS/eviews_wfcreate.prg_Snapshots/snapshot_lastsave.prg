'%wf="  "
'%page="  "
'%prompt=""
'%frequency="m"
'%subperiod_opts=""
'%start_date="1990"
'%end_date="2020"
'!num_cross_sections=10
'!num_observations=10
'%save=""
'%save_path=""

%path=@runpath
cd %path
%wf=@wreplace(%wf,"* ","*")
%page=@wreplace(%page,"* ","*")
%subperiod_opts=@wreplace(%subperiod_opts,"* ","*")
if %subperiod_opts<>"" then
%subperiod_opts="("+%subperiod_opts+")" 
endif
if %frequency="u" or %frequency="U" then
wfcreate(wf={%wf},page={%page},{%prompt}) {%frequency} {!num_observations}
else
wfcreate(wf={%wf},page={%page},{%prompt}) {%frequency}{%subperiod_opts} {%start_date} {%end_date} {!num_cross_sections}
endif

if %wf="" then
%wf=@wfname
endif
if %save="T" or %save="TRUE" then
if %save_path="" then
     wfsave {%wf}
else
     wfsave {%save_path}\{%wf}
endif
endif

exit

