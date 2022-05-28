%eviews_path="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR\inst\examples"
cd %eviews_path
%save_path="EviewsR_files/EviewsR"
    'This program is created in R Markdown with the help of EviewsR package
  %path=@runpath
  cd %path
  wfcreate(page=EviewsR_page,wf=EviewsR_workfile) m 2000 2022
  for %y EviewsR package page1 page2
  pagecreate(page={%y}) EviewsR m 2000 2022
  next
  pageselect EviewsR_page
  rndseed 123456
  genr y=rnd
  genr x=rnd
  equation ols.ls y c x
  freeze(EviewsROLS,mode=overwrite) ols
  freeze(yy,mode=overwrite) y.line
  freeze(xx,mode=overwrite) x.line
  wfsave EviewsR_workfile


  %graphs=@wlookup("*","graph")

  if %save_path<>"" then
  %save_path=%save_path+"\"
  endif

if @wcount(%graphs)<>0 then
  for %y {%graphs}
  {%y}.save(t=png,d=300) {%eviews_path}\{%save_path}{%y}
  next
endif




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

  exit
  
