#' Create an `EViews` graph in R and R Markdown
#'
#' Use this function to create an `EViews` graph in R and R Markdown
#'
#' @inheritParams import_equation
#' @inheritParams import_graph
#' @inheritParams import_series
#' @inheritParams import_table
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#' demo(exec_commands)
#' eviews_graph(wf="EviewsR_exec_commands",page = "page",series="x y",mode = "overwrite",options = "m")
#'
#'}
#' @family important functions
#' @keywords documentation
#' @export
import_workfile=function(wf="",page="*",equation="*",graph="*",series="*",table="*",graph_procs="",save_options="",save_path=dirname(wf),save_copy=T,class="df"){

   # options$fig.ncol=opts_chunk$get("fig.ncol") %n% 2

  chunkLabel=opts_current$get("label")

  envName=chunkLabel %n% "eviews" %>% gsub("^fig-","",.) %>% gsub("[._-]","",.)



  graph1=graph


  chunkLabel=opts_current$get("label")

  dev=opts_current$get('dev')


  if(is.numeric(graph)) figKeep='%figKeep1="numeric"' else figKeep='%figKeep1=""'

  graph %<>% paste(collapse = ' ') %>%
    shQuote_cmd %>% paste0('%graph=',.)


  if(!identical(envName,"eviews")) assign(envName,new.env(),envir=knit_global())
  # if(identical(envName,"eviews")){
  #   if(!exists("eviews") || !is.environment(eviews)) assign(envName,new.env(),envir=globalenv())
  # }


  fileName=tempfile("EVIEWS", ".", ".prg")
  eviewsrText=gsub("\\.prg$",'',fileName) %>% basename
  eviewsrText1=eviewsrText
  eviewsrText %<>%
    shQuote_cmd %>% paste0('%eviewsrText=',.)

  dev=opts_current$get('dev')

  if(!is.null(dev) && dev=="png" && save_options=='') save_options="t=png,d=300"
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




    if(!identical(graph_procs,'')){
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



    if(is.null(chunkLabel)) chunkLabel1="" else chunkLabel1=paste0(chunkLabel,"-")
        if(is.null(chunkLabel)) chunkLabel="" else chunkLabel=paste0(chunkLabel,'-') %>%
      shQuote_cmd() %>% paste0('%chunkLabel=',.)


    save_path=gsub("/","\\\\",save_path)

    save_path=opts_current$get("fig.path") %n% save_path

    if(save_path!="" && !dir.exists(save_path)) dir.create(save_path,recursive = TRUE)

    save_path1=ifelse(save_path=="",".",save_path)
    save_path=paste0("%save_path=",shQuote_cmd(save_path))

    tempDir=tempDir1=tempdir()
    tempDir %<>% shQuote_cmd %>% paste0('%tempDir=',.)


    wf=paste0('%wf=',shQuote_cmd(wf))
    page=paste0("%page=",shQuote_cmd(page))

    equation %<>% paste(collapse = " ") %>%
      shQuote_cmd %>% paste0("%equation=",.)


    series %<>% paste(collapse = " ") %>%
      shQuote_cmd %>% paste0("%series=",.)

    table %<>% paste(collapse = " ") %>%
      shQuote_cmd %>% paste0("%table=",.)


    save_options=paste(save_options,collapse = ",")
    save_options=paste0("%save_options=",shQuote_cmd(save_options))





eviewsCode=r'(
if %wf<>"" then
wfopen {%wf}
endif


%pagelist=@pagelist

if %page<>"*" then
%pagelist=%page
endif

)'

saveCode=r'(%save_path=@wreplace(%save_path,"* ","*")
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
{%selectedGraph}.save{%save_options} {%save_path}{%chunkLabel}{%page}-{%selectedGraph}
%graphPath=%graphPath+" "+%chunkLabel+%page+"-"+%selectedGraph
next
endif
next


if @wcount(%graphPath)>0 then
text {%eviewsrText}_graph
{%eviewsrText}_graph.append {%graphPath}
{%eviewsrText}_graph.save  {%eviewsrText}-graph
endif


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
pagesave {%page}-{%chunkLabel}{%eviewsrText}.csv @keep {%series1} @drop date
%seriesPath=%seriesPath+" "+%page+"-"+%chunkLabel+%eviewsrText
endif
next

text {%eviewsrText}_series
{%eviewsrText}_series.append {%seriesPath}
{%eviewsrText}_series.save {%eviewsrText}-series


exit
)'

writeLines(c(eviews_path(),tempDir,figKeep,eviewsrText,chunkLabel,wf,page,equation,graph,series,table,save_path,save_options,eviewsCode,graph_procs,saveCode), fileName)

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
        if(identical(class,'xts')) dataFrame=xts(dataFrame[-1],dataFrame[[1]])
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

  ###### GRAPHS #################

  if(file.exists(paste0(eviewsrText1,"-graph.txt"))){ graphPath=readLines(paste0(eviewsrText1,"-graph.txt")) %>%
    strsplit(split=" ") %>% unlist()

  if(any(graph1=="desc")) graphPath %<>% sort(decreasing = TRUE)
  if(any(graph1=="asc")) graphPath %<>% sort
  if(is.numeric(graph1)) graphPath=graphPath[graph1]


  if(is.numeric(graph1)) file.copy(paste0(tempDir1,'/',graphPath,'.',extension),paste0(save_path1,'/',graphPath,'.',extension),overwrite = TRUE)
  eviewsGraphics=paste0(save_path1,'/',graphPath,'.',extension)

  if(!save_copy) on.exit(unlink(eviewsGraphics))

  include_graphics(eviewsGraphics)
}

}
