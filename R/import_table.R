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
import_table=function(wf="",page="*",table="*"){

chunkName=opts_current$get('label')

    envName=chunkName %n% "eviews" %>% gsub("[._-]","",.)


    # chunkName1=paste0(chunkName,'-') %>%
    # shQuote_cmd() %>% paste0('%chunkName=',.)

  if(!identical(envName,"eviews")) assign(envName,new.env(),envir=knit_global())
  if(identical(envName,"eviews")){
    if(!exists("eviews") || !is.environment(eviews)) assign(envName,new.env(),envir=globalenv())
  }

  eviewsrText=tempfile("eviewsrText",".") %>%
    basename
  eviewsrText1=eviewsrText

  eviewsrText %<>%   shQuote_cmd %>%
    paste0("%eviewsrText=",.)


  fileName=basename(tempfile("EVIEWS", ".", ".prg"))
  # file_name=table_name

  wf=paste0('%wf=',shQuote_cmd(wf))
  page=paste0('%page=',shQuote_cmd(page))
  table=paste0('%table=',shQuote_cmd(table))


  saveCode=r'(open {%wf}



  %pagelist=@pagelist

  if %page<>"*" then
   %pagelist=%page
  endif


  %tablePath=""

  for %page {%pagelist}
  pageselect {%page}
  %tables=@wlookup(%table ,"table")

  if @wcount(%tables)<>0 then
  for %y {%tables}
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



  on.exit(unlink_eviews(),add = TRUE)


  eviewsCode=paste0(c(eviews_path(),eviewsrText,wf,page,table,saveCode),collapse = '\n')


writeLines(c(eviewsCode,saveCode),fileName)

system_exec()

  if(file.exists(paste0(eviewsrText1,"-table.txt"))) tablePath=readLines(paste0(eviewsrText1,"-table.txt")) %>%
    strsplit(split=" ") %>% unlist()

  for (i in tablePath){
    tableName=gsub("\\-.*","",i) %>% tolower
    assign(tableName,read.csv(paste0(i,".csv")),envir = get(envName,envir = parent.frame()))
  }

    }
