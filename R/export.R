#' Export R dataframe as an `EViews` workfile
#'
#' Use this function to export R dataframe as an `EViews` workfile
#'
#' @usage export(source_description="",wf="",start_date = "",frequency = "",save_path = "")
#' @inheritParams eviews_wfcreate
#' @inheritParams eviews_pagesave
#' @return An EViews workfile.
#'
#' @examples library(EviewsR)
#' \dontrun{
#' x=runif(100); y=runif(100); data=data.frame(x,y)
#'
#' export(wf="eviewr_export",source_description=data,start_date = '1990',frequency = "m")
#'}
#' @seealso eng_eviews, exec_commands, eviews_graph, eviews_import, create_object, eviews_pagesave, rwalk, eviews_wfcreate, eviews_wfsave, import_table, import
#' @keywords documentation
#' @export
export=function(source_description="",wf="",start_date = "",frequency = "",save_path = ""){
  # if(is.data.frame(source_description)){

    # if(wf=="") wf=paste0(paste0(names(source_description),collapse = ""),"_EviewsR")

    # save_path=gsub("/","\\\\",save_path)
    # save_path1=save_path
    # save_path=paste0("%save_path=",shQuote(save_path))

    # if(save_path1!=""){
    #   if(!dir.exists(save_path1)) dir.create(save_path1,recursive = T)
    #}

    # csvFile=paste0(wf,".csv")
    # write.csv(source_description,csvFile,row.names = FALSE)
    eviews_import(wf=wf,source_description =source_description,start_date = start_date,frequency = frequency,save_path = save_path)
    # on.exit(unlink(csvFile),add = T)



}
