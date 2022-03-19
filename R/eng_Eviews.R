#' EviewsR: A Seamless Integration of R and EViews
#'
#' The \code{EViews} engine can be activated via
#'
#' ```
#' knitr::knit_engines$set(eviews = EviewsR::eng_eviews)
#' ```
#'
#' This will be set within an R Markdown document's setup chunk.
#'
#' @description This package runs on top of knitr to facilitate communication with EViews. Run EViews scripts from R Markdown document.
#' @usage eng_eviews(options)
#' @param options Chunk options, as provided by \code{knitr} during chunk execution. Chunk option for this is \code{eviews}
#' @return Set of \code{EViews} codes
#' @author Sagiru Mati, ORCID: 0000-0003-1413-3974, https://smati.com.ng
#' * Yusuf Maitama Sule (Northwest) University Kano, Nigeria
#' * SMATI Academy
#' @examples knitr::knit_engines$set(eviews = EviewsR::eng_eviews)
#' library(EviewsR)
#' @references Bob Rudis (2015).Running Go language chunks in R Markdown (Rmd) files. Available at:  https://gist.github.com/hrbrmstr/9accf90e63d852337cb7
#'
#' Yihui Xie (2019). knitr: A General-Purpose Package for Dynamic Report Generation in R. R package version 1.24.
#'
#' Yihui Xie (2015) Dynamic Documents with R and knitr. 2nd edition. Chapman and Hall/CRC. ISBN 978-1498716963
#'
#' Yihui Xie (2014) knitr: A Comprehensive Tool for Reproducible Research in R. In Victoria Stodden, Friedrich Leisch and Roger D. Peng, editors, Implementing Reproducible Computational Research. Chapman and Hall/CRC. ISBN 978-1466561595
#'
#' @seealso  eviews_wfcreate
#' @keywords documentation
#' @export
eng_eviews <- function(options) {

  save_path=paste0("EviewsR_files/",options$label)
  save_path1=save_path
  if(!exists(save_path)) dir.create(save_path,recursive = T)
  save_path=paste0("%save_path=",shQuote(save_path))
  # dir.create(save_path)
  # dir.create(options$label)
  # create a temporary file
  fileName <-tempfile("EviewsR", '.', ".prg") # prg is file extension of Eviews program

  save_code=r'(
  %graphs=@wlookup("*","graph")
if @wcount(%graphs)<>0 then
  for %y {%graphs}
  {%y}.save(t=png,d=300) {%eviews_path}\{%save_path}\{%y}
  next
endif




  %equation=@wlookup("*","equation")

  if @wcount(%equation)<>0 then
  for %y {%equation}
  table {%y}_table

  %equationMembers="aic df coefs  dw f fprob hq logl meandep ncoef pval r2 rbar2 regobs schwarz sddep se ssr stderrs tstats"

  scalar n=@wcount(%equationMembers)
  for !j =1 to n
  %x{!j}=@word(%equationMembers,{!j})
  {%y}_table(1,!j)=%x{!j}

  %vectors="coefs pval stderrs tstats"
  if @wcount(@wintersect(%x{!j},%vectors))>0 then
  !eqCoef={%y}.@ncoef
  for !i= 2 to !eqCoef+1 'first row for the header
  {%y}_table(!i,!j)={%y}.@{%x{!j}}(!i-1)
  next
  else
  {%y}_table(2,!j)={%y}.@{%x{!j}}
  endif
  next

  {%y}_table.save(t=csv) {%eviews_path}\{%save_path}\{%y}

  next

  endif

  exit
  )'
  writeLines(c(eviews_path(),save_path,options$code,save_code), fileName)



 if (options$eval) system_exec()
  if(!exists("eviews") || !is.environment(eviews)) eviews<<-new.env()

  equations=list.files(save_path1,".csv")

  equations=gsub(".csv","",equations)
  for (i in equations){
     assign(i,read.csv(paste0(save_path1,"/",i,".csv")),envir = eviews)
    }

  on.exit(unlink(paste0(save_path1,"/",equations,".csv")),add = TRUE)
   on.exit(unlink_eviews(),add = TRUE)
  }
