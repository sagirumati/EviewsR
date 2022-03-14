#' Create an `EViews` object on a workfile from R
#'
#' Use this function to create an `EViews` object on a workfile from R
#'
#' @usage create_object(wf="",page="",action="",action_opt="",object_name="",view_or_proc="",options_list="",arg_list="")
#' @inheritParams eviews_graph
#' @inheritParams eviews_wfcreate
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
#' create_object(wf="EviewsR",action="equation",action_opt="",object_name="equ2",view_or_proc="ls",options_list="",arg_list="y ar(1)")
#'}
#' @seealso eng_eviews, create_commands, eviews_graph, eviews_import, create_object, eviews_pagesave, rwalk, eviews_wfcreate, eviews_wfsave, export, import_table, import
#' @keywords documentation
#' @export
create_object=function(wf="",page="",action="",action_opt="",object_name="",view_or_proc="",options_list="",arg_list
=""){

  fileName=tempfile("EVIEWS", ".", ".prg")
  wf=paste0('%wf=',shQuote(wf))
  page=paste0('%page=',shQuote(page))
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

  if %page<>"" then
  pageselect {%page}
  endif

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

  wfsave {%wf}
  exit
  )'
writeLines(c(eviews_path(),wf,page,action,action_opt,object_name,view_or_proc,options_list,arg_list,eviews_code),fileName)

  system_exec()
  on.exit(unlink_eviews(),add = TRUE)
  }


#
# create_object(wf="eviews/workfile",action="table",action_opt="4,4",object_name="mytable",view_or_proc="",options_list="",arg_list="")
