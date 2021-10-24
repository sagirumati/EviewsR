%path="path"
%options=""
%source_description="ummi.csv"
if %path<>"" then
%source_description=%path+"\"+%source_description
endif

%table_description="" 
%keep_list="" 
if %keep_list<>"" then
%keep_list="@keep "+%keep_list
endif

%drop_list="y"
if %drop_list<>"" then
%drop_list="@drop "+%drop_list
endif

%keepmap_list=""
if %keepmap_list<>"" then
%keepmap_list="@keepmap "+%keepmap_list
endif

%dropmap_list=""
if %dropmap_list<>"" then
%dropmap_list="@dropmap "+%dropmap_list
endif

%smpl_spec=""
if %smpl_spec<>"" then
%smpl_spec="@smpl "+%smpl_spec
endif

pagesave(%options) {%source_description} {%table_description} {%keep_list} {%drop_list} {%keepmap_list} {%dropmap_list} {%smpl_spec}


'
'pagesave(options) [path\]filename
'
'pagesave(options) source_description table_description [@keep keep_list] [@drop drop_list] [@keepmap keepmap_list] [@dropmap dropmap_list] [@smpl smpl_spec]
'
'pagesave(options) source_description table_description [@keep keep_list] [@drop drop_list] [@keepmap keepmap_list] [@dropmap dropmap_list] [@smpl smpl_spec]
