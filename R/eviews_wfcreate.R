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
#' @importFrom here here
#' @seealso eng_eviews
#' @keywords documentation
#' @export
eviews_wfcreate=function(wf_name="",page_name="",frequency="",start_date="",end_date="",path="",save=T){
  wf_path=ifelse(path=="",'%wf_path=""',paste0("%wf_path=",'"',gsub("/","\\\\",path),'\\"'))
  fileName=tempfile("EVIEWS", ".", ".prg")
  code=paste(paste0("wfcreate(wf=",wf_name,",page=",page_name,")"),frequency,start_date,end_date)
  if(save==T){
    condition='%wfname=@wfname
    wfsave {%wf_path}{%wfname}'
  } else{
    condition=""
  }
  writeLines(c(wf_path,"%path=@runpath","cd %path",code,condition), fileName)
  shell(fileName)
on.exit(unlink(fileName))
}
