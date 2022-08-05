#' Import `EViews` table object as `kable`
#'
#' Use this function to import `EViews` table object as `kable`
#'
#' @inheritParams knitr::kable
#' @inheritParams kableExtra::kbl
#' @inheritParams eviews_wfcreate
#' @param range A vector of characters specifying the table range of rows and columns
#' @param table Name of an `EViews` table object in an `EViews` workfile
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#' demo(exec_commands)
#'
#' # To import the entire table object
#'
#' import_kable(wf="exec_commands",page="eviewspage",table="OLSTable",format="pandoc")
#'
#' # To import certain RANGE of the table object
#'
#' import_kable(wf="exec_commands",page="eviewspage",table="OLSTable",range="r7c1:r10c5",
#' format="pandoc")
#'}
#' @family important functions
#' @keywords documentation
#' @export
import_kable=function(wf="",page="",table="",range="",format=kable_format(), digits = getOption("digits"), row.names = NA,
                      col.names = NA, align, caption = NULL, label = NULL, format.args = list(),escape = FALSE, table.attr = "", booktabs = TRUE, longtable = FALSE, valign = "t", position = "h", centering = TRUE, vline = getOption("knitr.table.vline",
                     if (booktabs) "" else "|"), toprule = getOption("knitr.table.toprule",
                     if (booktabs) "\\toprule" else "\\hline"), bottomrule = getOption("knitr.table.bottomrule",
                     if (booktabs) "\\bottomrule" else "\\hline"), midrule = getOption("knitr.table.midrule",
                     if (booktabs) "\\midrule" else "\\hline"), linesep = if (booktabs) c("",
                     "", "", "", "\\addlinespace") else "\\hline", caption.short = "", table.envir = if (!is.null(caption)) "table",...){

  fileName=basename(tempfile("EVIEWS", ".", ".prg"))

  wf=paste0('%wf=',shQuote_cmd(wf))
  page=paste0('%page=',shQuote_cmd(page))
  table.csv=paste0(table,".csv")
  range=paste0('%range=',shQuote_cmd(range))
  table=paste0('%table=',shQuote_cmd(table))


  eviewsCode=r'(open {%wf}

  if %page<>"" then
  pageselect {%page}
  endif

  if %range<>"" then
  %range=",r="+%range
  endif

  {%table}.save(t=csv{%range}) {%table})'

  writeLines(c(eviews_path(),wf,page,table,range,eviewsCode,"exit"),fileName)

  system_exec()
  #on.exit(unlink(c(paste0(path,"/",fileName),paste0(path,"/",table.csv))))
  on.exit(unlink_eviews(),add = TRUE)

  table= readLines(table.csv)



   if(any(grepl("^,.*,$", table))) table=table[-grep("^,.*,$", table)]

  table=read.csv(text=table,allowEscapes = T,header = T,check.names = FALSE)


  kable(x = table, format = format, digits = digits,
        row.names = row.names, col.names = col.names,
        align = align, caption = caption, label = label,
        format.args = format.args, escape = escape,
        booktabs = booktabs, longtable = longtable,
        valign = valign, position = position, centering = centering,
        vline = vline, toprule = toprule, bottomrule = bottomrule,
        midrule = midrule, linesep = linesep, caption.short = caption.short,
        table.envir = table.envir, ...)

  }
