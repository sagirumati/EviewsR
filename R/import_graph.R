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
import_graph=function(graph="*",wf="",page="*",graph_procs="",datelabel="",save_options="",save_path="EViewsR_files",save_copy=F){




if(any(grepl("^\\s*$", graph_procs))) graph_procs=graph_procs[-grep("^\\s*$",graph_procs)]

  chunkName=opts_current$get("label")


  if(options$dev=="png" && save_options=='') save_options="t=png,d=300"
  if(options$dev=="pdf" && save_options=='') save_options="t=pdf"

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


  graph_procs=paste0("{%y}.",graph_procs)
  graph_procs=append(c('for %page {%pagelist}','pageselect {%page}','%selectedGraphs=@wlookup(%graph,"graph")','if @wcount(%selectedGraphs)>0 then','for %y {%selectedGraphs}')
,c(graph_procs,'next','endif','next'))

    if(is.null(chunkName)) chunkName1="" else chunkName1=paste0(chunkName,"-")
        if(is.null(chunkName)) chunkName="" else chunkName=paste0(chunkName,'-') %>%
      shQuote_cmd() %>% paste0('%chunkName=',.)


    save_path=gsub("/","\\\\",save_path)

    save_path=opts_current$get("fig.path") %n% save_path

    if(save_path!="" && !dir.exists(save_path)) dir.create(save_path,recursive = TRUE)

    save_path1=ifelse(save_path=="",".",save_path)
    save_path=paste0("%save_path=",shQuote_cmd(save_path))


    wf=paste0('%wf=',shQuote_cmd(wf))
    page=paste0("%page=",shQuote_cmd(page))
    graph=paste(graph,collapse = " ")
    graph=paste0("%graph=",shQuote_cmd(graph))

    save_options=paste(save_options,collapse = ",")
    save_options=paste0("%save_options=",shQuote_cmd(save_options))





eviewsCode=r'(
if %wf<>"" then
wfopen {%wf}
endif

if %page<>"" then
pageselect {%page}
endif
)'

saveCode=r'(%save_path=@wreplace(%save_path,"* ","*")
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
%selectedGraphs=@wlookup(%graph,"graph")
if @wcount(%selectedGraphs)>0 then
for %graph {%selectedGraphs}
{%graph}.save{%save_options} {%save_path}{%chunkName}{%page}-{%graph}
%graphPath=%graphPath+" "+%chunkName+%page+"-"+%graph
next
endif
next

text {%eviewsrText}_graph
{%eviewsrText}_graph.append {%graphPath}
{%eviewsrText}_graph.save  {%eviewsrText}-graph
exit
)'

writeLines(c(eviews_path(),eviewsrText,chunkName,wf,page,graph,save_path,save_options,eviewsCode,graph_procs,saveCode), fileName)

system_exec()
on.exit(unlink_eviews(),add = TRUE)
on.exit(unlink(paste0(eviewsrText1,'-graph.txt')),add = TRUE)



# eviews_graphics=c()
# # eviews_graphics=list.files(pattern=paste0('png$'),path=save_path1,ignore.case = T)
#
# for (i in graph1) eviews_graphics=append(eviews_graphics,list.files(pattern=paste0("^",chunkName1,i,"\\.",extension,"$"),path=save_path1,ignore.case = T))
#
# # b=list.files(paste0("^",a[1],".png","$"),path = ".")

if(file.exists(paste0(eviewsrText1,"-graph.txt"))) graphPath=readLines(paste0(eviewsrText1,"-graph.txt")) %>%
  strsplit(split=" ") %>% unlist()

  eviewsGraphics=paste0(save_path1,'/',graphPath,'.',extension)
  include_graphics(eviewsGraphics)

  if(isFalse(save_copy)) on.exit(unlink(eviewsGraphics))
}
