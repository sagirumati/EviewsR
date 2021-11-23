#' Execute `EViews` commands from R
#'
#' Use this function to execute `EViews` commands from R
#'
#' @usage eviews_commands(commands="",wf="",page="")
#' @param commands Object or a vector of character strings of `EViews` commands
#' @inheritParams eviews_wfcreate
#'
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#' eviews_commands(c("wfcreate(wf=page=eviews_workfile,page=eviews_page) m 1990 2021","genr y=rnd","y.line"))
#' eviews_commands(c("genr y=rnd","y.line"),wf="EviewsR")
#'}
#' @seealso eng_eviews, eviews_graph, eviews_import, eviews_object, eviews_pagesave, eviews_rwalk, eviews_wfcreate, eviews_wfsave, export, import_table, import
#' @keywords documentation
#' @export
eviews_commands=function(commands="",wf="",page=""){

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

# eviews_commands(wf="eviews/workfile",commands = c("equation someeq.ls y ar(1)","graph grap1.line y"))

