#' Import `EViews` equation object as `kable`
#'
#' Use this function to import `EViews` equation object as `kable`
#'
#' @usage import_equation(wf="",page="",equation_name="",equation_range="",format=kable_format(),
#'  digits = getOption("digits"), row.names = NA,col.names = NA, align,caption = NULL,
#'   label = NULL, format.args = list(),escape = FALSE, equation.attr = "", booktabs = TRUE,
#'    longequation = FALSE, valign = "t",position = "h", centering = TRUE,
#'    vline = getOption("knitr.equation.vline",if (booktabs) "" else "|"),
#' toprule = getOption("knitr.equation.toprule",
#' if (booktabs) "\\\\toprule" else "\\\\hline"),
#' bottomrule = getOption("knitr.equation.bottomrule",
#' if (booktabs) "\\\\bottomrule" else "\\\\hline"),
#' midrule = getOption("knitr.equation.midrule",
#' if (booktabs) "\\\\midrule" else "\\\\hline"),
#' linesep = if (booktabs) c("","", "", "", "\\\\addlinespace") else "\\\\hline",
#'  caption.short = "",equation.envir = if (!is.null(caption)) "equation",...)
#' @inheritParams knitr::kable
#' @inheritParams kableExtra::kbl
#' @inheritParams eviews_wfcreate
#' @param equation_range A vector of characters specifying the equation range of rows and columns
#' @param equation_name Name of an `EViews` equation object in an `EViews` workfile
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#' demo(exec_commands)
#'
#' import_equation(wf="EviewsR_exec_commands",page="page",equation_name="EviewsROLS",format="pandoc")
#'}
#' @family important functions
#' @keywords documentation
#' @export
import_equation=function(wf="",page="*",equation="*"){

chunkName=opts_current$get('label')

    envName=chunkName %n% "eviews" %>% gsub("[._-]","",.)


    # chunkName1=paste0(chunkName,'-') %>%
    # shQuote_cmd() %>% paste0('%chunkName=',.)

  if(!identical(envName,"eviews")) assign(envName,new.env(),envir=knit_global())
  if(identical(envName,"eviews")){
    if(!exists("eviews") || !is.environment(eviews)) assign(envName,new.env(),envir=globalenv())
  }



    fileName=basename(tempfile("EVIEWS", ".", ".prg"))

    fileName=tempfile("EVIEWS", ".", ".prg")
    eviewsrText=gsub("\\.prg$",'',fileName) %>% basename
    eviewsrText1=eviewsrText
    eviewsrText %<>%
      shQuote_cmd %>% paste0('%eviewsrText=',.)



  # file_name=equation_name

  wf=paste0('%wf=',shQuote_cmd(wf))
  page=paste0('%page=',shQuote_cmd(page))
  equation=paste0('%equation=',shQuote_cmd(equation))


  saveCode=r'(open {%wf}



  %pagelist=@pagelist

  if %page<>"*" then
   %pagelist=%page
  endif


  %equationPath=""

  for %page {%pagelist}
  pageselect {%page}
  %equation1=@wlookup(%equation,"equation")

  if @wcount(%equation1)<>0 then
  for %y {%equation1}
  table {%y}_table_{%eviewsrText}

  %equationMembers="aic df coefs  dw f fprob hq logl meandep ncoef pval r2 rbar2 regobs schwarz sddep se ssr stderrs tstats"

  scalar n=@wcount(%equationMembers)
  for !j =1 to n
  %x{!j}=@word(%equationMembers,{!j})
  {%y}_table_{%eviewsrText}(1,!j)=%x{!j}

  %vectors="coefs pval stderrs tstats"
  if @wcount(@wintersect(%x{!j},%vectors))>0 then
  !eqCoef={%y}.@ncoef
  for !i= 2 to !eqCoef+1
  {%y}_table_{%eviewsrText}(!i,!j)={%y}.@{%x{!j}}(!i-1)
  next
  else
  {%y}_table_{%eviewsrText}(2,!j)={%y}.@{%x{!j}}
  endif
  next

  %equationPath=%equationPath+" "+%page+"_"+%y+"-"+%eviewsrText
  {%y}_table_{%eviewsrText}.save(t=csv) {%page}_{%y}-{%eviewsrText}

  next

  endif
  next

  text {%eviewsrText}_equation
  {%eviewsrText}_equation.append {%equationPath}
  {%eviewsrText}_equation.save {%eviewsrText}-equation

  exit
  )'



  on.exit(unlink_eviews(),add = TRUE)


  eviewsCode=paste0(c(eviews_path(),eviewsrText,wf,page,equation,saveCode),collapse = '\n')


writeLines(c(eviewsCode,saveCode),fileName)

system_exec()

  if(file.exists(paste0(eviewsrText1,"-equation.txt"))) equationPath=readLines(paste0(eviewsrText1,"-equation.txt")) %>%
    strsplit(split=" ") %>% unlist()

for (i in equationPath){
  eviewsVectors=c('coefs', 'pval', 'stderrs', 'tstats')
  equationDataframe=read.csv(paste0(i,".csv"))
  equationVectors=equationDataframe[eviewsVectors]
  equationScalars=equationDataframe[!colnames(equationDataframe) %in% eviewsVectors] %>%
    na.omit
  equationList=c(equationScalars,equationVectors)
  equationName=gsub("\\-.*","",i) %>% tolower
  assign(equationName,equationList,envir = get(envName,envir = parent.frame()))
  }

on.exit(unlink(paste0(equationPath,".csv")),add = TRUE)
on.exit(unlink(paste0(eviewsrText1,"-equation.txt")),add = TRUE)

    }
