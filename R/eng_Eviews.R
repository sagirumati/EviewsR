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
#' @family important functions
#' @export
eng_eviews <- function(options) {

#
#   options$fig.num=9
   # options$fig.cap='sagiru mati gabasawa'

   # writeLines(paste(options$label,options$fig.subcap,options$fig.align,options$fig.cap),paste0(options$label,'text.txt'))

      if (is.null(options$eval)) options$eval=opts_chunk$get("eval")
    if (is.null(options$page)) options$page=opts_chunk$get("page") %n% TRUE
    if (is.null(options$fig.ncol)) options$fig.ncol=opts_chunk$get("fig.ncol") %n% 2

    # if (is.null(options$echo)) options$echo=opts_chunk$get("echo")
    # if (!is.null(options$eval))options$template=opts_current$get("template")


  # if (!is.null(options$template)) template %<>% shQuote_cmd %>%  paste0('%template=',.)

    eviewsVectors=c('coefs', 'pval', 'stderrs', 'tstats')

  if (options$eval){

   if(is.character(options$page)){

     pageList=paste(options$page,collapse = " ") %>% trimws

     pageList1=pageList %>%   strsplit(split=" ") %>% unlist()

     pageList %<>% shQuote_cmd %>% paste0('%pagelist1=',.)

     options$page=TRUE
   } else pageList='%pagelist1=""'

   graphicsDefault=r'(

   %pagelist=@pagelist

%activePage=@pagename

   if %pagelist1<>"" then
   %pagelist=%pagelist1
   endif

   if %pagelist1="" then
   %pagelist=%activePage
   endif

   for %page {%pagelist}
   pageselect {%page}


   if %figKeep1="first" then
   %figKeep=@wlookup("*","graph")
   %figKeep=@wleft(%figKeep,1)
   endif

   if %figKeep1="last" then
   %figKeep=@wlookup("*","graph")
   %figKeep=@wright(%figKeep,1)
   endif

   if %figKeep1="all" then
   %figKeep=@wlookup("*","graph")
   endif

   if %figKeep1="none" then
   %figKeep=""
   endif

   if %figKeep1="" then
   %figKeep=@wlookup("*","graph")
   endif


   if @wcount(%figKeep)>0 then
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
   endif
   next
   )'

   if (!is.null(options$graph_procs)){
     graph_procs=options$graph_procs
     graph_procs=paste0("{%y}.",graph_procs)

     if(!options$page)  graph_procs=append(c('if @wcount(%figKeep)>0 then','for %y {%figKeep}')
                                           ,c(graph_procs,'next','endif'))
     if(options$page)   graph_procs=append(c('%pagelist=@pagelist','if %pagelist1<>"" then','%pagelist=%pagelist1','endif','for %page {%pagelist}','pageselect {%page}','if %figKeep1="first" then
                                          %figKeep=@wlookup("*","graph")
                                          %figKeep=@wleft(%figKeep,1)
                                        endif

                                        if %figKeep1="last" then
                                        %figKeep=@wlookup("*","graph")
                                        %figKeep=@wright(%figKeep,1)
  endif

  if %figKeep1="all" then
  %figKeep=@wlookup("*","graph")
  endif

  if %figKeep1="none" then
  %figKeep=""
  endif

  if %figKeep1="" then
  %figKeep=@wlookup("*","graph")
  endif'
  ,'if @wcount(%figKeep)>0 then','for %y {%figKeep}')
  ,c(graph_procs,'next','endif','next'))

   }else graph_procs=""



   chunkName=options$label
   # chunkName1=paste0(chunkName,'_') %>% gsub("[.,-]","_",.) %>%
   #   shQuote_cmd() %>% paste0('%chunkName=',.)

   chunkName1=paste0(chunkName,'-') %>%
     shQuote_cmd() %>% paste0('%chunkName=',.)


   eviewsrText=tempfile("eviewsrText",".") %>%
     basename
   eviewsrText1=eviewsrText

   eviewsrText %<>%   shQuote_cmd %>%
     paste0("%eviewsrText=",.)

   if(options$dev=="png" && is.null(options$save_options)) save_options="t=png,d=300"
   if(options$dev=="pdf" && is.null(options$save_options)) save_options="t=pdf"
   if(!is.null(options$save_options)) save_options=paste(options$save_options,collapse = ",")

   save_options2=save_options

   save_options=paste0('%save_options=',shQuote_cmd(save_options))


   # save_path=paste0("EviewsR_files")
   save_path=''
   save_path=opts_current$get("fig.path")
   if(identical(getwd() %>% basename,'vignettes')) {
     save_path=tempfile('EviewsR',".") %>% basename
     tempDir=save_path
     on.exit(unlink(tempDir,recursive = TRUE),add = TRUE)
   }
   # if(opts_current$get("fig.path")=="") save_path="" else save_path=paste0(save_path,'/',options$fig.path)
   # save_path=opts_current$get("fig.path") %n% save_path
   # if(grepl('AppData/Local/Temp',save_path)) save_path="EviewsR_files"
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

   if %figKeep1="first" then
   %figKeep=@wlookup("*","graph")
   %figKeep=@wleft(%figKeep,1)
   endif

   if %figKeep1="last" then
   %figKeep=@wlookup("*","graph")
   %figKeep=@wright(%figKeep,1)
   endif

   if %figKeep1="all" then
   %figKeep=@wlookup("*","graph")
   endif

   if %figKeep1="none" then
   %figKeep=""
   endif

   %figpath=""

   if @wcount(%figKeep)<>0 then
   for %y {%figKeep}
   {%y}.save({%save_options}) {%eviews_path}\{%save_path}{%chunkName}{%y}
   %figpath=%figpath+" "+%chunkName+%y
   next
   endif



   text {%eviewsrText}_graph
   {%eviewsrText}_graph.append {%figpath}
   {%eviewsrText}_graph.save {%eviewsrText}-graph

  ' text {%eviewsrText}
   '{%eviewsrText}.append {%figpath}
  ' {%eviewsrText}.save {%eviewsrText}
   )'


   # PAGE


   if(any(options$fig.keep=="new") && options$page)  {
     figSave=r'(if %save_path<>"" then
     %save_path=%save_path+"\"
     endif

     text {%eviewsrText}_graph
     {%eviewsrText}_graph.append {%figpath}
     {%eviewsrText}_graph.save {%eviewsrText}-graph

     %pagelist=@pagelist

     if %pagelist1<>"" then
     %pagelist=%pagelist1
     endif

     for %page {%pagelist}
     pageselect {%page}


     %figKeep=@wlookup("*","graph")

     if @wcount(%figKeep)<>0 then
     for %y {%figKeep}
     '%figPath=%figPath+" "+%chunkName+%page+"-"+%y
     {%y}.save({%save_options}) {%eviews_path}\{%save_path}{%chunkName}{%page}-{%y}
     next
     endif

     next
     )'
   }


   if(any(options$fig.keep!="new") && options$page)  {
     figSave=r'(if %save_path<>"" then
     %save_path=%save_path+"\"
     endif

     %figPath=""

     %pagelist=@pagelist

     if %pagelist1<>"" then
     %pagelist=%pagelist1
     endif

     for %page {%pagelist}
     pageselect {%page}


     if %figKeep1="first" then
     %figKeep=@wlookup("*","graph")
     %figKeep=@wleft(%figKeep,1)
     endif

     if %figKeep1="last" then
     %figKeep=@wlookup("*","graph")
     %figKeep=@wright(%figKeep,1)
     endif

     if %figKeep1="all" then
     %figKeep=@wlookup("*","graph")
     endif

     if %figKeep1="none" then
     %figKeep=""
     endif




     if @wcount(%figKeep)<>0 then
     for %y {%figKeep}
     %figPath=%figPath+" "+%chunkName+%page+"-"+%y
     {%y}.save({%save_options}) {%eviews_path}\{%save_path}{%chunkName}{%page}-{%y}
     next
     endif

     next

     %figPath=@wunique(%figPath)


     text {%eviewsrText}_graph
     {%eviewsrText}_graph.append {%figpath}
     {%eviewsrText}_graph.save {%eviewsrText}-graph

     )'
   }

   if(any(options$fig.keep %in% c("high","all","*","desc")) || is.numeric(options$fig.keep)) figKeep='%figKeep1="all"'
   if(any(options$fig.keep=="first")) figKeep='%figKeep1="first"'
   if(any(options$fig.keep=="last")) figKeep='%figKeep1="last"'
   if(any(options$fig.keep=="new")) figKeep='%figKeep1=""'
   if(any(options$fig.keep=="none")) figKeep='%figKeep1="none"'

   # figSave=append(figKeep,figSave)


   if(options$page){  saveCode=r'(

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
   {%y}.save(t=csv) {%eviews_path}\{%save_path}{%page}_{%y}-{%eviewsrText}
   next
   endif

   text {%eviewsrText}_table
   {%eviewsrText}_table.append {%tablePath}
   {%eviewsrText}_table.save {%eviewsrText}-table

   next


   %equationPath=""

   for %page {%pagelist}
   pageselect {%page}
   %equation=@wlookup("*","equation")

   if @wcount(%equation)<>0 then
   for %y {%equation}
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
   {%y}_table_{%eviewsrText}.save(t=csv) {%eviews_path}\{%save_path}{%page}_{%y}-{%eviewsrText}

   next

   endif
   next

   text {%eviewsrText}_equation
   {%eviewsrText}_equation.append {%equationPath}
   {%eviewsrText}_equation.save {%eviewsrText}-equation


   %seriesPath=""
   for %page {%pagelist}
   pageselect {%page}
   pagesave {%page}-{%chunkName}{%eviewsrText}.csv @drop date
   %seriesPath=%seriesPath+" "+%page+"-"+%chunkName+%eviewsrText
   next

   text {%eviewsrText}_series
   {%eviewsrText}_series.append {%seriesPath}
   {%eviewsrText}_series.save {%eviewsrText}-series
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
     %tablePath=%tablePath+" "+%y+"-"+%eviewsrText
     {%y}.save(t=csv) {%eviews_path}\{%save_path}{%y}-{%eviewsrText}
     next
     endif

     text {%eviewsrText}_table
     {%eviewsrText}_table.append {%tablePath}
     {%eviewsrText}_table.save {%eviewsrText}-table



     %equationPath=""

     %equation=@wlookup("*","equation")

     if @wcount(%equation)<>0 then
     for %y {%equation}
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

     %equationPath=%equationPath+%y+"-"+%eviewsrText
     {%y}_table_{%eviewsrText}.save(t=csv) {%eviews_path}\{%save_path}{%y}-{%eviewsrText}

     next

     endif

     text {%eviewsrText}_equation
     {%eviewsrText}_equation.append {%equationPath}
     {%eviewsrText}_equation.save {%eviewsrText}-equation


     %currentPage=@pagename
     pagesave {%currentPage}-{%chunkName}{%eviewsrText}.csv @drop date

     %seriesPath=%currentPage+"-"+%chunkName+%eviewsrText
     text {%eviewsrText}_series
     {%eviewsrText}_series.append {%seriesPath}
     {%eviewsrText}_series.save {%eviewsrText}-series

     exit
     )'
   }


   # series=r'(%series=@wlookup("*","series")
   #
   # wfsave all_eviewsr_series.csv @drop date
   #   {%series}
   #   )'

   eviewsCode=paste0(c(eviews_path(),pageList,figKeep,eviewsrText,chunkName1,save_path,options$code,save_options,graphicsDefault,graph_procs,figSave,saveCode), collapse = "\n") %>%
     strsplit(split="\n") %>% unlist()

   # writeLines(eviewsCode,fileName)

   # eviewsCode=readLines(fileName)

   if(any(options$fig.keep=="new") && !options$page){
     eviewsCode1=grep("^(\\s*freeze|\\s*graph)",eviewsCode) %>% rev()

     appendCode=c('%newgraph=@wlookup("*","graph")','%newgraph=@wdrop(%newgraph,%existing)'
                  ,'%existing=@wlookup("*","graph")','if @wcount(%newgraph)>0 then','%figKeep=%figKeep+" "+%newgraph','endif','%figpath=@wunique(%figKeep)')

     for (i in eviewsCode1) eviewsCode=append(eviewsCode,appendCode,i)

     eviewsCode=append(eviewsCode,'%existing=@wlookup("*","graph")',tail(eviewsCode1,1)-1)
   } else eviewsCode=eviewsCode



   if(any(options$fig.keep=="new") && options$page){
     eviewsCode1=grep("^(\\s*freeze|\\s*graph)",eviewsCode) %>% rev()

     appendCode=c('%currentpage=@pagename','%newgraph=@wlookup("*","graph")','%newgraph=@wdrop(%newgraph,%existing)'
                  ,'%existing=@wlookup("*","graph")','if @wcount(%newgraph)>0 then
                 %figPath=%figPath+" "+%chunkName+%currentpage+"-"+%newgraph
                 endif'
     )

     for (i in eviewsCode1) eviewsCode=append(eviewsCode,appendCode,i)

     eviewsCode=append(eviewsCode,'%existing=@wlookup("*","graph")',tail(eviewsCode1,1)-1)
   } else eviewsCode=eviewsCode

   writeLines(eviewsCode,fileName)


   system_exec()

  # equations=list.files(save_path1,"_equation_table\\.csv$")
  #
  # equations=gsub("_equation_table\\.csv","",equations)

  # if(!exists("eviews") || !is.environment(eviews)) eviews<<-new.env()

envName=chunkName %>% gsub("[._-]","",.)
assign(envName,new.env(),envir=knit_global())

# if(length(equations)!=0){
#   for (i in equations){
#
#     assign(i,read.csv(paste0(save_path1,"/",i,"_equation_table.csv")),envir = get(envName))
#
#   }
# }



if(file.exists(paste0(eviewsrText1,"-equation.txt"))) equationPath=readLines(paste0(eviewsrText1,"-equation.txt")) %>%
  strsplit(split=" ") %>% unlist()


#
# for (i in equationPath){
#   equationName=gsub("\\-.*","",i) %>% tolower
#   assign(equationName,read.csv(paste0(save_path1,"/",i,".csv")),envir = get(envName))
# }


for (i in equationPath){
  equationDataframe=read.csv(paste0(save_path1,"/",i,".csv"))
  equationVectors=equationDataframe[eviewsVectors]
  equationScalars=equationDataframe[!colnames(equationDataframe) %in% eviewsVectors] %>%
   na.omit
  equationList=c(equationScalars,equationVectors)
    equationName=gsub("\\-.*","",i) %>% tolower
  assign(equationName,equationList,envir = get(envName))
}


if(file.exists(paste0(eviewsrText1,"-table.txt"))) tablePath=readLines(paste0(eviewsrText1,"-table.txt")) %>%
  strsplit(split=" ") %>% unlist()

  # tables=list.files(save_path1,paste0(eviewsrText1,"\\.csv$"))

  # tables=gsub(paste0(eviewsrText1,"\\.csv"),"",tables)


# if(length(tables)!=0){
  for (i in tablePath){
tableName=gsub("\\-.*","",i) %>% tolower
    assign(tableName,read.csv(paste0(save_path1,"/",i,".csv")),envir = get(envName))
  }
# }


  # if(file.exists('all_eviewsr_series.csv')){
  # dataFrame=read.csv('all_eviewsr_series.csv')
  # if(grepl('date',colnames(dataFrame)[1])){
  # colnames(dataFrame)[1]="date"
  # dataFrame$date=as.POSIXct(dataFrame$date)
  # }
  #   assign("series",dataFrame,envir =get(envName))
  # }




  if(file.exists(paste0(eviewsrText1,'-series.txt'))){
    seriesPath=readLines(paste0(eviewsrText1,'-series.txt')) %>% strsplit(split=" ") %>% unlist()
on.exit(unlink(paste0(seriesPath,".csv")))
    for (i in seriesPath){
      pageName=gsub("\\-.*","",i) %>% tolower
      dataFrame=read.csv(paste0(i,".csv"))
    if(grepl('date',colnames(dataFrame)[1])){
      colnames(dataFrame)[1]="date"
      dataFrame$date=as.POSIXct(dataFrame$date)
    }
    assign(pageName,dataFrame,envir =get(envName))
    }
  }

    on.exit(unlink(paste0(save_path1,"/",equationPath,".csv")),add = TRUE)
   on.exit(unlink(paste0(save_path1,"/",tablePath,".csv")),add = TRUE)
   on.exit(unlink(paste0(save_path1,"/",seriesPath,".csv")),add = TRUE)
# on.exit(unlink(paste0(rep(eviewsrText1,4),c("-graph.txt","-equation.txt","-series.txt","-table.txt"))),add = TRUE)


on.exit(unlink_eviews(),add = TRUE)
# on.exit(unlink(paste0(eviewsrText1,".txt")),add = TRUE)



save_options1=c("t=bmp","t=gif", "t=jpg", "t=png")

if(length(intersect(save_options,save_options1)>0)){
  if(intersect(save_options,save_options1) %in% save_options1 & sum(grepl("d=",save_options, ignore.case = T))==0) save_options=append(save_options,"d=300")
}

save_options2=paste0(save_options2,collapse=",") %>% trimws() %>%  gsub('[[:blank:]]','',.) %>% strsplit(split=",") %>% unlist()

extensions= c("t=emf", "t=wmf", "t=eps", "t=bmp", "t=gif", "t=jpg", "t=png", "t=pdf", "t=tex", "t=md")

extension=intersect(extensions,save_options2) %>% gsub('t=','',.)

if(length(extension)==0) extension="emf"

# eviews_graphics=c()

# eviewsGraphics=readLines(paste0(eviewsrText1,'-graph.txt')) %>%
  # strsplit(split=" ") %>%
  # unlist


# chunkName2=paste0(chunkName,'_') %>% gsub("[.,-]","_",.)

# chunkName2=paste0(chunkName,'-')
#
# if(!options$page) for (i in eviewsGraphics) eviews_graphics=append(eviews_graphics,list.files(pattern=paste0("^",i,"\\.",extension,"$"),path=save_path1,ignore.case = T))
# # if(!options$page) for (i in eviewsGraphics) eviews_graphics=append(eviews_graphics,list.files(pattern=paste0("^",i,"\\.",extension,"$"),path=save_path1,ignore.case = T))
# if(options$page) for (i in eviewsGraphics) eviews_graphics=append(eviews_graphics,list.files(pattern=paste0("^",i,"\\.",extension,"$"),path=save_path1,ignore.case = T))



# if(any(options$fig.keep=="desc")) eviews_graphics %<>% sort(decreasing = TRUE)
#
# if(any(options$fig.keep=="asc")) eviews_graphics %<>% sort
#
# if(is.numeric(options$fig.keep)) eviews_graphics=eviews_graphics[options$fig.keep]
#
# if(exists("pagelist1") && options$fig.keep=="new") eviews_graphics=eviews_graphics[grep(paste(pageList1,collapse = "\\-|\\-"),eviews_graphics)]
#
#
# if(save_path1==".") save_path1="" else save_path1=paste0(save_path1,"/")
#
# eviews_graphics=paste0(save_path1,eviews_graphics)
#

if(file.exists(paste0(eviewsrText1,"-graph.txt"))) graphPath=readLines(paste0(eviewsrText1,"-graph.txt")) %>%
  strsplit(split=" ") %>% unlist()


if(any(options$fig.keep=="desc")) graphPath %<>% sort(decreasing = TRUE)

if(any(options$fig.keep=="asc")) graphPath %<>% sort

if(is.numeric(options$fig.keep)) graphPath=graphPath[options$fig.keep]

if(exists("pageList1") && options$fig.keep=="new") graphPath=graphPath[grep(paste(pageList1,collapse = "\\-|\\-"),graphPath)]


# if(save_path1==".") save_path1="" else save_path1=paste0(save_path1,"/")

# eviewsGraphics=paste0(save_path1,graphPath)




eviewsGraphics=paste0(save_path1,graphPath)
eviewsGraphics1=paste0(save_path1,'/',graphPath,'.',extension)

# include_graphics(eviewsGraphics)



# include_graphics(eviews_graphics)

# figs = knitr:::find_recordedplot(res)

# options$fig.env='figure'
# options$fig.pos='H'
# cap = options$fig.cap
# scap = options$fig.scap
# res=eviews_graphics
# fig2=tail(res,1)
# options$fig.num =length(res); options$fig.cur = length(res)
#   extra = knitr:::run_hook_plot(res, options)
# engine_output(options, options$code, '', extra)

# reticulate:::defer(plot_counter(reset = TRUE), envir = knit_global())

on.exit({
  # getFromNamespace('plot_counter','knitr')(TRUE)
  do.call(':::',list('knitr','plot_counter'))(TRUE)
   # opts_knit$delete('plot_files')
}, add = TRUE) # restore plot number on.exit({

# extra = list(include_graphics(eviews_graphics))
# engine_output(options, options$code, extra,'')
#
# # begining of comment
code=engine_output(options,code = options$code, out = "")


if(all(save_path1!=eviewsGraphics)) output=list(knitr::include_graphics(eviewsGraphics1)) else output=list()
#
# output=list(knitr::include_graphics(eviews_graphics))

if(any(opts_current$get('fig.keep')=='none')) out="" else  out=engine_output(options,out =output)

if(options$echo) return(c(code,out)) else return(out)

#end of comment
# opts_chunk$restore()

# evaluate::evaluate(out)

 } # end of if(options$eval)

}

