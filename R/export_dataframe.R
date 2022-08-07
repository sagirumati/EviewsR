#' Export R dataframe as an `EViews` workfile
#'
#' Use this function in R, R Markdown and Quarto to export an R dataframe as an `EViews` workfile
#'
#' @inheritParams eviews_wfcreate
#' @inheritParams eviews_pagesave
#' @return An EViews workfile.
#'
#' @examples library(EviewsR)
#' \dontrun{
#'
#' Data=data.frame(x=cumsum(rnorm(100)),y=cumsum(rnorm(100)))
#'
#' export_dataframe(wf="export_dataframe",source_description=Data,start_date = '1990',frequency = "m")
#'}
#' @family important functions
#' @keywords documentation
#' @export
export_dataframe=function(source_description="",wf="",start_date = "",frequency = "",save_path = dirname(wf)){

  if(is.xts(source_description)) source_description=data.frame(date=index(source_description),coredata(source_description))

  if(wf=="") wf=paste0(paste0(names(source_description),collapse = ""),"_",tempfile("") %>% basename)

  eviews_import(wf=wf,source_description =source_description,start_date = start_date,frequency = frequency,save_path = save_path)
}
