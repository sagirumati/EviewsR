%path=@runpath
cd %path
  'This program is created in R Markdown with the help of EviewsR package
  %path=@runpath
  cd %path
  wfcreate(page=EviewsR) EviewsR m 1999 2020
  for %y Created By Sagiru Mati Northwest University Kano Nigeria
  pagecreate(page={%y}) EviewsR m 1999 2020
  wfsave EviewsR
  next
  pageselect Sagiru
  genr y=rnd
  genr x=rnd
  equation ols.ls y c x
  freeze(EviewsR_OLS,mode=overwrite) ols
  EviewsR_OLS.save(t=csv, r=r7c1:r10c5) tools\EviewsROLS
  EviewsR_OLS.save(t=csv) tools\EviewsRtable
  freeze(EviewsR_Plot,mode=overwrite) y.line
  EviewsR_Plot.save(t=png) tools\EviewsR_Plot_color
  EviewsR_Plot.save(t=png,-c) tools\EviewsR_Plot_nocolor
  exit
exit
