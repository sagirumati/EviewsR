#' Create an `EViews` object on a workfile from R
#'
#' Use this function to create an `EViews` object on a workfile from R
#'
#' @usage eviews_wfcreate(wf_name="",page_name="",frequency="",start_date="",end_date="",path="",save=T)
#' @inheritParams eviews_graph
#' @param action Any valid `EViews` command for `EViews` object declaration, like \code{freeze}, \code{do}, \code{equation}, \code{table}.
#' @param action_opt An option that modifies the default behaviour of the `EViews` action.
#' @param object_name The name of the `EViews` object to be acted upon.
#' @param view_or_proc The `EViews` object view or procedure to be performed.
#' @param options_list An option that modifies the default behaviour of the `EViews` view or procedure.
#' @param arg_list A list of `EViews` view or procedure arguments.
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#' eviews_wfcreate(wf_name="EVIEWSR_WORKFILE",page_name="EVIEWSR_PAGE",frequency="m",start_date="1990m1",end_date="2021m4",path="",save=T)
#'}
#' @seealso eng_eviews, eviews_commands, eviews_graph, eviews_import, eviews_object, eviews_pagesave, eviews_rwalk, eviews_wfcreate, eviews_wfsave, export, import_table, import
#' @keywords documentation
#' @export
eviews_object=function(wf="",action="",action_opt="",object_name="",view_or_proc="",options_list="",arg_list
=""){

  fileName=tempfile("EVIEWS", ".", ".prg")
  wf=paste0('%wf=',shQuote(wf))
  action=paste0('%action=',shQuote(action))

  action_opt=paste(action_opt,collapse = ",")
  action_opt=paste0('%action_opt=',shQuote(action_opt))
  object_name=paste0('%object_name=',shQuote(object_name))


  view_or_proc=paste0('%view_or_proc=',shQuote(view_or_proc))

  options_list=paste(options_list,collapse = ",")
  options_list=paste0('%options_list=',shQuote(options_list))

  arg_list=paste(arg_list,collapse = " ")
  arg_list=paste0('%arg_list=',shQuote(arg_list))


  eviews_code=r'(wfopen {%wf}
  if %action_opt<>"" then
  %action_opt="("+%action_opt+")"
  endif
  '

  if %view_or_proc<>"" then
  %view_or_proc="."+%view_or_proc
  endif

  if %options_list<>"" then
  %options_list="("+%options_list+")"
  endif

  {%action}{%action_opt} {%object_name}{%view_or_proc}{%options_list} {%arg_list}
  )'
writeLines(c(eviews_path(),wf,action,action_opt,object_name,view_or_proc,options_list,arg_list,eviews_code),fileName)

  system_exec()
  on.exit(unlink_eviews(),add = TRUE)
  }


# eviews_object(wf="eviews/workfile",action="equation",action_opt="",object_name="equ2",view_or_proc="ls",options_list="",arg_list="y ar(1)")
#
# eviews_object(wf="eviews/workfile",action="table",action_opt="4,4",object_name="mytable",view_or_proc="",options_list="",arg_list="")
