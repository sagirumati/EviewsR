#' Export R dataframe as an `EViews` workfile
#'
#' Use this function to export R dataframe as an `EViews` workfile
#'
#' @inheritParams eviews_wfcreate
#' @inheritParams eviews_pagesave
#' @return An EViews workfile.
#'
#' @examples library(EviewsR)
#' \dontrun{
#' x=runif(100); y=runif(100); data=data.frame(x,y)
#'
#' export(wf="EviewR_export",source_description=data,start_date = '1990',frequency = "m")
#'}
#' @family important functions
#' @keywords documentation
#' @export
export_dataframe=function(source_description="",wf="",start_date = "",frequency = "",save_path = dirname(wf)){

  eviews_import(wf=wf,source_description =source_description,start_date = start_date,frequency = frequency,save_path = save_path)
}
