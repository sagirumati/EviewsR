%eviews_path="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR\vignettes"
cd %eviews_path
%wf="EviewsR_workfile"
%page=""
%action=""
%action_opt=""
%object_name="x1"
%view_or_proc=""
%options_list=""
%arg_list=""
%object_type="series"
%options=""
%expression="y^2"
wfopen {%wf}

  if %page<>"" then
  pageselect {%page}
  endif

  if %action_opt<>"" then
  %action_opt="("+%action_opt+")"
  endif


  if %view_or_proc<>"" then
  %view_or_proc="."+%view_or_proc
  endif

  if %options_list<>"" then
  %options_list="("+%options_list+")"
  endif


  if %options<>"" then
  %options="("+%options+")"
  endif

  if %expression<>"" then
  %expression="="+%expression
  endif


  if %action<>"" then
  {%action}{%action_opt} {%object_name}{%view_or_proc}{%options_list} {%arg_list}
  endif

  if %object_type<>"" then
  {%object_type}{%options} {%object_name}{%expression}
  endif

  wfsave {%wf}
  exit
