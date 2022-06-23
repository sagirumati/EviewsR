#' EviewsR: A Seamless Integration of R and EViews
#'
#' The \code{EViews} engine can be activated via
#'
#' ```
#' knitr::knit_engines$set(eviews = eviewsR::eng_eviews)
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
#' @family important functions
#' @export
eng_eviews <- function(options) {

  if (!is.null(options$template)) template=template %>% shQuote_cmd() %>%  paste0('%template=',.)


  graphicsDefault=r'(if @wcount(%figKeep)>0 then
  for %y {%figKeep}
  {%y}.axis(l) font(Calibri,14,-b,-i,-u,-s)
  {%y}.axis(r) font(Calibri,14,-b,-i,-u,-s)
  {%y}.axis(b) font(Calibri,14,-b,-i,-u,-s)
  {%y}.axis(t) font(Calibri,14,-b,-i,-u,-s)
  {%y}.legend columns(5) inbox position(BOTCENTER) font(Calibri,12,-b,-i,-u,-s)
  {%y}.options antialias(on)
  {%y}.options size(6,3)
  {%y}.options -background frameaxes(all) framewidth(0.5)
  {%y}.setelem(1) linecolor(@rgb(57,106,177)) linewidth(1.5)
  {%y}.setelem(2) linecolor(@rgb(218,124,48)) linewidth(1.5)
  {%y}.setelem(3) linecolor(@rgb(62,150,81)) linewidth(1.5)
  {%y}.setelem(4) linecolor(@rgb(204,37,41)) linewidth(1.5)
  {%y}.setelem(5) linecolor(@rgb(83,81,84)) linewidth(1.5)
  {%y}.setelem(6) linecolor(@rgb(107,76,154)) linewidth(1.5)
  {%y}.setelem(7) linecolor(@rgb(146,36,40)) linewidth(1.5)
  {%y}.setelem(8) linecolor(@rgb(148,139,61)) linewidth(1.5)
  {%y}.setelem(9) linecolor(@rgb(255,0,255)) linewidth(1.5)
  {%y}.setelem(10) linewidth(1.5)
  {%y}.setelem(11) linecolor(@rgb(192,192,192)) linewidth(1.5)
  {%y}.setelem(12) linecolor(@rgb(0,255,255)) linewidth(1.5)
  {%y}.setelem(13) linecolor(@rgb(255,255,0)) linewidth(1.5)
  {%y}.setelem(14) linecolor(@rgb(0,0,255)) linewidth(1.5)
  {%y}.setelem(15) linecolor(@rgb(255,0,0)) linewidth(1.5)
  {%y}.setelem(16) linecolor(@rgb(0,127,0)) linewidth(1.5)
  {%y}.setelem(17) linecolor(@rgb(0,0,0)) linewidth(1.5)
  {%y}.setelem(18) linecolor(@rgb(0,127,127)) linewidth(1.5)
  {%y}.setelem(19) linecolor(@rgb(127,0,127)) linewidth(1.5)
  {%y}.setelem(20) linecolor(@rgb(127,127,0)) linewidth(1.5)
  {%y}.setelem(21) linecolor(@rgb(0,0,127)) linewidth(1.5)
  {%y}.setelem(22) linecolor(@rgb(255,0,255)) linewidth(1.5)
  {%y}.setelem(23) linecolor(@rgb(127,127,127)) linewidth(1.5)
  {%y}.setelem(24) linecolor(@rgb(192,192,192)) linewidth(1.5)
  {%y}.setelem(25) linecolor(@rgb(0,255,255)) linewidth(1.5)
  {%y}.setelem(26) linecolor(@rgb(255,255,0)) linewidth(1.5)
  {%y}.setelem(27) linecolor(@rgb(0,0,255)) linewidth(1.5)
  {%y}.setelem(28) linecolor(@rgb(255,0,0)) linewidth(1.5)
  {%y}.setelem(29) linecolor(@rgb(0,127,0)) linewidth(1.5)
  {%y}.setelem(30) linecolor(@rgb(0,0,0)) linewidth(1.5)
  {%y}.setfont legend(Calibri,12,-b,-i,-u,-s) text(Calibri,14,-b,-i,-u,-s) obs(Calibri,14,-b,-i,-u,-s) axis(Calibri,14,-b,-i,-u,-s)
  {%y}.setfont obs(Calibri,14,-b,-i,-u,-s)
  {%y}.textdefault font(Calibri,14,-b,-i,-u,-s)
  next
  endif)'

  if (!is.null(options$graph_procs)){
    graph_procs=options$graph_procs
  graph_procs=paste0("{%y}.",graph_procs)

if(!options$page)  graph_procs=append(c('if @wcount(%figKeep)>0 then','for %y {%figKeep}')
                     ,c(graph_procs,'next','endif'))
  if(options$page)   graph_procs=append(c('if @wcount(%figKeep)>0 then','for %page {%pagelist}','pageselect {%page}','for %y {%figKeep}')
                                        ,c(graph_procs,'next','next','endif'))

  }else graph_procs=""



  chunk_name=options$label
  # chunk_name1=paste0(chunk_name,'_') %>% gsub("[.,-]","_",.) %>%
  #   shQuote_cmd() %>% paste0('%chunk_name=',.)

  chunk_name1=paste0(chunk_name,'-') %>%
    shQuote_cmd() %>% paste0('%chunk_name=',.)


  eviewsr_text=tempfile("eviewsr_text",".") %>%
    basename
  eviewsr_text1=eviewsr_text

  eviewsr_text %<>%   shQuote_cmd %>%
    paste0("%eviewsr_text=",.)

    if(options$dev=="png" && is.null(options$save_options)) save_options="t=png,d=300"
  if(options$dev=="pdf" && is.null(options$save_options)) save_options="t=pdf"
if(!is.null(options$save_options)) save_options=paste(options$save_options,collapse = ",")

  save_options2=save_options

  save_options=paste0('%save_options=',shQuote_cmd(save_options))


  # save_path=paste0("EviewsR_files")
  # if(opts_current$get("fig.path")=="") save_path="" else save_path=paste0(save_path,'/',options$fig.path)
  save_path=opts_current$get("fig.path")
  # save_path=gsub("[.,-]","_",save_path)
  save_path1=ifelse(save_path=="",".",save_path)
  if(save_path!="" && !dir.exists(save_path)) dir.create(save_path,recursive = T)
  save_path=paste0("%save_path=",shQuote_cmd(save_path))
  # dir.create(save_path)
  # dir.create(options$label)
  # create a temporary file

  fileName <-tempfile("EviewsR", '.', ".prg") # prg is file extension of Eviews program


if(!options$page) figSave=r'(if %save_path<>"" then
  %save_path=%save_path+"\"
  endif

  if @wcount(%figKeep)<>0 then
  for %y {%figKeep}
  {%y}.save({%save_options}) {%eviews_path}\{%save_path}{%chunk_name}{%y}
  next
  endif
  text {%eviewsr_text}
    {%eviewsr_text}.append {%figkeep}
  {%eviewsr_text}.save {%eviewsr_text}
  )'


# PAGE


  if(options$fig.keep=="new" && options$page)  {
    figSave=r'(if %save_path<>"" then
    %save_path=%save_path+"\"
    endif

    text {%eviewsr_text}
    {%eviewsr_text}.append {%figpath}
    {%eviewsr_text}.save {%eviewsr_text}

    %pagelist=@pagelist

    for %page {%pagelist}
    pageselect {%page}


    %figKeep=@wlookup("*","graph")

    if @wcount(%figKeep)<>0 then
    for %y {%figKeep}
    '%figPath=%figPath+" "+%chunk_name+%page+"-"+%y
    {%y}.save({%save_options}) {%eviews_path}\{%save_path}{%chunk_name}{%page}-{%y}
    next
    endif

    next
    )'
  }


if(options$fig.keep!="new" && options$page)  {
  figSave=r'(if %save_path<>"" then
  %save_path=%save_path+"\"
  endif
  '
  '%figKeep="left" %figKeep=@wleft(%figKeep,1)
  '%figKeep="right" %figKeep=@wright(%figKeep,1)

 %figPath=""

  %pagelist=@pagelist

  for %page {%pagelist}
  pageselect {%page}


  %figKeep=@wlookup("*","graph")

  if @wcount(%figKeep)<>0 then
  for %y {%figKeep}
  %figPath=%figPath+" "+%chunk_name+%page+"-"+%y
  {%y}.save({%save_options}) {%eviews_path}\{%save_path}{%chunk_name}{%page}-{%y}
  next
  endif

next

  %figPath=@wunique(%figPath)


  text {%eviewsr_text}
  {%eviewsr_text}.append {%figpath}
  {%eviewsr_text}.save {%eviewsr_text}

  )'
}

  if(options$fig.keep=="high" || options$fig.keep=="all") figKeep='%figKeep="all"'
  if(options$fig.keep=="left") figKeep='%figKeep="left"'
  if(options$fig.keep=="right") figKeep='%figKeep="right"'
   if(options$fig.keep=="new") figKeep=""
  if(options$fig.keep=="none") figSave="" else figSave=append(figKeep,figSave)


if(options$page){  saveCode=r'(

%tablePath=""

  %pagelist=@pagelist

'%tablePath=""

  for %page {%pagelist}
  pageselect {%page}
  %tables=@wlookup("*" ,"table")

  if @wcount(%tables)<>0 then
  for %y {%tables}
  'table {%page}_{%y}
  %tablePath=%tablePath+" "+%page+"_"+%y+"_"+"eviewsr_table"
  {%y}.save(t=csv) {%eviews_path}\{%save_path}{%page}_{%y}_eviewsr_table
  next
  endif

  text eviewsr_table_text
  eviewsr_table_text.append {%tablePath}
  eviewsr_table_text.save eviewsr_table_text

  next



  for %page {%pagelist}
  pageselect {%page}
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
  for !i= 2 to !eqCoef+1
  {%y}_table(!i,!j)={%y}.@{%x{!j}}(!i-1)
  next
  else
  {%y}_table(2,!j)={%y}.@{%x{!j}}
  endif
  next

  {%y}_table.save(t=csv) {%eviews_path}\{%save_path}{%page}_{%y}_equation_table

  next

  endif
  next

  wfsave all_eviewsr_series.csv @drop date

  exit
  )'
}



  if(!options$page){
    saveCode=r'(


  %tablePath=""

  %tables=@wlookup("*" ,"table")

  if @wcount(%tables)<>0 then
  for %y {%tables}
  'table {%y}
  %tablePath=%tablePath+" "+%y+"_"+"eviewsr_table"
  {%y}.save(t=csv) {%eviews_path}\{%save_path}{%y}_eviewsr_table
  next
  endif

  text eviewsr_table_text
  eviewsr_table_text.append {%tablePath}
  eviewsr_table_text.save eviewsr_table_text




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
  for !i= 2 to !eqCoef+1
  {%y}_table(!i,!j)={%y}.@{%x{!j}}(!i-1)
  next
  else
  {%y}_table(2,!j)={%y}.@{%x{!j}}
  endif
  next

  {%y}_table.save(t=csv) {%eviews_path}\{%save_path}{%y}_equation_table

  next

  endif

  wfsave all_eviewsr_series.csv @drop date

  exit
  )'
  }


# series=r'(%series=@wlookup("*","series")
#
# wfsave all_eviewsr_series.csv @drop date
#   {%series}
#   )'

  eviewsCode=paste0(c(eviews_path(),eviewsr_text,chunk_name1,save_path,options$code,graphicsDefault,graph_procs,save_options,figSave,saveCode), collapse = "\n") %>%
    strsplit(split="\n") %>% unlist()

  # writeLines(eviewsCode,fileName)

  # eviewsCode=readLines(fileName)

if(options$fig.keep=="new" && !options$page){
    eviewsCode1=grep("^(\\s*freeze|\\s*graph)",eviewsCode) %>% rev()

  appendCode=c('%newgraph=@wlookup("*","graph")','%newgraph=@wdrop(%newgraph,%existing)'
,'%existing=@wlookup("*","graph")','%figKeep=%figKeep+" "+%newgraph','%figKeep=@wunique(%figKeep)')

 for (i in eviewsCode1) eviewsCode=append(eviewsCode,appendCode,i)

  eviewsCode=append(eviewsCode,'%existing=@wlookup("*","graph")',tail(eviewsCode1,1)-1)
} else eviewsCode=eviewsCode



  if(options$fig.keep=="new" && options$page){
    eviewsCode1=grep("^(\\s*freeze|\\s*graph)",eviewsCode) %>% rev()

    appendCode=c('%currentpage=@pagename','%newgraph=@wlookup("*","graph")','%newgraph=@wdrop(%newgraph,%existing)'
                 ,'%existing=@wlookup("*","graph")','%figPath=%figPath+" "+%chunk_name+%currentpage+"-"+%newgraph')

    for (i in eviewsCode1) eviewsCode=append(eviewsCode,appendCode,i)

    eviewsCode=append(eviewsCode,'%existing=@wlookup("*","graph")',tail(eviewsCode1,1)-1)
  } else eviewsCode=eviewsCode

  writeLines(eviewsCode,fileName)

 if (options$eval){
   system_exec()

  equations=list.files(save_path1,"_equation_table\\.csv$")

  equations=gsub("_equation_table\\.csv","",equations)

  # if(!exists("eviews") || !is.environment(eviews)) eviews<<-new.env()

envName=chunk_name %>% gsub("[._-]","",.)
assign(envName,new.env(),envir=knit_global())

if(length(equations)!=0){
  for (i in equations){

    assign(i,read.csv(paste0(save_path1,"/",i,"_equation_table.csv")),envir = get(envName))

  }
}


  tables=list.files(save_path1,"_eviewsr_table\\.csv$")

  tables=gsub("_eviewsr_table\\.csv","",tables)


if(length(tables)!=0){
  for (i in tables){

    assign(i,read.csv(paste0(save_path1,"/",i,"_eviewsr_table.csv")),envir = get(envName))
  }
}


  if(file.exists('all_eviewsr_series.csv')){
  dataFrame=read.csv('all_eviewsr_series.csv')
  if(grepl('date',colnames(dataFrame)[1])){
  colnames(dataFrame)[1]="date"
  dataFrame$date=as.POSIXct(dataFrame$date)
  }
    assign("series",dataFrame,envir =get(envName))
  }

    on.exit(unlink(paste0(save_path1,"/",equations,"_equation_table.csv")),add = TRUE)
   on.exit(unlink(paste0(save_path1,"/",tables,"_eviewsr_table.csv")),add = TRUE)

  }

   on.exit(unlink_eviews(),add = TRUE)
   # on.exit(unlink(paste0(eviewsr_text1,".txt")),add = TRUE)



   save_options1=c("t=bmp","t=gif", "t=jpg", "t=png")

   if(length(intersect(save_options,save_options1)>0)){
     if(intersect(save_options,save_options1) %in% save_options1 & sum(grepl("d=",save_options, ignore.case = T))==0) save_options=append(save_options,"d=300")
   }

   save_options2=paste0(save_options2,collapse=",") %>% trimws() %>%  gsub('[[:blank:]]','',.) %>% strsplit(split=",") %>% unlist()

   extensions= c("t=emf", "t=wmf", "t=eps", "t=bmp", "t=gif", "jpg", "t=png", "t=pdf", "t=tex", "md")

   extension=intersect(extensions,save_options2) %>% gsub('t=','',.)

   if(length(extension)==0) extension="emf"

   eviews_graphics=c()

   eviewsGraphics=readLines(paste0(eviewsr_text1,'.txt')) %>%
     strsplit(split=" ") %>%
     unlist


   # chunk_name2=paste0(chunk_name,'_') %>% gsub("[.,-]","_",.)

   chunk_name2=paste0(chunk_name,'-')

   if(!options$page) for (i in eviewsGraphics) eviews_graphics=append(eviews_graphics,list.files(pattern=paste0("^",chunk_name2,".*",i,"\\.",extension,"$"),path=save_path1,ignore.case = T))
   if(!options$page) for (i in eviewsGraphics) eviews_graphics=append(eviews_graphics,list.files(pattern=paste0("^",i,"\\.",extension,"$"),path=save_path1,ignore.case = T))
   if(options$page) for (i in eviewsGraphics) eviews_graphics=append(eviews_graphics,list.files(pattern=paste0("^",i,"\\.",extension,"$"),path=save_path1,ignore.case = T))

   if(save_path1==".") save_path1="" else save_path1=paste0(save_path1,"/")

   eviews_graphics=paste0(save_path1,eviews_graphics)

# include_graphics(eviews_graphics)

 code=engine_output(options,code = options$code, out = "")
 if(all(save_path1!=eviews_graphics)) output=list(knitr::include_graphics(eviews_graphics)) else output=list()

 if(opts_current$get('fig.keep')=='none') out="" else  out=engine_output(options,
     out =output
     )



     if(options$echo) return(c(code,out)) else return(c(out))
}


