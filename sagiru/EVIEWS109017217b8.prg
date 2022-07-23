%eviews_path="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR\sagiru"
cd %eviews_path
%tempDir="C:\Users\SMATI\AppData\Local\Temp\Rtmpi0GqdS"
%figKeep1=""
%eviewsrText="EVIEWS109017217b8"

%wf="eviewsr1"
%page="*"
%equation="*"
%graph="*"
%series="*"
%table="*"
%save_path="figure/"
%save_options="t=pdf"

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

'####################### GRAPHS #################


if %figKeep1="numeric" then
%save_path=%tempDir
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


if %graph="first" then
%selectedGraphs=@wlookup("*","graph")
%selectedGraphs=@wleft(%selectedGraphs,1)
else if %graph="last" then
%selectedGraphs=@wlookup("*","graph")
%selectedGraphs=@wright(%selectedGraphs,1)
else if %graph="asis" or %graph="asc" or %graph="desc" or %figKeep1="numeric"  then
%selectedGraphs=@wlookup("*","graph")
else
%selectedGraphs=@wlookup(%graph,"graph")
endif
endif
endif



if @wcount(%selectedGraphs)>0 then
for %selectedGraph {%selectedGraphs}
{%selectedGraph}.save{%save_options} {%save_path}{%chunkName}{%page}-{%selectedGraph}
%graphPath=%graphPath+" "+%chunkName+%page+"-"+%selectedGraph
next
endif
next

'%graphPath1=""
'if %figKeep1="numeric" then
'for %number {%graph}
'!number=@val(%number)
'!number=@val(@word(%graph,!number))
'%graphN=@word(%graphPath,!number)
'%graphPath1=%graphPath1+" "+%graphN
'next
'else
'%graphPath1=%graphPath
'endif


text {%eviewsrText}_graph
{%eviewsrText}_graph.append {%graphPath}
{%eviewsrText}_graph.save  {%eviewsrText}-graph



'####################### TABLES #################


%tablePath=""

for %page {%pagelist}
pageselect {%page}
%tables1=@wlookup(%table ,"table")

if @wcount(%tables1)<>0 then
for %y {%tables1}
%tablePath=%tablePath+" "+%page+"_"+%y+"-"+%eviewsrText
{%y}.save(t=csv) {%page}_{%y}-{%eviewsrText}
next
endif
next

text {%eviewsrText}_table
{%eviewsrText}_table.append {%tablePath}
{%eviewsrText}_table.save {%eviewsrText}-table


'####################### EQUATIONS #################

%equationPath=""

for %page {%pagelist}
pageselect {%page}
%equation1=@wlookup(%equation,"equation")

if @wcount(%equation1)<>0 then
for %y {%equation1}
table {%y}_table_{%eviewsrText}

%equationMembers="aic df coefs  dw f fprob hq logl meandep ncoef pval r2 rbar2 regobs schwarz sddep se ssr stderrs tstats"

scalar n=@wcount(%equationMembers)
for !j =1 to n
%x{!j}=@word(%equationMembers,{!j})
{%y}_table_{%eviewsrText}(1,!j)=%x{!j}

%vectors="coefs pval stderrs tstats"
if @wcount(@wintersect(%x{!j},%vectors))>0 then
!eqCoef={%y}.@ncoef
for !i= 2 to !eqCoef+1
{%y}_table_{%eviewsrText}(!i,!j)={%y}.@{%x{!j}}(!i-1)
next
else
{%y}_table_{%eviewsrText}(2,!j)={%y}.@{%x{!j}}
endif
next

%equationPath=%equationPath+" "+%page+"_"+%y+"-"+%eviewsrText
{%y}_table_{%eviewsrText}.save(t=csv) {%page}_{%y}-{%eviewsrText}

next

endif
next

text {%eviewsrText}_equation
{%eviewsrText}_equation.append {%equationPath}
{%eviewsrText}_equation.save {%eviewsrText}-equation

'####################### SERIES #################

%seriesPath=""
for %page {%pagelist}
pageselect {%page}
%series1=@wlookup(%series,"series")
if @wcount(%series1)>0 then
pagesave {%page}-{%chunkName}{%eviewsrText}.csv @keep {%series1} @drop date
%seriesPath=%seriesPath+" "+%page+"-"+%chunkName+%eviewsrText
endif
next

text {%eviewsrText}_series
{%eviewsrText}_series.append {%seriesPath}
{%eviewsrText}_series.save {%eviewsrText}-series


exit

