#' Create an `EViews` workfile from R
#'
#' Use this function to create an `EViews` workfile from R
#'
#' @usage eviews_wfcreate(wf_name="",page_name="",frequency="",start_date="",end_date="",path="",save=T)
#' @param wf_name Object or a character string representing the name of a workfile to be created
#'
#' @param page_name Object or a character string representing the name of a workfile page to be created
#'
#' @param frequency Object or a character string representing the frequency of a workfile page to be created. Only letters accepted by EViews are allowed. For example \code{u} for undated, \code{a} for annual, \code{m} for monthly and so on.
#'
#' @param start_date Object or a character string representing the \code{start date}. It should be left blank for undated (when the \code{frequency} is \code{u}).
#'
#' @param end_date Object or a character string representing the \code{end date}. It should be left blank for undated (when the \code{frequency} is \code{u}).
#'
#' @param path Object or a character string representing the path to the folder for the  workfile to be saved. The current working directory is the default `path`. Specify the `path` only if you want the workfile to live in different path from the current working directory.
#'
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#' eviews_wfcreate(wf_name="EVIEWSR_WORKFILE",page_name="EVIEWSR_PAGE",frequency="m",start_date="1990m1",end_date="2021m4",path="",save=T)
#'}
#' @seealso eng_eviews
#' @keywords documentation
#' @export
eviews_wfcreate=function(wf="",page="",prompt="",frequency="",subperiod_opts="",start_date="",end_date="",num_cross_sections=1,num_observations="",save_path="",save=T){
  # wf_path=ifelse(path=="",'%wf_path=""',paste0("%wf_path=",'"',gsub("/","\\\\",path),'\\"'))
  fileName=tempfile("EVIEWS", ".", ".prg")
  wf=paste0('%wf=',shQuote(wf))
  page=paste0("%page=",shQuote(page))
  prompt=paste0("%prompt=",shQuote(prompt))
  frequency=paste0("%frequency=",shQuote(frequency))
  subperiod_opts=paste0("%subperiod_opts=",shQuote(subperiod_opts))
  start_date=paste0("%start_date=",shQuote(start_date))
  end_date=paste0("%end_date=",shQuote(end_date))
  save=paste0("%save=",shQuote(save))
  save_path=gsub("/","\\\\",save_path)
  save_path=paste0("%save_path=",shQuote(save_path))
  num_cross_sections=paste0("!num_cross_sections=",num_cross_sections)
  num_observations=paste0("!num_observations=",num_observations)

  eviews_code=r'(%path=@runpath
  cd %path
  %wf=@wreplace(%wf,"* ","*")
  %page=@wreplace(%page,"* ","*")
  %subperiod_opts=@wreplace(%subperiod_opts,"* ","*")
  if %subperiod_opts<>"" then
  %subperiod_opts="("+%subperiod_opts+")"
  endif
  if %frequency="u" or %frequency="U" then
  wfcreate(wf={%wf},page={%page},{%prompt}) {%frequency} {!num_observations}
  else
  wfcreate(wf={%wf},page={%page},{%prompt}) {%frequency}{%subperiod_opts} {%start_date} {%end_date} {!num_cross_sections}
  endif

  if %wf="" then
  %wf=@wfname
  endif
  if %save="T" or %save="TRUE" then
  if %save_path="" then
  wfsave {%wf}
  else
  wfsave {%save_path}\{%wf}
  endif
  endif
  exit
  )'

writeLines(c(wf,page,prompt,frequency,subperiod_opts,start_date,end_date,num_cross_sections,num_observations,save_path,save,eviews_code),fileName)
  system2("EViews",paste("run(c,q)",fileName))
  on.exit(unlink(fileName))
}

# eviews_wfcreate(wf="smati",page="academy",frequency = "m",start_date = "1990",end_date = "2020",num_observations = 2,save_path = "eviews/path")
