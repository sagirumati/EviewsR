%wf="workfile"
%page=""
%options=""
%source_description="path/EviewsR.csv"
%table_description=""
%keep_list=""
%drop_list=""
%keepmap_list=""
%dropmap_list=""
%smpl_spec=""

%runpath=@runpath
cd %runpath
open {%wf}

if %page<>"" then
pageselect {%page}
endif
if %path<>"" then
%source_description=%path+"\"+%source_description
endif

if %keep_list<>"" then
%keep_list="@keep "+%keep_list
endif


if %drop_list<>"" then
%drop_list="@drop "+%drop_list
endif

if %keepmap_list<>"" then
%keepmap_list="@keepmap "+%keepmap_list
endif

if %dropmap_list<>"" then
%dropmap_list="@dropmap "+%dropmap_list
endif


if %smpl_spec<>"" then
%smpl_spec="@smpl "+%smpl_spec
endif

pagesave(%options) {%source_description} {%table_description} {%keep_list} {%drop_list} {%keepmap_list} {%dropmap_list} {%smpl_spec}


