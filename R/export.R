#' Save an `EViews` workfile wf from R
#'
#' Use this function to save an `EViews` workfile  from R
#'
#' @usage eviews_wfsave(wf="",page="",options="",source_description="",table_description="",keep_list="",drop_list="",keepmap_list="",dropmap_list="",smpl_spec="")
#' @inheritParams eviews_wfcreate
#' @return An EViews workfile.
#'
#' @examples library(EviewsR)
#' \dontrun{
#' eviews_wfcreate(wf_name="EVIEWSR_WORKFILE",page_name="EVIEWSR_PAGE",frequency="m",start_date="1990m1",end_date="2021m4",path="",save=T)
#'}
#' @seealso eng_eviews, eviews_commands, eviews_graph, eviews_import, eviews_object, eviews_pagesave, eviews_rwalk, eviews_wfcreate, eviews_wfsave, import_table, import
#' @keywords documentation
#' @export
export=function(source_description="",wf="",start_date = "",frequency = "",save_path = ""){
  if(is.data.frame(source_description)){

    if(wf=="") wf=paste0(paste0(names(source_description),collapse = ""),"_EviewsR")

    save_path=gsub("/","\\\\",save_path)
    save_path1=save_path
    save_path=paste0("%save_path=",shQuote(save_path))

    # if(save_path1!=""){
    #   if(!dir.exists(save_path1)) dir.create(save_path1,recursive = T)
    #}

    csvFile=paste0(wf,".csv")
    write.csv(series,csvFile,row.names = FALSE)
    eviews_import(wf=wf,source_description = csvFile,start_date = start_date,frequency = frequency,save_path = save_path1)
    on.exit(unlink(csvFile),add = T)

}

}
