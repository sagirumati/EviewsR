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
#' @seealso eng_eviews, eviews_commands, eviews_graph, eviews_import, eviews_object, eviews_pagesave, eviews_rwalk, eviews_wfcreate, eviews_wfsave, export, [EviewsR::import_table]
#' @keywords documentation
#' @export
#' @md
import=function(wf="",page="",options="",source_description="",table_description="",keep_list="",drop_list="",keepmap_list="",dropmap_list="",smpl_spec=""){

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

)'
#path=here()
  path=getwd()
writeLines(c(eviews_path(),wf,page,options,source_description,table_description,keep_list,drop_list,keepmap_list,dropmap_list,smpl_spec
,eviews_code),fileName)
  system2("EViews",paste0("exec ",shQuote(paste0(path,"/",fileName))))
  name=""
 assign(name,read.csv(source_description_file),envir = .GlobalEnv)
 on.exit(unlink(c(fileName,source_description_file)))
 }


# import(wf="eviews/workfile",drop_list = "y")
