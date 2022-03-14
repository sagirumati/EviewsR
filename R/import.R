#' Import `EViews` series to R as dataframe
#'
#' Use this function to import `EViews` series to R as dataframe
#'
#' @usage import(object_name="",wf="",page="",options="",source_description="",table_description="",keep_list="",drop_list="",keepmap_list="",
#' dropmap_list="",smpl_spec="")
#'
#' @param object_name Object name to be to store the imported `EViews` series.
#' @inheritParams eviews_pagesave
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#' import(object_name="myDataFrame",wf="eviews/workfile",drop_list = "y")
#'}
#' @seealso eng_eviews, exec_commands, eviews_graph, eviews_import, create_object, eviews_pagesave, rwalk, eviews_wfcreate, eviews_wfsave, export, [EviewsR::import_table]
#' @keywords documentation
#' @export
#' @md
import=function(object_name="",wf="",page="",options="",source_description="",table_description="",keep_list="",drop_list="",keepmap_list="",dropmap_list="",smpl_spec=""){

  fileName=tempfile("EVIEWS", ".", ".prg")
  source_description=tempfile("EviewsR", ".", ".csv")
  source_description_file=source_description
  wf=paste0('%wf=',shQuote(wf))
  page=paste0('%page=',shQuote(page))
  options=paste0('%options=',shQuote(options))
  source_description=paste0('%source_description=',shQuote(source_description))
  table_description=paste0('%table_description=',shQuote(table_description))
  keep_list=paste0('%keep_list=',shQuote(keep_list))
  drop_list=paste0('%drop_list=',shQuote(drop_list))
  keepmap_list=paste0('%keepmap_list=',shQuote(keepmap_list))
  dropmap_list=paste0('%dropmap_list=',shQuote(dropmap_list))
  smpl_spec=paste0('%smpl_spec=',shQuote(smpl_spec))


eviews_code=r'(open {%wf}

if %page<>"" then
pageselect {%page}
endif
if %path<>"" then
%source_description=%path+"\"+%source_description
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

pagesave(%options) {%source_description} {%table_description} {%keep_list} {%drop_list} {%keepmap_list} {%dropmap_list} {%smpl_spec}

exit
)'
#path=here()
  # path=getwd()
writeLines(c(eviews_path(),wf,page,options,source_description,table_description,keep_list,drop_list,keepmap_list,dropmap_list,smpl_spec
,eviews_code),fileName)

system_exec()

  # system2("EViews",paste0("exec ",shQuote(paste0(path,"/",fileName))))

  if(!exists("eviews") || !is.environment(eviews)) eviews<<-new.env()
 assign(object_name,read.csv(source_description_file),envir =eviews)

 on.exit(unlink(c(fileName,source_description_file)))
 }


# import(wf="eviews/workfile",drop_list = "y")
# param start_date Object or a character string representing the \code{start date}. It should be left blank for undated (when the \code{frequency} is \code{u}).
