#' Create an `EViews` graph in R Markdown
#'
#' Use this function to create an `EViews` graph in R Markdown
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
#' eviews_wfcreate(wf_name="WORKFILE",page_name="PAGE",frequency="m",start_date="1990m1",end_date="2021m4",path="",save=T)
#'}
#' @seealso eng_eviews
#' @keywords documentation
#' @export
eviews_graph=function(series="",wf_name="",page_name="",frequency="",start_date="",end_date="",path="",save=FALSE,merge=TRUE){
  stopifnot("EViewsR works on Windows only"=Sys.info()["sysname"]=="Windows")
  fileName=tempfile("EVIEWS", ".", ".prg")
  if(wf_name!="" & page_name!=""){
    #code1=paste(paste0("wfopen ",wf_name,"@char(13)","pageselect ",page_name,"@chr(13)","%z=@wlookup(",series,'"series")"',"@chr(13)",))
    code1=paste0("wfopen ",wf_name)
    code2=paste0("pageselect ",page_name)
    code3=paste0("%z=@wlookup(",'"',paste(series,collapse = " "),'"',',"series"',")")
    code4='for %y {%z}
      if %z=" " then
      %z=" "
      else
      graph graph_{%y}.line {%y}
      endif
      next'
    if(merge==TRUE){
      graphMerge=tempfile("graph", ".", "merge")
      code5=paste0("%z=@wlookup(",'"',paste(series,collapse = " "),'"',',"series"',")")
      code6=paste0('graph ',graphMerge,".merge {%z}")}else{
        code5=""
    }

    }else{
    code=paste(paste0("wfcreate(wf=",wf_name,",page=",page_name,")"),frequency,start_date,end_date)
    }
  # if(save==FALSE){
  #   condition='%wfname=@wfname
  #   %path=
  #   wfsave {%wfname}'
  # } else{
  #   condition=""
  # }
  writeLines(c("%path=@runpath","cd %path",code1,code2,code3,code4,code5), fileName)
  shell(fileName)
on.exit(unlink(fileName))
}

