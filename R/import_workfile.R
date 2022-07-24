#' Create an `EViews` graph in R and R Markdown
#'
#' Use this function to create an `EViews` graph in R and R Markdown
#'
#' @param series A vector of series names contained in an `EViews` workfile, or an R dataframe.
#' @param wf Object or a character string representing the name of an `EViews` workfile.
#' @param save_options A vector of options to be passed to `EViews` \code{save} command. It can values like \code{"t=png"},\code{-color} and so on.
#' @param page Object or a character string representing the name of an `EViews` workfile page.
#' @param mode Set `mode="overwrite"` to overwrite existing `EViews` graph objects that match the new `EViews` graph object to be created on the workfile. Set `mode=""` to avoid overwriting exising `EViews` graph object.
#' @param graph_command Object or a character string of any of the acceptable `EViews` graphical commands, such as \code{line}, \code{bar}, \code{pie}.
#' @param options Object or a character string of any of the acceptable `EViews` graphical options, such as \code{""}, \code{m}, \code{s}.
#' @param frequency Object or a character string representing the frequency of a workfile page to be created. Only letters accepted by EViews are allowed. For example \code{u} for undated, \code{a} for annual, \code{m} for monthly and so on.
#' @param start_date Object or a character string representing the \code{start date}. It should be left blank for undated (when the \code{frequency} is \code{u}).
#' @param graph_procs A vector containing `EViews` graph \code{procs} such as \code{datelabel}, \code{align}
#' @param datelabel A vector containing `EViews` axis label formats such as \code{format("YY")}. Using \code{datelabel} in \code{graph_procs} overwrites this argument.
#' @param save_path Object or a character string representing the path to the folder to save the `EViews` graphs. The current working directory is the default `save_path`. Specify the `save_path` only if you want the `EViews` graphs to live in different path from the current working directory.
#' @param group Logical, whether to use group view in EViews, that is merge two or more graphs on one page. Setting \code{group=FALSE} produces `EViews` graph for each series separately.
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
import_workfile=function(wf="",page="*",equation="*",graph="*",series="*",table="*",graph_procs="",datelabel="",save_options="",save_path=dirname(wf),save_copy=T){

   # options$fig.ncol=opts_chunk$get("fig.ncol") %n% 2

  chunkName=opts_current$get("label")

  envName=chunkName %n% "eviews" %>% gsub("[._-]","",.)



  graph1=graph


  chunkName=opts_current$get("label")

  dev=opts_current$get('dev')


  if(is.numeric(graph)) figKeep='%figKeep1="numeric"' else figKeep='%figKeep1=""'

  graph %<>% paste(collapse = ' ') %>%
    shQuote_cmd %>% paste0('%graph=',.)


  if(!identical(envName,"eviews")) assign(envName,new.env(),envir=knit_global())
  if(identical(envName,"eviews")){
    if(!exists("eviews") || !is.environment(eviews)) assign(envName,new.env(),envir=globalenv())
  }


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



    if(is.null(chunkName)) chunkName1="" else chunkName1=paste0(chunkName,"-")
        if(is.null(chunkName)) chunkName="" else chunkName=paste0(chunkName,'-') %>%
      shQuote_cmd() %>% paste0('%chunkName=',.)


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

    # graph %<>% paste(collapse = " ") %>%
      # shQuote_cmd %>% paste0("%graph=",.)

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
pagesave {%page}-{%chunkName}{%eviewsrText}.csv @keep {%series1} @drop date
%seriesPath=%seriesPath+" "+%page+"-"+%chunkName+%eviewsrText
endif
next

text {%eviewsrText}_series
{%eviewsrText}_series.append {%seriesPath}
{%eviewsrText}_series.save {%eviewsrText}-series


exit
)'

writeLines(c(eviews_path(),tempDir,figKeep,eviewsrText,chunkName,wf,page,equation,graph,series,table,save_path,save_options,eviewsCode,graph_procs,saveCode), fileName)

system_exec()

# on.exit(unlink(paste0(eviewsrText1,c('-equation.txt','-graph.txt','-series.txt','-table.txt'))))




# eviews_graphics=c()
# # eviews_graphics=list.files(pattern=paste0('png$'),path=save_path1,ignore.case = T)
#
# for (i in graph1) eviews_graphics=append(eviews_graphics,list.files(pattern=paste0("^",chunkName1,i,"\\.",extension,"$"),path=save_path1,ignore.case = T))
#
# # b=list.files(paste0("^",a[1],".png","$"),path = ".")



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
