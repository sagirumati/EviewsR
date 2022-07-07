%eviews_path="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR\sagiru"
cd %eviews_path
%eviewsrText="EVIEWS181c3868faf"
%chunkName="importGraph-"
%wf="eviewsr"
%page="*"
%graph="*"
%save_path="test_files/figure-latex/"
%save_options="t=pdf"

if %wf<>"" then
wfopen {%wf}
endif

'if %page<>"" then
'pageselect {%page}
'endif

if %page<>"" then
%pagelist=%page
endif

if %page="*" then
%pagelist=@pagelist
endif

for %page {%pagelist}
pageselect {%page}
%selectedGraphs=@wlookup(%graph,"graph")
if @wcount(%selectedGraphs)>0 then
for %y {%selectedGraphs}
{%y}.
next
endif
next
%save_path=@wreplace(%save_path,"* ","*")
%save_path=@wreplace(%save_path,"/","\")


if %save_path<>"" then
%save_path=%save_path+"\"
endif

%save_options=@wreplace(%save_options,"* ","*")

if %save_options<>"" then
%save_options="("+%save_options+")"
endif

%graphPath=""
for %page {%pagelist}
pageselect {%page}
%selectedGraphs=@wlookup(%graph,"graph")
if @wcount(%selectedGraphs)>0 then
for %graph {%selectedGraphs}
{%graph}.save{%save_options} {%save_path}{%chunkName}{%page}-{%graph}
%graphPath=%graphPath+" "+%chunkName+%page+"-"+%graph
next
endif
next

text {%eviewsrText}_graph
{%eviewsrText}_graph.append {%graphPath}
{%eviewsrText}_graph.save  {%eviewsrText}-graph
exit

