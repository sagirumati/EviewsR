#' Import `EViews` equation data members into R, R Markdown or Quarto.
#'
#' Use this function to import `EViews` equation data members into R, R Markdown or Quarto.
#'
#' @inheritParams eviews_graph
#' @param equation Name(s) or wildcard expressions for `EViews` equation object(s) in an `EViews` workfile
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#' demo(exec_commands)
#'
#' import_equation(wf="exec_commands",page="eviewsPage",equation="OLS")
#'
#' # To access the data members in base R
#'
#' eviews$eviewspage_ols
#'
#' # To obtain R-squared value in base R
#'
#' eviews$eviewspage_ols$r2
#'
#' # To get the values above in R Markdown or Quarto
#'
#' chunkLabel$eviewspage_ols
#'
#' chunkLabel$eviewspage_ols$r2
#'}
#' @family important functions
#' @keywords documentation
#' @export
import_equation=function(wf="",page="*",equation="*"){

chunkLabel=opts_current$get('label')

    envName=chunkLabel %n% "eviews" %>% gsub("^fig-","",.) %>% gsub("[._-]","",.)


  if(!identical(envName,"eviews")) assign(envName,new.env(),envir=knit_global())
  # if(identical(envName,"eviews")){
  #   if(!exists("eviews") || !is.environment(eviews)) assign(envName,new.env())
  # }



    fileName=basename(tempfile("EVIEWS", ".", ".prg"))

    fileName=tempfile("EVIEWS", ".", ".prg")
    eviewsrText=gsub("\\.prg$",'',fileName) %>% basename
    eviewsrText1=eviewsrText
    eviewsrText %<>%
      shQuote_cmd %>% paste0('%eviewsrText=',.)




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
