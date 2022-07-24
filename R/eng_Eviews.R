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




  if(grepl('width',options$out.width) && is.null(options$fig.ncol)){
    options$fig.ncol=gsub('\\\\textwidth|\\\\linewidth','',options$out.width) %>% as.numeric %>% `%/%`(1,.)
  }



  fileName=tempfile("EVIEWS", ".", ".prg")
  eviewsrText=gsub("\\.prg$",'',fileName) %>% basename
  eviewsrText1=eviewsrText
  eviewsrText %<>%
    shQuote_cmd %>% paste0('%eviewsrText=',.)

  options$eval=options$eval %n% opts_chunk$get("eval")


  chunkName=options$label

  envName=chunkName %>% gsub("[._-]","",.)
  assign(envName,new.env(),envir=knit_global())

  chunkName %<>% shQuote_cmd %>% paste0('%chunkName=',.)

  save_path=options$save_path %n% opts_current$get("fig.path")

  if(save_path!="" && !dir.exists(save_path)) dir.create(save_path,recursive = TRUE)

  save_path1=ifelse(save_path=="",".",save_path)
  save_path %<>% shQuote_cmd %>% paste0("%save_path=",.)

  tempDir=tempDir1=tempdir()
  tempDir %<>% shQuote_cmd %>% paste0('%tempDir=',.)


  # if(identical(getwd() %>% basename,'vignettes')) {
  #   save_path=tempfile('EviewsR',".") %>% basename
  #   tempDir=save_path
  #   on.exit(unlink(tempDir,recursive = TRUE),add = TRUE)
  # }


  equation=opts_current$get("equation") %n% "*" %>% shQuote_cmd %>% paste0('%equation=',.)
   graph=options$graph %n% "*"
   if(is.numeric(graph)) figKeep='%figKeep1="numeric"' else figKeep='%figKeep1=""'
   graph1=graph
   graph %<>% shQuote_cmd %>% paste0('%graph=',.)


  series=opts_current$get("series") %n% "*" %>% shQuote_cmd %>% paste0('%series=',.)
   table=opts_current$get("table") %n% "*" %>% shQuote_cmd %>% paste0('%table=',.)
  page=opts_current$get("page") %n% "*" %>% shQuote_cmd %>% paste0('%page=',.)
  page1=page %>%   strsplit(split=" ") %>%
    unlist() %>% paste0(collapse='|') %>% paste0('-(',.,')-')


  dev=opts_chunk$get('dev')
  save_options=options$save_options %n% ''
  if(!is.null(dev) && dev=="png") save_options="t=png,d=300"
  if(!is.null(dev) && dev=="pdf" && save_options=='') save_options="t=pdf"
  if(is.null(dev) && save_options=='') save_options="t=png,d=300"
  # Append "d=300" if "d=" (dpi) is not defined in "save_options"

  save_options1=c("t=bmp","t=gif", "t=jpg", "t=png")

  if(length(intersect(save_options,save_options1)>0)){
    if(intersect(save_options,save_options1) %in% save_options1 & sum(grepl("\\s*d\\s*=",save_options, ignore.case = T))==0) save_options=append(save_options,"d=300")
  }

  save_options2=paste0(save_options,collapse=",") %>% trimws() %>%  gsub('[[:blank:]]','',.) %>% strsplit(split=",") %>% unlist()

  extensions= c("t=emf", "t=wmf", "t=eps", "t=bmp", "t=gif", "t=jpg", "t=png", "t=pdf", "t=tex", "t=md")

  extension=intersect(extensions,save_options2) %>% gsub('t=','',.)

  if(length(extension)==0) extension="emf"

  save_options %<>% paste(collapse = ",") %>%
  shQuote_cmd %>% paste0("%save_options=",.)




  graphicsDefault=r'(

  %pagelist=@pagelist

  if %page<>"*" then
  %pagelist=%page
  endif

  for %page {%pagelist}
  pageselect {%page}

  if %graph="first" then
  %selectedGraphs=@wlookup("*","graph")
  %selectedGraphs=@wleft(%selectedGraphs,1)
  else if %graph="last" then
  %selectedGraphs=@wlookup("*","graph")
  %selectedGraphs=@wright(%selectedGraphs,1)
  else if %graph="asis" or %graph="asc" or %graph="desc" or %figKeep1="numeric"  then
  %selectedGraphs=@wlookup("*","graph")
  else
  %selectedGraphs=@wlookup(%graph,"graph")
  endif
  endif
  endif

  if @wcount(%selectedGraphs)>0 then
  for %y {%selectedGraphs}
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



  graph_procs=opts_current$get('graph_procs')

  if(!is.null(graph_procs)){
    graph_procs=paste0("{%y}.",graph_procs)

    prefixGraphProcs=r'(
    for %page {%pagelist}
    pageselect {%page}

    if %graph="first" then
    %selectedGraphs=@wlookup("*","graph")
    %selectedGraphs=@wleft(%selectedGraphs,1)
    else if %graph="last" then
    %selectedGraphs=@wlookup("*","graph")
    %selectedGraphs=@wright(%selectedGraphs,1)
    else if %graph="asis" or %graph="asc" or %graph="desc" or %figKeep1="numeric"  then
    %selectedGraphs=@wlookup("*","graph")
    else
    %selectedGraphs=@wlookup(%graph,"graph")
    endif
    endif
    endif

    if @wcount(%selectedGraphs)>0 then
    for %y {%selectedGraphs}
    )'

    suffixGraphProcs=r'(
    next
    endif
    next
    )'

    graph_procs=paste0(prefixGraphProcs,graph_procs,suffixGraphProcs,collapse = '\n')

    if(any(grepl("^\\s*$", graph_procs))) graph_procs=graph_procs[-grep("^\\s*$",graph_procs)]
  }


  equationSeriesTablePath=r'(
  '####################### TABLES #################


  %tablePath=""

  for %page {%pagelist}
  pageselect {%page}
  %tables1=@wlookup(%table ,"table")

  if @wcount(%tables1)<>0 then
  for %y {%tables1}
  %tablePath=%tablePath+" "+%page+"_"+%y+"-"+%eviewsrText
  {%y}.save(t=csv) {%page}_{%y}-{%eviewsrText}
  next
  endif
  next

  text {%eviewsrText}_table
  {%eviewsrText}_table.append {%tablePath}
  {%eviewsrText}_table.save {%eviewsrText}-table


  '####################### EQUATIONS #################

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

  '####################### SERIES #################

  %seriesPath=""
  for %page {%pagelist}
  pageselect {%page}
  %series1=@wlookup(%series,"series")
  if @wcount(%series1)>0 then
  pagesave {%page}-{%chunkName}{%eviewsrText}.csv @keep {%series1} @drop date
  %seriesPath=%seriesPath+" "+%page+"-"+%chunkName+%eviewsrText
  endif
  next

  text {%eviewsrText}_series
  {%eviewsrText}_series.append {%seriesPath}
  {%eviewsrText}_series.save {%eviewsrText}-series


  exit
  )'


  if(!identical(graph1,'asis')){
  graphPath=r'(%save_path=@wreplace(%save_path,"* ","*")
  %save_path=@wreplace(%save_path,"/","\")


  if %save_path<>"" then
  %save_path=%save_path+"\"
  endif


  '####################### GRAPHS #################


  if %figKeep1="numeric" then
  %save_path=%tempDir
  endif

  %save_path=@wreplace(%save_path,"* ","*")
  %save_path=@wreplace(%save_path,"/","\")


  if %save_path<>"" then
  %save_path=%save_path+"\"
  endif


  %save_options=@wreplace(%save_options,"* ","*")

  if %save_options<>"" then
  %save_options="("+%save_options+")"
  endif

  %graphPath=""
  for %page {%pagelist}
  pageselect {%page}


  if %graph="first" then
  %selectedGraphs=@wlookup("*","graph")
  %selectedGraphs=@wleft(%selectedGraphs,1)
  else if %graph="last" then
  %selectedGraphs=@wlookup("*","graph")
  %selectedGraphs=@wright(%selectedGraphs,1)
  else if %graph="asis" or %graph="asc" or %graph="desc" or %figKeep1="numeric"  then
  %selectedGraphs=@wlookup("*","graph")
  else
  %selectedGraphs=@wlookup(%graph,"graph")
  endif
  endif
  endif



  if @wcount(%selectedGraphs)>0 then
  for %selectedGraph {%selectedGraphs}
  {%selectedGraph}.save{%save_options} {%save_path}{%chunkName}{%page}-{%selectedGraph}
  %graphPath=%graphPath+" "+%chunkName+%page+"-"+%selectedGraph
  next
  endif
  next

  '%graphPath1=""
  'if %figKeep1="numeric" then
  'for %number {%graph}
  '!number=@val(%number)
  '!number=@val(@word(%graph,!number))
  '%graphN=@word(%graphPath,!number)
  '%graphPath1=%graphPath1+" "+%graphN
  'next
  'else
  '%graphPath1=%graphPath
  'endif


  if @wcount(%graphPath)>0 then
  text {%eviewsrText}_graph
  {%eviewsrText}_graph.append {%graphPath}
  {%eviewsrText}_graph.save  {%eviewsrText}-graph
  endif)'
}




  ####### GRAPH="ASIS" #####################



  if(identical(graph1,"asis"))  {

#### Generate graphPath from the options$code

appendCode=r'(
  %currentpage=@pagename
  %newgraph=@wlookup("*","graph")
  %newgraph=@wdrop(%newgraph,%existing)
  %existing=@wlookup("*","graph")
  if @wcount(%newgraph)>0 then
  %graphPath=%graphPath+" "+%chunkName+"-"+%currentpage+"-"+%newgraph
  endif
 )'


    eviewsCode=options$code %>% strsplit(split="\n") %>%
      unlist()

graphIndex=grep("^(\\s*freeze|\\s*graph)",eviewsCode) %>% rev()

for (i in graphIndex) eviewsCode=append(eviewsCode,appendCode,i)

    eviewsCode=append(eviewsCode,'%existing=@wlookup("*","graph")',tail(graphIndex,1)-1)
    options$code=eviewsCode


    graphPath=r'(if %save_path<>"" then
    %save_path=%save_path+"\"
    endif

    %save_options=@wreplace(%save_options,"* ","*")

    if %save_options<>"" then
    %save_options="("+%save_options+")"
    endif

    for %page {%pagelist}
    pageselect {%page}

    %selectedGraphs=@wlookup("*","graph")

    if @wcount(%selectedGraphs)>0 then
    for %selectedGraph {%selectedGraphs}
    {%selectedGraph}.save{%save_options} {%save_path}{%chunkName}-{%page}-{%selectedGraph}
    next
    endif
    next


    if @wcount(%graphPath)>0 then
    text {%eviewsrText}_graph
    {%eviewsrText}_graph.append {%graphPath}
    {%eviewsrText}_graph.save  {%eviewsrText}-graph
    endif


    )'
}



  writeLines(c(eviews_path(),tempDir,figKeep,eviewsrText,chunkName,page,equation,graph,series,table,options$code,graphicsDefault,save_path,save_options,graph_procs,graphPath,equationSeriesTablePath), fileName)

  system_exec()





  ##### EQUATION ##########

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


  ##### SERIES #####



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
      assign(pageName,dataFrame,envir =get(envName,envir = parent.frame()))
    }
  }


  ###### TABLES #####


  if(file.exists(paste0(eviewsrText1,"-table.txt"))) tablePath=readLines(paste0(eviewsrText1,"-table.txt")) %>%
    strsplit(split=" ") %>% unlist()

  for (i in tablePath){
    tableName=gsub("\\-.*","",i) %>% tolower
    assign(tableName,read.csv(paste0(i,".csv")),envir = get(envName,envir = parent.frame()))
  }



  on.exit(unlink(paste0(equationPath,".csv")),add = TRUE)
  on.exit(unlink(paste0(tablePath,".csv")),add = TRUE)
  on.exit(unlink(paste0(seriesPath,".csv")),add = TRUE)
  on.exit(unlink(paste0(eviewsrText1,c("-graph.txt","-equation.txt","-series.txt","-table.txt"))),add = TRUE)
  on.exit(unlink_eviews(),add = TRUE)


  if(file.exists(paste0(eviewsrText1,"-graph.txt"))){ graphPath=readLines(paste0(eviewsrText1,"-graph.txt")) %>%
    strsplit(split=" ") %>% unlist()

  if(any(graph1=="desc")) graphPath %<>% sort(decreasing = TRUE)
  if(any(graph1=="asc")) graphPath %<>% sort
  if(is.numeric(graph1)) graphPath=graphPath[graph1]
  # if(identical(graph1,"asis")) graphPath=graphPath[grep(page1,graphPath,ignore.case = TRUE)]

  if(is.numeric(graph1)) file.copy(paste0(tempDir1,'/',graphPath,'.',extension),paste0(save_path1,'/',graphPath,'.',extension),overwrite = TRUE)
  eviewsGraphics=paste0(save_path1,'/',graphPath,'.',extension)

}

  on.exit(do.call(':::',list('knitr','plot_counter'))(TRUE),
          add = TRUE) # restore plot number on.exit

  echoCode=engine_output(options,code = options$code, out = "")


  if(!file.exists(paste0(eviewsrText1,"-graph.txt")))  grahicsOutput=list() else grahicsOutput=list(include_graphics(eviewsGraphics))

  if(!file.exists(paste0(eviewsrText1,"-graph.txt"))) grahicsOutput="" else  grahicsOutput=engine_output(options,out =grahicsOutput)

  if(options$echo) return(c(echoCode,grahicsOutput)) else return(grahicsOutput)

}













