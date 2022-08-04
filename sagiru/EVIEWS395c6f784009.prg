%eviews_path="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR\sagiru"
cd %eviews_path
%eviewsrText="eviewsrText395c595c1ccf"
%wf="eviewsr_files/eviewsr_eviews_import"
%page="*"
%series="*"
open {%wf}



  %pagelist=@pagelist

  if %page<>"*" then
  %pagelist=%page
  endif


  %seriesPath=""
  for %page {%pagelist}
  pageselect {%page}
  %series1=@wlookup(%series,"series")
  if @wcount(%series1)>0 then
  pagesave {%page}-{%chunkLabel}{%eviewsrText}.csv @keep {%series} @drop date
  %seriesPath=%seriesPath+" "+%page+"-"+%chunkLabel+%eviewsrText
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
  %series1=@wlookup(%series,"series")
  if @wcount(%series1)>0 then
  pagesave {%page}-{%chunkLabel}{%eviewsrText}.csv @keep {%series} @drop date
  %seriesPath=%seriesPath+" "+%page+"-"+%chunkLabel+%eviewsrText
  endif
  next

  text {%eviewsrText}_series
  {%eviewsrText}_series.append {%seriesPath}
  {%eviewsrText}_series.save {%eviewsrText}-series
  exit
  
