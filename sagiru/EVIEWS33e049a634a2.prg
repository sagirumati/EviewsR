%eviews_path="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR\sagiru"
cd %eviews_path
%graph="first "
%eviewsrText="EVIEWS33e049a634a2"

%wf="eviewsr1"
%page="*"
%graph="%graph=""first """
%save_path="figure/"
%save_options="t=png,d=300"

if %wf<>"" then
wfopen {%wf}
endif

%pagelist=@pagelist

if %page<>"*" then
%pagelist=%page
endif



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


if %figKeep1="first" then
%graph1=@wlookup("*","graph")
%graph1=@wleft(%graph1,1)
else if %figKeep1="last" then
%graph1=@wlookup("*","graph")
%graph1=@wright(%graph1,1)
else if %figKeep1="asc" or %figKeep1="desc" or %figKeep1="numeric"  then
%graph1=@wlookup("*","graph")
else
%graph1=@wlookup(%graph,"graph")
endif
endif
endif

%selectedGraphs=%graph1

if @wcount(%selectedGraphs)>0 then
for %graph {%selectedGraphs}
{%graph}.save{%save_options} {%save_path}{%chunkName}{%page}-{%graph}
%graphPath=%graphPath+" "+%chunkName+%page+"-"+%graph
next
endif
next

%graphPath1=""
if %figKeep1="numeric" then
for %number {%graph}
!number=@val(%number)
'!number=@val(@word(%graph,!number))
%graphN=@word(%graphPath,!number)
%graphPath1=%graphPath1+" "+%graphN
next
else
%graphPath1=%graphPath
endif

text {%eviewsrText}_graph
{%eviewsrText}_graph.append {%graphPath}
{%eviewsrText}_graph.save  {%eviewsrText}-graph
exit

