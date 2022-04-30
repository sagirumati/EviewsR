#' Execute `EViews` commands from R
#'
#' Use this function to execute `EViews` commands from R
#'
#' @usage exec_commands(commands="",wf="",page="")
#' @param commands Object or a vector of character strings of `EViews` commands
#' @inheritParams eviews_wfcreate
#'
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#' exec_commands(c("wfcreate(wf=Workfile,page=Page) m 2000 2022","save workfile","exit"))
#' exec_commands(c("genr y=rnd","y.line"),wf="Workfile")
#' unlink("workfile.wf1")
#' # The first example creates an `EViews` workfile with monthly frequency from 1990 2021,
#' # then save the workfile in the current working directory
#'
#' # The second example opens the `EViews` workfile and then generate a random series
#' # named `y` and plot its line graph.
#' # The third line deletes the workfile from your directory.
#'}
#' @family important functions
#' @keywords documentation
#' @export
exec_commands=function(commands="",wf="",page=""){

  fileName=tempfile("EVIEWS", ".", ".prg")
  wf=paste0('%wf=',shQuote(wf))
  page=paste0('%page=',shQuote(page))
  eviews_code=r'(if %wf<>"" then
  wfopen {%wf}
  endif
  if %page<>"" then
  pageselect {%page}
  endif)'

writeLines(c(eviews_path(),wf,page,eviews_code,commands),fileName)
    system_exec()
    on.exit(unlink_eviews(),add = TRUE)
}

# exec_commands(wf="eviews/workfile",commands = c("equation someeq.ls y ar(1)","graph grap1.line y"))

