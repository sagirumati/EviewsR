#' Create an `EViews` workfile from R
#'
#' Use this function to create an `EViews` workfile from R
#' Use `run_dynare(model,code)`  if you want the `Dynare` files to live in the current working directory.
#' Use `run_dynare(model,code,path)` if you want the `Dynare` files to live in the path different from the current working directory.
#'
#' @usage run_dynare(model,code,path)
#' @param wf_name Object or a character string representing the name of a workfile to be created
#'
#' @param page_name Object or a character string representing the name of a workfile page to be created
#'
#' @param path Object or a character string representing the path to the folder for the \code{Dynare} file. The current working directory is the default `path`. Specify the `path` only if the `Dynare` files live in different path from the current working directory.
#'
#' @return Set of \code{Dynare} (open-source software for DSGE modelling) outputs
#' @examples library(DynareR)
#' \dontrun{
#'
#'}
#' @seealso eng_eviews
#' @keywords documentation
#' @export
eviews_wfcreate=function(wf_name="",page_name="",frequency="a",start_date="1999",end_date="",save=T){
  fileName=tempfile("EVIEWS", ".", ".prg")
  code=paste(paste0("wfcreate(wf=",wf_name,",page=",page_name,")"),frequency,start_date,end_date)
  if(save==T){
    condition='%wfname=@wfname
    wfsave {%wfname}'
  } else{
    condition=""
  }
  writeLines(c("%path=@runpath","cd %path",code,condition), fileName)
  system2("EViews12_x64 run",fileName)
on.exit(unlink(fileName))
}
