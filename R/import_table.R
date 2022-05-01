#' Import `EViews` table object as `kable`
#'
#' Use this function to import `EViews` table object as `kable`
#'
#' @usage import_table(wf="",page="",table_name="",table_range="",format=kable_format(),
#'  digits = getOption("digits"), row.names = NA,col.names = NA, align,caption = NULL,
#'   label = NULL, format.args = list(),escape = FALSE, table.attr = "", booktabs = TRUE,
#'    longtable = FALSE, valign = "t",position = "h", centering = TRUE,
#'    vline = getOption("knitr.table.vline",if (booktabs) "" else "|"),
#' toprule = getOption("knitr.table.toprule",
#' if (booktabs) "\\\\toprule" else "\\\\hline"),
#' bottomrule = getOption("knitr.table.bottomrule",
#' if (booktabs) "\\\\bottomrule" else "\\\\hline"),
#' midrule = getOption("knitr.table.midrule",
#' if (booktabs) "\\\\midrule" else "\\\\hline"),
#' linesep = if (booktabs) c("","", "", "", "\\\\addlinespace") else "\\\\hline",
#'  caption.short = "",table.envir = if (!is.null(caption)) "table",...)
#' @inheritParams knitr::kable
#' @inheritParams kableExtra::kbl
#' @inheritParams eviews_wfcreate
#' @param table_range A vector of characters specifying the table range of rows and columns
#' @param table_name Name of an `EViews` table object in an `EViews` workfile
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#' demo(exec_commands)
#'
#' import_table(wf="EviewsR_exec_commands",page="page",table_name="EviewsROLS",format="pandoc")
#'}
#' @family important functions
#' @keywords documentation
#' @export
import_table=function(wf="",page="",table_name="",table_range="",format=kable_format(), digits = getOption("digits"), row.names = NA,
                      col.names = NA, align, caption = NULL, label = NULL, format.args = list(),escape = FALSE, table.attr = "", booktabs = TRUE, longtable = FALSE, valign = "t", position = "h", centering = TRUE, vline = getOption("knitr.table.vline",
                     if (booktabs) "" else "|"), toprule = getOption("knitr.table.toprule",
                     if (booktabs) "\\toprule" else "\\hline"), bottomrule = getOption("knitr.table.bottomrule",
                     if (booktabs) "\\bottomrule" else "\\hline"), midrule = getOption("knitr.table.midrule",
                     if (booktabs) "\\midrule" else "\\hline"), linesep = if (booktabs) c("",
                     "", "", "", "\\addlinespace") else "\\hline", caption.short = "", table.envir = if (!is.null(caption)) "table",...){

  fileName=basename(tempfile("EVIEWS", ".", ".prg"))
  # file_name=table_name

  wf=paste0('%wf=',shQuote(wf))
  page=paste0('%page=',shQuote(page))
  table_name.csv=paste0(table_name,".csv")
  table_range=paste0('%table_range=',shQuote(table_range))
  table_name=paste0('%table_name=',shQuote(table_name))


  eviews_code=r'(open {%wf}

  if %page<>"" then
  pageselect {%page}
  endif

  if %table_range<>"" then
  %table_range=",r="+%table_range
  endif

  {%table_name}.save(t=csv{%table_range}) {%table_name})'

  writeLines(c(eviews_path(),wf,page,table_name,table_range,eviews_code,"exit"),fileName)

  system_exec()
  #on.exit(unlink(c(paste0(path,"/",fileName),paste0(path,"/",table_name.csv))))
  on.exit(unlink_eviews(),add = TRUE)

  table= readLines(table_name.csv)



   if(any(grepl("^,.*,$", table))) table=table[-grep("^,.*,$", table)]

  table=read.csv(text=table,allowEscapes = T,header = T,check.names = FALSE)


  return(kable(table, format = format, digits = digits,row.names = row.names, col.names = col.names, align = align, caption = caption, label = label, format.args = format.args, escape = escape, ...))

  }
