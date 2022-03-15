%eviews_path="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR\vignettes"
cd %eviews_path
%save_path="EviewsR_files/EviewsR"
    'This program is created in R Markdown with the help of EviewsR package
  '%path=@runpath
 ' cd %path
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
  freeze(EviewsR_Plot,mode=overwrite) y.line
  wfsave EviewsR_workfile


  %graphs=@wlookup("*","graph")
if @wcount(%graphs)<>0 then
  for %y {%graphs}
  {%y}.save(t=png,d=300) "eviewsr_files\eviewsr\sagiru"
  next
endif
  exit


