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
#' @seealso eng_eviews
#' @keywords documentation
#' @export
import_table=function(wf="",page="",table_name="",format=kable_format(), digits = getOption("digits"), row.names = NA,
                      col.names = NA, align, caption = NULL, label = NULL, format.args = list(),escape = FALSE, table.attr = "", booktabs = TRUE, longtable = FALSE, valign = "t", position = "h", centering = TRUE, vline = getOption("knitr.table.vline",
                                                                                                                                                                                                                                       if (booktabs) "" else "|"), toprule = getOption("knitr.table.toprule",
                                                                                                                                                                                                                                                                                       if (booktabs) "\\toprule" else "\\hline"), bottomrule = getOption("knitr.table.bottomrule",
                                                                                                                                                                                                                                                                                                                                                         if (booktabs) "\\bottomrule" else "\\hline"), midrule = getOption("knitr.table.midrule",
                                                                                                                                                                                                                                                                                                                                                                                                                           if (booktabs) "\\midrule" else "\\hline"), linesep = if (booktabs) c("",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                "", "", "", "\\addlinespace") else "\\hline", .caption.short = "", table.envir = if (!is.null(caption)) "table",...){

  fileName=basename(tempfile("EVIEWS", ".", ".prg"))
  file_name=table_name


  wf=paste0('%wf=',shQuote(wf))
  page=paste0('%page=',shQuote(page))
  table_name.csv=paste0(table_name,".csv")
  table_name=paste0('%table_name=',shQuote(table_name))


  eviews_code=r'(open {%wf}

  if %page<>"" then
  pageselect {%page}
  endif

  {%table_name}.save(t=csv) {%table_name})'

  #path=here()
  path=getwd()
  writeLines(c(eviews_path(),wf,page,table_name,eviews_code,"exit"),fileName)
  system2("EViews",paste0("exec ",shQuote(paste0(path,"/",fileName))))
  on.exit(unlink(c(paste0(path,"/",fileName),paste0(path,"/",table_name.csv))))
  return(knitr::kable(read.csv(table_name.csv,allowEscapes = T,header = T,check.names = FALSE), format = format, digits = digits,row.names = row.names, col.names = col.names, align = align, caption = caption, label = label, format.args = format.args, escape = escape, ...))

}
