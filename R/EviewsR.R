
eng_Eviews <- function(options) {
  library(knitr)
  options(warn = -1)
  path=getwd()
  # create a temporary file
  f <-tempfile("prg", '.', paste('.', "prg", sep = ''))
  on.exit(unlink(f)) # cleanup temp file on function exit
  writeLines(options$code, f)
  out <- ''

  # if eval != FALSE compile/run the code, preserving output

  if (options$eval) {
    out <- shell(sprintf('%s/%s',paste(path),paste(f, options$engine.opts)))
  }

  # spit back stuff to the user

  engine_output(options, options$code, out)
}
.onLoad<-function(libname,pkgname){
knitr::knit_engines$set(Eviews=eng_Eviews)
}
