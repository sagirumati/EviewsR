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
#' @examples knitr::knit_engines$set(dynare = EviewsR::eng_eviews)
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
  # create a temporary file
  f <-tempfile("prg", '.', paste('.', "prg", sep = '')) # prg is file extension of Eviews program
  on.exit(unlink(f)) # cleanup temp file on function exit
  writeLines(c("%path=@runpath","cd %path",options$code,"exit"), f)
  out <- ''

  # if eval != FALSE compile/run the code, preserving output

  if (options$eval) {
    out <- shell(sprintf('%s',paste(f, options$engine.opts)))
  }

  # spit back stuff to the user

  knitr::engine_output(options, options$code, out)
}
.onLoad<-function(libname,pkgname){
  knitr::knit_engines$set(eviews=eng_eviews)
}
