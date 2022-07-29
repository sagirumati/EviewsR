#' Import `EViews` series object as `kable`
#'
#' Use this function to import `EViews` series object as `kable`
#'
#' @inheritParams knitr::kable
#' @inheritParams kableExtra::kbl
#' @inheritParams eviews_wfcreate
#' @param series_range A vector of characters specifying the series range of rows and columns
#' @param series Name(s) of `EViews` series object(s) in an `EViews` workfile
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#' demo(exec_commands)
#'
#' import_series(wf="EviewsR_exec_commands",page="page",series_name="EviewsROLS",format="pandoc")
#'}
#' @family important functions
#' @keywords documentation
#' @export
import_series=function(wf="",page="*",series="*"){

  chunkName=opts_current$get('label')

  envName=chunkName %n% "eviews" %>% gsub("^fig-","",.) %>% gsub("[._-]","",.)


  # chunkName1=paste0(chunkName,'-') %>%
  # shQuote_cmd() %>% paste0('%chunkName=',.)

  if(!identical(envName,"eviews")) assign(envName,new.env(),envir=knit_global())
  if(identical(envName,"eviews")){
    if(!exists("eviews") || !is.environment(eviews)) assign(envName,new.env(),envir=globalenv())
  }

  eviewsrText=tempfile("eviewsrText",".") %>%
    basename
  eviewsrText1=eviewsrText

  eviewsrText %<>%   shQuote_cmd %>%
    paste0("%eviewsrText=",.)


  fileName=basename(tempfile("EVIEWS", ".", ".prg"))
  # file_name=series_name

  wf=paste0('%wf=',shQuote_cmd(wf))
  page=paste0('%page=',shQuote_cmd(page))
  series=paste0('%series=',shQuote_cmd(series))


  saveCode=r'(open {%wf}



  %pagelist=@pagelist

  if %page<>"*" then
  %pagelist=%page
  endif


  %seriesPath=""
  for %page {%pagelist}
  pageselect {%page}
  %series1=@wlookup(%series,"series")
  if @wcount(%series1)>0 then
  pagesave {%page}-{%chunkName}{%eviewsrText}.csv @keep {%series} @drop date
  %seriesPath=%seriesPath+" "+%page+"-"+%chunkName+%eviewsrText
  endif
  next

  text {%eviewsrText}_series
  {%eviewsrText}_series.append {%seriesPath}
  {%eviewsrText}_series.save {%eviewsrText}-series
  exit
  )'



  eviewsCode=paste0(c(eviews_path(),eviewsrText,wf,page,series,saveCode),collapse = '\n')


  writeLines(c(eviewsCode,saveCode),fileName)

  system_exec()


  if(file.exists(paste0(eviewsrText1,'-series.txt'))){
    seriesPath=readLines(paste0(eviewsrText1,'-series.txt')) %>% strsplit(split=" ") %>% unlist()
    for (i in seriesPath){
      pageName=gsub("\\-.*","",i) %>% tolower
      dataFrame=read.csv(paste0(i,".csv"))
      if(grepl('date',colnames(dataFrame)[1])){
        colnames(dataFrame)[1]="date"
        dataFrame$date=as.POSIXct(dataFrame$date)
      }
      assign(pageName,dataFrame,envir =get(envName,envir = parent.frame()))
    }
  }


  on.exit(unlink_eviews(),add = TRUE)
  on.exit(unlink(paste0(seriesPath,".csv")),add = TRUE)
  on.exit(unlink(paste0(eviewsrText1,"-series.txt")),add = TRUE)

}
