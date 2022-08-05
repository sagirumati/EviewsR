#' Import `EViews` graph objects(s) into R, R Markdown or Quarto.
#'
#' Use this function to import `EViews` graph objects(s) into R, R Markdown or Quarto.
#'
#' @inheritParams eviews_graph
#' @param graph Name(s) or wildcard expressions of EViews graph object(S)
#' @param wf Object or a character string representing the name of an `EViews` workfile.
#' @param page Object or a character string representing the name of an `EViews` workfile page.
#' @param graph_procs A vector containing `EViews` graph \code{procs} such as \code{datelabel}, \code{align}
#' @param save_copy Logical. Whether to save the copy of the graph objects
#' @param save_path Object or a character string representing the path to the folder to save the `EViews` graphs. The current working directory is the default `save_path`. Specify the `save_path` only if you want the `EViews` graphs to live in different path from the current working directory.
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#' demo(exec_commands)
#'
#' # To import all graph objects
#'
#' import_graph(wf="exec_commands")
#'
#' # To import only graphs that begin with x:
#'
#' import_graph(wf="exec_commands",graph="x*")
#'
#'}
#' @family important functions
#' @keywords documentation
#' @export
import_graph=function(wf="",page="*",graph="*",graph_procs="",save_options="",save_copy=T,save_path=dirname(wf)){


  chunkLabel=opts_current$get("label")

  dev=opts_current$get('dev')


graph1=graph

  if(is.numeric(graph)) figKeep='%figKeep1="numeric"' else figKeep='%figKeep1=""'

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
exit
)'

writeLines(c(eviews_path(),tempDir,figKeep,eviewsrText,chunkLabel,wf,page,graph,save_path,save_options,eviewsCode,graph_procs,saveCode), fileName)

system_exec()
on.exit(unlink_eviews(),add = TRUE)
on.exit(unlink(paste0(eviewsrText1,'-graph.txt')),add = TRUE)


if(file.exists(paste0(eviewsrText1,"-graph.txt"))){
  graphPath=readLines(paste0(eviewsrText1,"-graph.txt")) %>%
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
