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
eviews_graph=function(graph="",wf="",page="",graph_procs="",datelabel="",save_options=c("t=png","d=300"),save_path="EViewsR_files"){



if(any(grepl("^\\s*$", graph_procs))) graph_procs=graph_procs[-grep("^\\s*$",graph_procs)]

  chunk_name=opts_current$get("label")


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
graphPath=gsub("\\.prg$",'',fileName) %>% basename %>%
  shQuote_cmd %>% paste0('%graphPath=',.)



  graph_procs=paste0("{%y}.",graph_procs)
  graph_procs=append(c('%allGraphs=@wlookup("*","graph")','for %y {%allGraphs}')
,c(datelabel,graph_procs,'next'))

    if(is.null(chunk_name)) chunk_name1="" else chunk_name1=paste0(chunk_name,"-")
        if(is.null(chunk_name)) chunk_name="" else chunk_name=paste0(chunk_name,'-') %>%
      shQuote_cmd() %>% paste0('%chunk_name=',.)


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





eviews_code=r'(close @wf

if %wf<>"" then
wfopen {%wf}
endif

if %page<>"" then
pageselect {%page}
endif

if %mode<>"" then
%mode="mode="+%mode+","
endif


%allGraphs=@wlookup(%graph,"graph")
%save_path=@wreplace(%save_path,"* ","*")
%save_path=@wreplace(%save_path,"/","\")


if %save_path<>"" then
%save_path=%save_path+"\"
endif

%save_options=@wreplace(%save_options,"* ","*")

if %save_options<>"" then
%save_options="("+%save_options+")"
endif
)'





  save_code=r'(!n={%allGraphs}.@count
for !k=1 to {!n}
  {%x{!k}}_graph_EviewsR.save{%save_options} {%save_path}{%chunk_name}{%x{!k}}
  next
  delete {%EviewsrGroup}
  exit)'


writeLines(c(eviews_path(),chunk_name,EviewsRGroup,wf,page,series,graph_command,options,mode,save_path,save_options,eviews_code,freeze_code,graph_procs,save_code), fileName)

system_exec()
on.exit(unlink_eviews(),add = TRUE)




eviews_graphics=c()
# eviews_graphics=list.files(pattern=paste0('png$'),path=save_path1,ignore.case = T)

for (i in graph1) eviews_graphics=append(eviews_graphics,list.files(pattern=paste0("^",chunk_name1,i,"\\.",extension,"$"),path=save_path1,ignore.case = T))

# b=list.files(paste0("^",a[1],".png","$"),path = ".")

if(save_path1==".") save_path1="" else save_path1=paste0(save_path1,"/")
eviews_graphics=paste0(save_path1,eviews_graphics)
include_graphics(eviews_graphics)
}




# DELETE CSV and WORKFILES

# eviews_graph(wf="",page = "page",series="x y",mode = "overwrite",options = "m")
# @param end_date Object or a character string representing the \code{end date}. It should be left blank for undated (when the \code{frequency} is \code{u}).

