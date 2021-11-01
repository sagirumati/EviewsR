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
import_kable=function(wf="",page="",table_name=""){

  fileName=tempfile("EVIEWS", ".", ".prg")
   save_path=tempfile("EVIEWS",".")
  # file_name=basename(tempfile("EVIEWS","."))
  # file_name=table_name
  save_path_file=basename(save_path)
  # dir.create(save_path)


  wf=paste0('%wf=',shQuote(wf))
  page=paste0('%page=',shQuote(page))
  table_name.csv=paste0(table_name,".csv")
  table_name=paste0('%table_name=',shQuote(table_name))
  save_path=paste0('%save_path=',shQuote(save_path))


  eviews_code=r'(%runpath=@runpath
  cd %runpath
  open {%wf}

  if %page<>"" then
  pageselect {%page}
  endif

  {%table_name}.save(t=csv) {%table_name})'

  path=here()
  # path=getwd()
writeLines(c(wf,page,table_name,save_path,eviews_code),fileName)
  system2("EViews",paste0("run(q)",shQuote(paste0(path,"/",fileName))))
  k=kable(read.csv(table_name.csv))
  return(k)
  on.exit(unlink(c(fileName,table_name.csv),recursive = T))

}


# eviews_commands(wf="eviews/workfile",commands = c("equation someeq.ls y ar(1)","graph grap1.line y"))
