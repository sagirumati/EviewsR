%eviews_path="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR\sagiru"
cd %eviews_path
%figKeep1="all"
%eviewsrText="EVIEWS3b283cca77a2"
%chunkName="import-"
%wf="EviewsR1"
%page="EviewsR3"
%equation="*"
%graph="*"
%series="*"
%table="*"
%save_path="test_files/figure-latex/"
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

%graphPath=""
for %page {%pagelist}
pageselect {%page}



if %figKeep1="first" then
%graph=@wlookup("*","graph")
%graph=@wleft(%graph,1)
endif

if %figKeep1="last" then
%graph=@wlookup("*","graph")
%graph=@wright(%graph,1)
endif

if %figKeep1="all" then
%graph=@wlookup("*","graph")
endif


%selectedGraphs=%graph

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



'####################### TABLES #################

%tablePath=""

for %page {%pagelist}
pageselect {%page}
%tables=@wlookup(%table ,"table")

if @wcount(%tables)<>0 then
for %y {%tables}
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
%equation=@wlookup(%equation,"equation")

if @wcount(%equation)<>0 then
for %y {%equation}
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
%series=@wlookup(%series,"series")
if @wcount(%series)>0 then
pagesave {%page}-{%chunkName}{%eviewsrText}.csv @keep {%series} @drop date
%seriesPath=%seriesPath+" "+%page+"-"+%chunkName+%eviewsrText
endif
next

text {%eviewsrText}_series
{%eviewsrText}_series.append {%seriesPath}
{%eviewsrText}_series.save {%eviewsrText}-series


exit

