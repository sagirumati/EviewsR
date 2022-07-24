%eviews_path="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR\sagiru"
cd %eviews_path
'This is some comment in EViews program, feel free to write anything

wfcreate(page=EviewsR_page,wf=EviewsR_workfile) m 2000 2022
!n=1
for %y  page2 EviewsR3 page1 
pagecreate(page={%y}) q 2000 2022
pageselect {%y}
rndseed !n+100
!n=!n+100
genr x=@cumsum(nrnd)
genr y=@cumsum(nrnd)
genr z=@cumsum(nrnd)
equation OLS_EQUATION.ls y c x z
%existing=@wlookup("*","graph")
freeze(OLS_EQUATION_TABLE,mode=overwrite) OLS_EQUATION
%currentpage=@pagename
  %newgraph=@wlookup("*","graph")
  %newgraph=@wdrop(%newgraph,%existing)
  %existing=@wlookup("*","graph")
  if @wcount(%newgraph)>0 then
  %graphPath=%graphPath+" "+%chunkName+%currentpage+"-"+%newgraph
  endif
delete(noerr) GRAPH*
freeze(GRAPH3,mode=overwrite) z.line
graph GRAPH2.dot y
graph GRAPH1.area x
graph3.addtext(ar) %y
graph2.addtext(ar) %y
graph1.addtext(ar) %y
next

wfsave eviewsr1
%tempDir="C:\Users\SMATI\AppData\Local\Temp\Rtmpsrgeei"
%figKeep1=""
%eviewsrText="EVIEWS31682a2d7cdb"
%chunkName="ev"
%page="page1"
%equation="*"
%graph="asis"
%series="*"
%table="*"


  %pagelist=@pagelist

  if %page<>"*" then
  %pagelist=%page
  endif

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
  for %y {%selectedGraphs}
  {%y}.axis(l) font(Calibri,14,-b,-i,-u,-s)
  {%y}.axis(r) font(Calibri,14,-b,-i,-u,-s)
  {%y}.axis(b) font(Calibri,14,-b,-i,-u,-s)
  {%y}.axis(t) font(Calibri,14,-b,-i,-u,-s)
  {%y}.legend columns(5) inbox position(BOTCENTER) font(Calibri,12,-b,-i,-u,-s)
  {%y}.options antialias(on)
  {%y}.options size(6,3)
  {%y}.options -background frameaxes(all) framewidth(0.5)
  {%y}.setelem(1) linecolor(@rgb(57,106,177)) linewidth(1.5)
  {%y}.setelem(2) linecolor(@rgb(218,124,48)) linewidth(1.5)
  {%y}.setelem(3) linecolor(@rgb(62,150,81)) linewidth(1.5)
  {%y}.setelem(4) linecolor(@rgb(204,37,41)) linewidth(1.5)
  {%y}.setelem(5) linecolor(@rgb(83,81,84)) linewidth(1.5)
  {%y}.setelem(6) linecolor(@rgb(107,76,154)) linewidth(1.5)
  {%y}.setelem(7) linecolor(@rgb(146,36,40)) linewidth(1.5)
  {%y}.setelem(8) linecolor(@rgb(148,139,61)) linewidth(1.5)
  {%y}.setelem(9) linecolor(@rgb(255,0,255)) linewidth(1.5)
  {%y}.setelem(10) linewidth(1.5)
  {%y}.setelem(11) linecolor(@rgb(192,192,192)) linewidth(1.5)
  {%y}.setelem(12) linecolor(@rgb(0,255,255)) linewidth(1.5)
  {%y}.setelem(13) linecolor(@rgb(255,255,0)) linewidth(1.5)
  {%y}.setelem(14) linecolor(@rgb(0,0,255)) linewidth(1.5)
  {%y}.setelem(15) linecolor(@rgb(255,0,0)) linewidth(1.5)
  {%y}.setelem(16) linecolor(@rgb(0,127,0)) linewidth(1.5)
  {%y}.setelem(17) linecolor(@rgb(0,0,0)) linewidth(1.5)
  {%y}.setelem(18) linecolor(@rgb(0,127,127)) linewidth(1.5)
  {%y}.setelem(19) linecolor(@rgb(127,0,127)) linewidth(1.5)
  {%y}.setelem(20) linecolor(@rgb(127,127,0)) linewidth(1.5)
  {%y}.setelem(21) linecolor(@rgb(0,0,127)) linewidth(1.5)
  {%y}.setelem(22) linecolor(@rgb(255,0,255)) linewidth(1.5)
  {%y}.setelem(23) linecolor(@rgb(127,127,127)) linewidth(1.5)
  {%y}.setelem(24) linecolor(@rgb(192,192,192)) linewidth(1.5)
  {%y}.setelem(25) linecolor(@rgb(0,255,255)) linewidth(1.5)
  {%y}.setelem(26) linecolor(@rgb(255,255,0)) linewidth(1.5)
  {%y}.setelem(27) linecolor(@rgb(0,0,255)) linewidth(1.5)
  {%y}.setelem(28) linecolor(@rgb(255,0,0)) linewidth(1.5)
  {%y}.setelem(29) linecolor(@rgb(0,127,0)) linewidth(1.5)
  {%y}.setelem(30) linecolor(@rgb(0,0,0)) linewidth(1.5)
  {%y}.setfont legend(Calibri,12,-b,-i,-u,-s) text(Calibri,14,-b,-i,-u,-s) obs(Calibri,14,-b,-i,-u,-s) axis(Calibri,14,-b,-i,-u,-s)
  {%y}.setfont obs(Calibri,14,-b,-i,-u,-s)
  {%y}.textdefault font(Calibri,14,-b,-i,-u,-s)
  next
  endif
  next
  
%save_path="test_files/figure-latex/"
%save_options="t=pdf"

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
    for %y {%selectedGraphs}
    {%y}.template bokeh
    next
    endif
    next
    

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
    for %y {%selectedGraphs}
    {%y}.setelem(1) lcolor(green) fillcolor(green)
    next
    endif
    next
    
%save_path=@wreplace(%save_path,"* ","*")
  %save_path=@wreplace(%save_path,"/","\")


  if %save_path<>"" then
  %save_path=%save_path+"\"
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


  if @wcount(%graphPath)>0 then
  text {%eviewsrText}_graph
  {%eviewsrText}_graph.append {%graphPath}
  {%eviewsrText}_graph.save  {%eviewsrText}-graph
  endif



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


 


