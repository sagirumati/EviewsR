#' Execute `EViews` commands from R
#'
#' Use this function to execute `EViews` commands from R
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
#' exec_commands(c("wfcreate(wf=EviewsR_exec_commands,page=Page) m 2000 2022",
#' "save EviewsR_exec_commands","exit"))
#'
#'
#' # The second example opens the `EViews` workfile and then generate a random series
#' # named `y` and plots its line graph. It also freezes `ols` equation as `EviewsROLS`
#'
#' eviewsCommands=r'(genr y=rnd
#' genr x=rnd
#' equation ols.ls y c x
#' freeze(EviewsROLS,mode=overwrite) ols)'
#'
#' exec_commands(commands=eviewsCommands,wf="EviewsR_exec_commands")
#'
#' # unlink("EviewsR_exec_commands.wf1")
#'
#'
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
