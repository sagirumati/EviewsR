%eviews_path="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR\sagiru"
cd %eviews_path
%chunk_name="mychunk-"
%save_path="test_engEviews_files/figure-latex/"

wfcreate(wf=sagiru,page=mati) m 2000 2025
%existing=@wlookup("*","graph")
genr y=@cumsum(nrnd)
genr x=@cumsum(nrnd)
genr z=@cumsum(nrnd)
graph grap1.line z  
%newgraph=@wlookup("*","graph")
%newgraph=@wdrop(%newgraph,%existing)
%figKeep=%figKeep+" "+%newgraph
%figKeep=@wunique(%figKeep)
graph grap.line y
%newgraph=@wlookup("*","graph")
%newgraph=@wdrop(%newgraph,%existing)
%figKeep=%figKeep+" "+%newgraph
%figKeep=@wunique(%figKeep)
freeze(grap2,mode=overwrite) x.line
%newgraph=@wlookup("*","graph")
%newgraph=@wdrop(%newgraph,%existing)
%figKeep=%figKeep+" "+%newgraph
%figKeep=@wunique(%figKeep)
equation ols.ls y c x

text eviewsr_text1 
eviewsr_text1.append {%figkeeep}

wfsave mychunk
%allEviewsGraphs=@wlookup("*","graph")
if @wcount(%allEviewsGraphs)>0 then
for %y {%allEviewsGraphs}
{%y}.axis(b) font(40,b)
next
endif
%save_options="t=pdf"
%figKeep=@wlookup("*","graph")
if %save_path<>"" then
  %save_path=%save_path+"\"
  endif

  if @wcount(%figKeep)<>0 then
  for %y {%figKeep}
  {%y}.save({%save_options}) {%eviews_path}\{%save_path}{%chunk_name}{%y}
  next
  endif
  text eviewsr_text
  eviewsr_text.append {%figkeep}
  eviewsr_text.save eviewsr_text
  


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

  {%y}_table.save(t=csv) {%eviews_path}\{%save_path}{%y}_equation_table

  next

  endif



  %pagelist=@pagelist

  for %y {%pagelist}
  pageselect {%y}
  %tables=@wlookup("*" ,"table")

  if @wcount(%tables)<>0 then
  for %y {%tables}
  {%y}.save(t=csv) {%eviews_path}\{%save_path}{%y}_eviewsr_table
  next
  endif

  next

'  exit


