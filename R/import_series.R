#' Import `EViews` series to R as dataframe
#'
#' Use this function to import `EViews` series to R as dataframe
#'
#'
#' @param df_name Dataframe name to be used to store the imported `EViews` series.
#' @inheritParams eviews_pagesave
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#' demo(exec_commands)
#'
#' import_series(df_name="importedDataFrame",wf="EviewsR_exec_commands",drop_list = "y")
#'
#' eviews$importedDataFrame
#'
#' knitr::kable(head(eviews$importedDataFrame),format="pandoc",caption="Table from EviewsR")
#'}
#' @family important functions
#' @keywords documentation
#' @export
#' @md
import_series=function(df_name="",wf="",page="",options="",keep_list="",drop_list="",keepmap_list="",dropmap_list="",smpl_spec=""){

  keep_list=paste0(keep_list,collapse = " ")
  drop_list=paste0(drop_list,collapse = " ")
  keepmap_list=paste0(keepmap_list,collapse = " ")
  dropmap_list=paste0(dropmap_list,collapse = " ")
  fileName=tempfile("EVIEWS", ".", ".prg")
  source_description=tempfile("EviewsR", ".", ".csv")
  source_description_file=source_description
  wf=paste0('%wf=',shQuote_cmd(wf))
  page=paste0('%page=',shQuote_cmd(page))
  options=paste0('%options=',shQuote_cmd(options))
  source_description=paste0('%source_description=',shQuote_cmd(source_description))
  keep_list=paste0('%keep_list=',shQuote_cmd(keep_list))
  drop_list=paste0('%drop_list=',shQuote_cmd(drop_list))
  keepmap_list=paste0('%keepmap_list=',shQuote_cmd(keepmap_list))
  dropmap_list=paste0('%dropmap_list=',shQuote_cmd(dropmap_list))
  smpl_spec=paste0('%smpl_spec=',shQuote_cmd(smpl_spec))


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

pagesave({%options}) {%source_description} {%keep_list} {%drop_list} {%keepmap_list} {%dropmap_list} {%smpl_spec}

exit
)'
writeLines(c(eviews_path(),wf,page,options,source_description,keep_list,drop_list,keepmap_list,dropmap_list,smpl_spec
,eviews_code),fileName)

system_exec()


  if(!exists("eviews") || !is.environment(eviews)) eviews<<-new.env()

dataFrame=read.csv(source_description_file)

if(grepl('date',colnames(dataFrame)[1])){
  colnames(dataFrame)[1]="date"
  dataFrame$date=as.POSIXct(dataFrame$date)
}

assign(df_name,dataFrame,envir =eviews)

 on.exit(unlink(c(fileName,source_description_file)))
 }

