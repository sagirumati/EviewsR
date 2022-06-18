%eviews_path="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR\sagiru"
cd %eviews_path
%chunk_name="eview-graph-"
%EviewsRGroup="EviewsRGroup34e0629617cd"
%wf="eview_graph"
%page="eview_graph"
%series="y x"
%graph_command="line"
%options="m"
%mode="overwrite"
%save_path="EViewsR_files"
%save_options="t=png,d=300"
close @wf

if %wf<>"" then
wfopen {%wf}
endif

if %page<>"" then
pageselect {%page}
endif

if %mode<>"" then
%mode="mode="+%mode+","
endif


%z=@wlookup(%series,"series")
%graph_command=@wreplace(%graph_command,"* ","*")
%mode=@wreplace(%mode,"* ","*")
%save_path=@wreplace(%save_path,"* ","*")
%save_path=@wreplace(%save_path,"/","\")


if %save_path<>"" then
%save_path=%save_path+"\"
endif

%save_options=@wreplace(%save_options,"* ","*")

if %save_options<>"" then
%save_options="("+%save_options+")"
endif

if %options<>"" then
%options="("+%options+")"
endif
group {%EviewsRGroup} {%z}
  !n={%EviewsRGroup}.@count

  for !k=1 to {!n}
  %x{!k}={%EviewsRGroup}.@seriesname({!k})


  freeze({%mode}{%x{!k}}_graph_EviewsR) {%x{!k}}.{%graph_command}{%options}
  next
%allEviewsGraphs=@wlookup("*","graph")

for %y {%allEviewsGraphs}

%freq=@pagefreq
  if %freq="m" or %freq="M" then
  {%y}.datelabel format("YYYY") interval(auto, 1, 1)
  endif
  if %freq="D7" or %freq="D5"  or %freq="d5"  or %freq="d7" then
  {%y}.datelabel format("Mon YYYY") interval(auto, 1, 1)
  endif
if %freq="a" or %freq="A" then
  {%y}.datelabel format("YYYY") interval(auto, 1, 1)
  endif
{%y}.textdefault font("Times",12,-b,-i,-u,-s) existing
{%y}.legend font(Times New Roman,12,-i,-u,-s)
{%y}.axis(a) font("Times",12,-b,-i,-u,-s)
{%y}.align(2,1,1)
{%y}.template eviews5
next
for !k=1 to {!n}
  {%x{!k}}_graph_EviewsR.save{%save_options} {%save_path}{%chunk_name}{%x{!k}}
  next
  delete {%EviewsrGroup}
  exit
