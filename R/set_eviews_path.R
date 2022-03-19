#' Set `EViews` path
#'
#' Use this function to set `EViews` path
#'
#' @usage set_eviews_path(eviews_system_path="eviews")
#' @param eviews_system_path Path to the EViews executable
#' @return Character
#'
#' @examples library(EviewsR)
#' \dontrun{
#' set_eviews_path('C:/Program Files (x86)/EViews 10/eviews10.exe')
#'}
#' @seealso eng_eviews, create_commands, eviews_graph, eviews_import, create_object, eviews_pagesave, rwalk, eviews_wfcreate, eviews_wfsave, export, import_table, import
#' @keywords documentation
#' @export
set_eviews_path <- function(eviews_system_path="eviews") eviews_system_path<<-eviews_system_path
