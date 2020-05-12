
eng_Eviews <- function(options) {
  # create a temporary file
  f <-tempfile("prg", '.', paste('.', "prg", sep = ''))
  on.exit(unlink(f)) # cleanup temp file on function exit
  writeLines(options$code, f)
  out <- ''

  # if eval != FALSE compile/run the code, preserving output

  if (options$eval) {
    out <- shell(sprintf('%s',paste(f, options$engine.opts)))
  }

  # spit back stuff to the user

  knitr::engine_output(options, options$code, out)
}
.onLoad<-function(libname,pkgname){
  knitr::knit_engines$set(eviews=eng_Eviews)
}
