#' Execute `EViews` commands.
#'
#' Use this function  in R, R Markdown and Quarto to execute `EViews` commands.
#'
#' @inheritParams eviews_graph
#' @param commands Object or a vector of character strings of `EViews` commands
#'
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#' # The first example creates an `EViews` workfile with monthly frequency from 1990 2021,
#' # then save the workfile in the current working directory
#'
#' exec_commands(c("wfcreate(wf=exec_commands,page=eviewsPage) m 2000 2022"))
#'
#' # The second example opens the `EViews` workfile and then generate a random series
#' # named `y` and plots its line graph. It also freezes `ols` equation as `EviewsROLS`
#'
#' eviewsCommands=r'(pagecreate(page=eviewspage1) 7 2020 2022
#' for %page eviewspage eviewspage1
#' pageselect {%page}
#' genr y=rnd
#' genr x=rnd
#' equation ols.ls y c x
#' graph x_graph.line x
#' graph y_graph.area y
#' freeze(OLSTable,mode=overwrite) ols
#' next
#' )'
#'
#' exec_commands(commands=eviewsCommands,wf="exec_commands")
#'
#' # unlink("exec_commands.wf1")
#'}
#' @family important functions
#' @keywords documentation
#' @export
exec_commands=function(commands="",wf="",page="",save_path=""){

  if(wf!="" && save_path=="") save_path=dirname(wf)

  fileName=tempfile("EVIEWS", ".", ".prg")
  save_path %<>% shQuote_cmd %>% paste0('%save_path=',.)
  wf=paste0('%wf=',shQuote_cmd(wf))
  page=paste0('%page=',shQuote_cmd(page))
  eviewsCode=r'(if %wf<>"" then
  wfopen {%wf}
  endif
  if %page<>"" then
  pageselect {%page}
  endif)'


  saveCode=r"(%wf=@wfname
  if %save_path<>"" then
  %save_path=%save_path+"\"
  endif

  wfsave {%save_path}{%wf}
  exit)"

writeLines(c(eviews_path(),save_path,wf,page,eviewsCode,commands,saveCode),fileName)
    system_exec()
    on.exit(unlink_eviews(),add = TRUE)
}
