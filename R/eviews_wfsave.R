#' Save an `EViews` workfile.
#'
#' Use this function  in R, R Markdown and Quarto to save an `EViews` workfile.
#'
#' @inheritParams eviews_pagesave
#' @return An EViews workfile.
#'
#' @examples library(EviewsR)
#' \dontrun{
#'  demo(exec_commands)
#'
#' eviews_wfsave(wf="exec_commands",source_description = "eviews_wfsave.csv",
#' drop_list = "x")
#'}
#' @family important functions
#' @keywords documentation
#' @export
eviews_wfsave=function(wf="",page="",options="",source_description="",table_description="",keep_list="",drop_list="",keepmap_list="",dropmap_list="",smpl_spec="",save_path=dirname(source_description)){

  if(!dir.exists(save_path)) dir.create(save_path,recursive = T)

    fileName=tempfile("EVIEWS", ".", ".prg")
  wf=paste0('%wf=',shQuote_cmd(wf))
  page=paste0('%page=',shQuote_cmd(page))

  options=paste(options,collapse = ",")
  options=paste0('%options=',shQuote_cmd(options))
  source_description=paste0('%source_description=',shQuote_cmd(source_description))
  table_description=paste0('%table_description=',shQuote_cmd(table_description))

  keep_list=paste(keep_list,collapse = " ")
  keep_list=paste0('%keep_list=',shQuote_cmd(keep_list))

  drop_list=paste(drop_list,collapse = " ")
  drop_list=paste0('%drop_list=',shQuote_cmd(drop_list))

  keepmap_list=paste(keepmap_list,collapse = " ")
  keepmap_list=paste0('%keepmap_list=',shQuote_cmd(keepmap_list))

  dropmap_list=paste(dropmap_list,collapse = " ")
  dropmap_list=paste0('%dropmap_list=',shQuote_cmd(dropmap_list))

  smpl_spec=paste0('%smpl_spec=',shQuote_cmd(smpl_spec))

  eviewsCode='open {%wf}

  if %page<>"" then
  pageselect {%page}
  endif


  if %keep_list<>"" then
  %keep_list="@keep "+%keep_list
  endif


  if %drop_list<>"" then
  %drop_list="@drop "+%drop_list
  endif

  if %keepmap_list<>"" then
  %keepmap_list="@keepmap "+%keepmap_list
  endif

  if %dropmap_list<>"" then
  %dropmap_list="@dropmap "+%dropmap_list
  endif


  if %smpl_spec<>"" then
  %smpl_spec="@smpl "+%smpl_spec
  endif

  wfsave(%options) %source_description {%table_description} {%keep_list} {%drop_list} {%keepmap_list} {%dropmap_list} {%smpl_spec}
  exit'
  writeLines(c(eviews_path(),wf,page,options,source_description,table_description,keep_list,drop_list,keepmap_list,dropmap_list,smpl_spec
               ,eviewsCode),fileName)

  system_exec()
  on.exit(unlink_eviews(),add = TRUE)
}
