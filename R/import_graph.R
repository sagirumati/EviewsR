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
import_graph=function(wf="",page="*",graph="*",graph_procs="",datelabel="",save_options="",save_path=dirname(wf),save_copy=T){

   # options$fig.ncol=opts_chunk$get("fig.ncol") %n% 2



  chunkName=opts_current$get("label")

  dev=opts_current$get('dev')


graph1=graph

  if(is.numeric(graph)) figKeep='%figKeep1="numeric"' else figKeep='%figKeep1=""'

  # if(any(graph %in% c("*","asc","desc"))) figKeep='%figKeep1="all"'
  # if(any(graph=="first")) figKeep='%figKeep1="first"'
  # if(any(graph=="last")) figKeep='%figKeep1="last"'

  # if(!any(graph %in% c("asc","desc","first","last","asis")) || identical(graph,"*")){
  #   graph %<>% paste(collapse = ' ') %>%
  # shQuote_cmd %>% paste0('%graph=',.)
  #   figKeep='%figKeep="graph"'
  # }else graph=""

graph %<>% paste(collapse = ' ') %>%
  shQuote_cmd %>% paste0('%graph=',.)

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


    fileName=tempfile("EVIEWS", ".", ".prg")
eviewsrText=gsub("\\.prg$",'',fileName) %>% basename
eviewsrText1=eviewsrText
eviewsrText %<>%
  shQuote_cmd %>% paste0('%eviewsrText=',.)


  if(!identical(graph_procs,'')){
    graph_procs=paste0("{%y}.",graph_procs)
  graph_procs=append(c('for %page {%pagelist}','pageselect {%page}','%selectedGraphs=@wlookup(%graph,"graph")','if @wcount(%selectedGraphs)>0 then','for %y {%selectedGraphs}')
,c(graph_procs,'next','endif','next'))

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

saveCode=r'(
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


'if %figKeep1="first" then
'%graph1=@wlookup("*","graph")
'%graph1=@wleft(%graph1,1)
'else if %figKeep1="last" then
'%graph1=@wlookup("*","graph")
'%graph1=@wright(%graph1,1)
'else if %figKeep1="asc" or %figKeep1="desc" or %figKeep1="numeric"  then
'%graph1=@wlookup("*","graph")
'else
'%graph1=@wlookup(%graph,"graph")
'endif
'endif
'endif


if %graph="first" then
%graph1=@wlookup("*","graph")
%graph1=@wleft(%graph1,1)
else if %graph="last" then
%graph1=@wlookup("*","graph")
%graph1=@wright(%graph1,1)
else if %graph="asis" or %graph="asc" or %graph="desc" or %figKeep1="numeric"  then
%graph1=@wlookup("*","graph")
else
%graph1=@wlookup(%graph,"graph")
endif
endif
endif


%selectedGraphs=%graph1

if @wcount(%selectedGraphs)>0 then
for %selectedGraph {%selectedGraphs}
{%selectedGraph}.save{%save_options} {%save_path}{%chunkName}{%page}-{%selectedGraph}
%graphPath=%graphPath+" "+%chunkName+%page+"-"+%selectedGraph
next
endif
next

%graphPath1=""
if %figKeep1="numeric" then
for %number {%graph}
!number=@val(%number)
'!number=@val(@word(%graph,!number))
%graphN=@word(%graphPath,!number)
%graphPath1=%graphPath1+" "+%graphN
next
else
%graphPath1=%graphPath
endif


text {%eviewsrText}_graph
{%eviewsrText}_graph.append {%graphPath1}
{%eviewsrText}_graph.save  {%eviewsrText}-graph
exit
)'

writeLines(c(eviews_path(),tempDir,figKeep,eviewsrText,chunkName,wf,page,graph,save_path,save_options,eviewsCode,graph_procs,saveCode), fileName)

system_exec()
on.exit(unlink_eviews(),add = TRUE)
on.exit(unlink(paste0(eviewsrText1,'-graph.txt')),add = TRUE)



# eviews_graphics=c()
# # eviews_graphics=list.files(pattern=paste0('png$'),path=save_path1,ignore.case = T)
#
# for (i in graph1) eviews_graphics=append(eviews_graphics,list.files(pattern=paste0("^",chunkName1,i,"\\.",extension,"$"),path=save_path1,ignore.case = T))
#
# # b=list.files(paste0("^",a[1],".png","$"),path = ".")

if(!save_copy) on.exit(unlink(eviewsGraphics))


if(file.exists(paste0(eviewsrText1,"-graph.txt"))) graphPath=readLines(paste0(eviewsrText1,"-graph.txt")) %>%
  strsplit(split=" ") %>% unlist()


if(any(graph1=="desc")) graphPath %<>% sort(decreasing = TRUE)
if(any(graph1=="asc")) graphPath %<>% sort
# if(is.numeric(graph1)) graphPath=graphPath[graph1]

if(is.numeric(graph1)) file.copy(paste0(tempDir1,'/',graphPath,'.',extension),paste0(save_path1,'/',graphPath,'.',extension),overwrite = TRUE)
  eviewsGraphics=paste0(save_path1,'/',graphPath,'.',extension)
  include_graphics(eviewsGraphics)


}
