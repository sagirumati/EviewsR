%eviews_path="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR\sagiru"
cd %eviews_path
%eviewsrText="eviewsrText2af4c163365"
%wf="EviewsR1"
%page="EviewsR3"
%series="*"
open {%wf}



  %pagelist=@pagelist

  if %page<>"*" then
  %pagelist=%page
  endif


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
  
open {%wf}



  %pagelist=@pagelist

  if %page<>"*" then
  %pagelist=%page
  endif


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
  
