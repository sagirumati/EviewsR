%eviews_path="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR\sagiru"
cd %eviews_path
%eviewsr_text="eviewsr_text331016ad4259"
%chunk_name="mychunk-"
%save_path="test_engEviews_files/figure-latex/"
wfcreate(wf=sagiru,page=mati) q 2000 2025
for %y page1 page2 page3  
pagecreate(page={%y}) q 2000 2025
next
%pagelist=@pagelist
'open mychunk
for %y {%pagelist}
pageselect {%y}
'delete gra*
genr y=@cumsum(nrnd)
genr x=@cumsum(nrnd)
genr z=@cumsum(nrnd)
genr date=@date
%existing=@wlookup("*","graph")
                     graph grap3.dot z  
%currentpage=@pagename
%newgraph=@wlookup("*","graph")
%newgraph=@wdrop(%newgraph,%existing)
%existing=@wlookup("*","graph")
%figPath=%figPath+" "+%chunk_name+%currentpage+"-"+%newgraph
                           graph grap2.bar y 
%currentpage=@pagename
%newgraph=@wlookup("*","graph")
%newgraph=@wdrop(%newgraph,%existing)
%existing=@wlookup("*","graph")
%figPath=%figPath+" "+%chunk_name+%currentpage+"-"+%newgraph
                           graph grap1.area x  
%currentpage=@pagename
%newgraph=@wlookup("*","graph")
%newgraph=@wdrop(%newgraph,%existing)
%existing=@wlookup("*","graph")
%figPath=%figPath+" "+%chunk_name+%currentpage+"-"+%newgraph
   freeze(grap,mode=overwrite) x.line
%currentpage=@pagename
%newgraph=@wlookup("*","graph")
%newgraph=@wdrop(%newgraph,%existing)
%existing=@wlookup("*","graph")
%figPath=%figPath+" "+%chunk_name+%currentpage+"-"+%newgraph
equation ols.ls y c x
freeze(tab) ols
%currentpage=@pagename
%newgraph=@wlookup("*","graph")
%newgraph=@wdrop(%newgraph,%existing)
%existing=@wlookup("*","graph")
%figPath=%figPath+" "+%chunk_name+%currentpage+"-"+%newgraph
next
wfsave mychunk

if @wcount(%figKeep)>0 then
  for %y {%figKeep}
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
if @wcount(%figKeep)>0 then
%pagelist=@pagelist
for %page {%pagelist}
pageselect {%page}
for %y {%figKeep}
{%y}.template eviews5
{%y}.datelabeL  format("Month YYYY")
{%y}.axis(b) angle(45)
{%y}.legend columns(auto) position(right)
next
next
endif
%save_options="t=pdf"

if %save_path<>"" then
    %save_path=%save_path+"\"
    endif

    text {%eviewsr_text}
    {%eviewsr_text}.append {%figpath}
    {%eviewsr_text}.save {%eviewsr_text}

    %pagelist=@pagelist

    for %page {%pagelist}
    pageselect {%page}


    %figKeep=@wlookup("*","graph")

    if @wcount(%figKeep)<>0 then
    for %y {%figKeep}
    '%figPath=%figPath+" "+%chunk_name+%page+"-"+%y
    {%y}.save({%save_options}) {%eviews_path}\{%save_path}{%chunk_name}{%page}-{%y}
    next
    endif

    next
    


%tablePath=""

  %pagelist=@pagelist

'%tablePath=""

  for %page {%pagelist}
  pageselect {%page}
  %tables=@wlookup("*" ,"table")

  if @wcount(%tables)<>0 then
  for %y {%tables}
  'table {%page}_{%y}
  %tablePath=%tablePath+" "+%page+"_"+%y+"_"+"eviewsr_table"
  {%y}.save(t=csv) {%eviews_path}\{%save_path}{%page}_{%y}_eviewsr_table
  next
  endif

  text eviewsr_table_text
  eviewsr_table_text.append {%tablePath}
  eviewsr_table_text.save eviewsr_table_text

  next



  for %page {%pagelist}
  pageselect {%page}
  %equation=@wlookup("*","equation")

  if @wcount(%equation)<>0 then
  for %y {%equation}
  table {%y}_table

  %equationMembers="aic df coefs  dw f fprob hq logl meandep ncoef pval r2 rbar2 regobs schwarz sddep se ssr stderrs tstats"

  scalar n=@wcount(%equationMembers)
  for !j =1 to n
  %x{!j}=@word(%equationMembers,{!j})
  {%y}_table(1,!j)=%x{!j}

  %vectors="coefs pval stderrs tstats"
  if @wcount(@wintersect(%x{!j},%vectors))>0 then
  !eqCoef={%y}.@ncoef
  for !i= 2 to !eqCoef+1
  {%y}_table(!i,!j)={%y}.@{%x{!j}}(!i-1)
  next
  else
  {%y}_table(2,!j)={%y}.@{%x{!j}}
  endif
  next

  {%y}_table.save(t=csv) {%eviews_path}\{%save_path}{%page}_{%y}_equation_table

  next

  endif
  next

  wfsave all_eviewsr_series.csv @drop date

  exit
  
