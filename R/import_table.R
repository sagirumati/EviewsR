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
import_table=function(wf="",page=""){


  chunkName1=paste0(chunkName,'-') %>%
    shQuote_cmd() %>% paste0('%chunkName=',.)


  eviewsrText=tempfile("eviewsrText",".") %>%
    basename
  eviewsrText1=eviewsrText

  eviewsrText %<>%   shQuote_cmd %>%
    paste0("%eviewsrText=",.)


  fileName=basename(tempfile("EVIEWS", ".", ".prg"))
  # file_name=table_name

  wf=paste0('%wf=',shQuote_cmd(wf))
  page=paste0('%page=',shQuote_cmd(page))



  saveCode=r'(

  %tablePath=""

  %pagelist=@pagelist

  if %pagelist1<>"" then
   %pagelist=%pagelist1
  endif

  for %page {%pagelist}
  pageselect {%page}
  %tables=@wlookup("*" ,"table")

  if @wcount(%tables)<>0 then
  for %y {%tables}
  'table {%page}_{%y}
  %tablePath=%tablePath+" "+%page+"_"+%y+"-"+%eviewsrText
  {%y}.save(t=csv) {%page}_{%y}-{%eviewsrText}
  next
  endif
  next

  text {%eviewsrText}_table
  {%eviewsrText}_table.append {%tablePath}
  {%eviewsrText}_table.save {%eviewsrText}-table

  exit
  )'



  writeLines(c(eviews_path(),wf,page,table_name,table_range,eviewsCode,"exit"),fileName)

  system_exec()
  #on.exit(unlink(c(paste0(path,"/",fileName),paste0(path,"/",table_name.csv))))
  on.exit(unlink_eviews(),add = TRUE)

  table= readLines(table_name.csv)



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
