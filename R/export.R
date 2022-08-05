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
#' Data=data.frame(x=cumsum(rnorm(100)),y=cumsum(rnorm(100)))
#'
#' export(wf="export",source_description=Data,start_date = '1990',frequency = "m")
#'}
#' @family important functions
#' @keywords documentation
#' @export
export=function(source_description="",wf="",start_date = "",frequency = "",save_path = ""){

  eviews_import(wf=wf,source_description =source_description,start_date = start_date,frequency = frequency,save_path = save_path)
}
