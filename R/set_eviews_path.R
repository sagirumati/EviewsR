#' Set `EViews` path
#'
#' Use this function to set `EViews` path. It is only useful when the `EViews` is not installed in standard directory, or when there are multiple `EViews` executables and the user wants to use older version of `EViews`.
#'
#' @param engine_path Path to the EViews executable
#' @return Character
#'
#' @examples library(EviewsR)
#' \dontrun{
#' set_eviews_path('C:/Program Files (x86)/EViews 10/eviews10.exe')
#'}
#' @family important functions
#' @keywords documentation
#' @export
set_eviews_path <- function(engine_path="eviews"){
  engine_path=Sys.which(engine_path)
  if(engine_path=="") engine_path=Sys.which("EViews13_x64")
  if(engine_path=="") engine_path=Sys.which("EViews13_x86")
  if(engine_path=="") engine_path=Sys.which("EViews12_x64")
  if(engine_path=="") engine_path=Sys.which("EViews12_x86")
  if(engine_path=="") engine_path=Sys.which("EViews11_x64")
  if(engine_path=="") engine_path=Sys.which("EViews11_x86")
  if(engine_path=="") engine_path=Sys.which("EViews10_x64")
  if(engine_path=="") engine_path=Sys.which("EViews10_x86")
  if(engine_path=="") engine_path=Sys.which("EViews9_x64")
  if(engine_path=="") engine_path=Sys.which("EViews9_x86")
  if(engine_path=="") engine_path=Sys.which("EViews10")
  if(engine_path=="") stop("EViews executable cannot be found, please use 'set_eviews_path' function to set the path to the EViews executable")
   engine_path<<-engine_path
}
