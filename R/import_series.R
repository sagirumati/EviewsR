#' Import `EViews` series objects(s) into R, R Markdown or Quarto.
#'
#' Use this function to import `EViews` series objects(s) into R, R Markdown or Quarto as dataframe or `xts` object.
#'
#' @inheritParams eviews_wfcreate
#' @param series Name(s) of `EViews` series object(s) in an `EViews` workfile
#' @param class Class of the R object: `df` for dataframe, or `xts` for extendable time-series object.
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#' demo(exec_commands)
#'
#' # To import all series objects across all pages
#'
#' import_series(wf="exec_commands")
#'
#' # To import specific series objects, for example starting with Y
#'
#' import_series(wf="exec_commands",series="y*")
#'
#' # To import series objects on specific pages
#'
#' import_series(wf="exec_commands",page="eviewspage")
#'
#'
#' # To access the series in base R
#'
#' eviews$eviewspage
#'
#' # To get the values above in R Markdown or Quarto
#'
#' chunkLabel$eviewspage
#'
#'}
#' @family important functions
#' @keywords documentation
#' @export
import_series=function(wf="",page="*",series="*",class="df"){

  chunkLabel=opts_current$get('label')

  envName=chunkLabel %n% "eviews" %>% gsub("^fig-","",.) %>% gsub("[._-]","",.)



  if(!identical(envName,"eviews")) assign(envName,new.env(),envir=knit_global())
  # if(identical(envName,"eviews")){
  #   if(!exists("eviews") || !is.environment(eviews)) assign(envName,new.env())
  # }

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
  pagesave {%page}-{%chunkLabel}{%eviewsrText}.csv @keep {%series} @drop date
  %seriesPath=%seriesPath+" "+%page+"-"+%chunkLabel+%eviewsrText
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
        if(identical(class,'xts')) dataFrame=xts(dataFrame[-1],dataFrame[[1]])
        }

      assign(pageName,dataFrame,envir =get(envName,envir = parent.frame()))
    }
  }


  on.exit(unlink_eviews(),add = TRUE)
  on.exit(unlink(paste0(seriesPath,".csv")),add = TRUE)
  on.exit(unlink(paste0(eviewsrText1,"-series.txt")),add = TRUE)

}
