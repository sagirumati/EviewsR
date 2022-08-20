%eviews_path="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR"
cd %eviews_path
%tempDir="C:\Users\SMATI\AppData\Local\Temp\RtmpmqaA9S"
%figKeep1=""
%eviewsrText="EVIEWS34ec1a5139"
%chunkLabel="EviewsR"
%page="*"
%equation="*"
%graph="*"
%series="*"
%table="*"
'This program is created in R Markdown with the help of EviewsR package
  
  wfcreate(page=EviewsRPage,wf=EviewsR_workfile) m 2000 2022
  for %y EviewsR package page1 page2
  pagecreate(page={%y}) EviewsR m 2000 2022
  next
  pageselect EviewsRPage
  rndseed 123456
  genr y=@cumsum(nrnd)
  genr x=@cumsum(nrnd)
  equation ols.ls y c x

  freeze(OLSTable,mode=overwrite) ols
  freeze(yy,mode=overwrite) y.line
  freeze(xx,mode=overwrite) x.line
  wfsave EviewsR_workfile

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
%save_path="inst/figures/"
%save_options="t=png,d=300"
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
  {%selectedGraph}.save{%save_options} {%save_path}{%chunkLabel}{%page}-{%selectedGraph}
  %graphPath=%graphPath+" "+%chunkLabel+%page+"-"+%selectedGraph
  next
  endif
  next


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
  pagesave {%page}-{%chunkLabel}{%eviewsrText}.csv @keep {%series1} @drop date
  %seriesPath=%seriesPath+" "+%page+"-"+%chunkLabel+%eviewsrText
  endif
  next

  text {%eviewsrText}_series
  {%eviewsrText}_series.append {%seriesPath}
  {%eviewsrText}_series.save {%eviewsrText}-series


  exit
