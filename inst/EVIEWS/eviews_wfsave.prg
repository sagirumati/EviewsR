%wf=""
%page=""
%options=""
%source_description="ummi.csv"
%table_description="" 
%keep_list="" 
%drop_list="y"
%keepmap_list=""
%dropmap_list=""
%smpl_spec=""

%runpath=@runpath
cd %runpath
open {%wf}

if %page<>"" then
pageselect {%page}
endif

'if %path<>"" then
'%source_description=%path+"\"+%source_description 'PATH not needed
'endif

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

wfsave(%options) {%source_description} {%table_description} {%keep_list} {%drop_list} {%keepmap_list} {%dropmap_list} {%smpl_spec}


'
'wfsave(options) [path\]filename
'
'wfsave(options) source_description table_description [@keep keep_list] [@drop drop_list] [@keepmap keepmap_list] [@dropmap dropmap_list] [@smpl smpl_spec]
'
'wfsave(options) source_description table_description [@keep keep_list] [@drop drop_list] [@keepmap keepmap_list] [@dropmap dropmap_list] [@smpl smpl_spec]


