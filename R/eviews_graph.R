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
eviews_graph=function(series="",group=FALSE,wf="",page="",mode="overwrite",graph_command="line",options="",graph_procs="",datelabel="",save_options=c("t=png","d=300"),save_path="",frequency="m",start_date=""){

graphProcsDefault=c('textdefault font("Times",12,-b,-i,-u,-s) existing','legend font(Times New Roman,12,-i,-u,-s)','axis(a) font("Times",12,-b,-i,-u,-s)','align(2,1,1)')

graph_procs=append(graphProcsDefault,graph_procs)

if(any(grepl("^\\s*$", graph_procs))) graph_procs=graph_procs[-grep("^\\s*$",graph_procs)]

  chunk_name=opts_current$get("label")

  # extensions= c(".emf", ".wmf", ".eps", ".bmp", ".gif", ".jpeg", ".png", ".pdf", ".tex", ".md")

  # extensions= c("emf", "wmf", "eps", "bmp", "gif", "jpeg", "png", "pdf", "tex", "md")


  if(is.data.frame(series)) series1=names(series) else series1=series
  if(group) series1=paste0(series1,collapse = "")
   if(group==T & length(series1)==1) series1=gsub(" ","",series1)

  if(group!=T & length(series1)==1){
    series1=trimws(series1)
    series1=unlist(strsplit(series1,split=" "))
  }

  if(is.data.frame(series)) {
    # stopifnot("The 'series' object must be a dataframe"=is.data.frame(series))
    stopifnot("'frequency' or 'start_date' cannot be blank"=frequency!="" & start_date!="")

    wf=chunk_name %n% basename(tempfile("EViewsR"))
    wf=gsub("[.-]","_",wf)
    wf1=wf
    page=wf
    csvFile=paste0(wf,".csv")
        write.csv(series,csvFile,row.names = F)
        eviews_import(source_description = csvFile,frequency = frequency,start_date = start_date)

        series = names(series)

        on.exit(unlink(c(csvFile,paste0(wf1,".wf1")),force = T),add = T)
        # on.exit(unlink(),force = T),add = T)
}



# Append "d=300" if "d=" (dpi) is not defined in "save_options"

    save_options1=c("t=bmp","t=gif", "t=jpeg", "t=png")

    if(length(intersect(save_options,save_options1)>0)){
    if(intersect(save_options,save_options1) %in% save_options1 & sum(grepl("d=",save_options, ignore.case = T))==0) save_options=append(save_options,"d=300")
    }

    save_options2=paste0(save_options,collapse=",") %>% trimws() %>%  gsub('[[:blank:]]','',.) %>% strsplit(split=",") %>% unlist()

    extensions= c("t=emf", "t=wmf", "t=eps", "t=bmp", "t=gif", "jpeg", "t=png", "t=pdf", "t=tex", "md")

    extension=intersect(extensions,save_options2) %>% gsub('t=','',.)

    if(length(extension)==0) extension="emf"

    #stopifnot("EViewsR works on Windows only"=Sys.info()["sysname"]=="Windows")

    fileName=tempfile("EVIEWS", ".", ".prg")
  EviewsRGroup=basename(tempfile("EviewsRGroup"))



if(datelabel==""){
datelabel <- '%freq=@pagefreq
  if %freq="m" or %freq="M" then
  {%y}.datelabel format("YYYY") interval(auto, 1, 1)
  endif
  if %freq="D7" or %freq="D5"  or %freq="d5"  or %freq="d7" then
  {%y}.datelabel format("Mon YYYY") interval(auto, 1, 1)
  endif
if %freq="a" or %freq="A" then
  {%y}.datelabel format("YYYY") interval(auto, 1, 1)
  endif'
}else{
datelabel=paste('{%y}.datelabel',datelabel)
}


  graph_procs=paste0("{%y}.",graph_procs)
  graph_procs=append(c('%allEviewsGraphs=@wlookup("*","graph")\n','for %y {%allEviewsGraphs}\n')
,c(datelabel,graph_procs,'next'))

  EviewsRGroup=paste0('%EviewsRGroup=',shQuote_cmd(EviewsRGroup))
   wf=paste0('%wf=',shQuote_cmd(wf))
    page=paste0("%page=",shQuote_cmd(page))
    series=paste(series,collapse = " ")
    series=paste0("%series=",shQuote_cmd(series))
    graph_command=paste0("%graph_command=",shQuote_cmd(graph_command))
    options=paste0("%options=",shQuote_cmd(options))
    mode=paste0("%mode=",shQuote_cmd(mode))



    # if(is.null(chunk_name)) chunk_name1="" else chunk_name1=paste0(chunk_name,"_") %>%  gsub("[.,-]","_",.)
    # if(is.null(chunk_name)) chunk_name="" else chunk_name=paste0(chunk_name,'_') %>% gsub("[.,-]","_",.) %>%
    #   shQuote_cmd() %>% paste0('%chunk_name=',.)

    if(is.null(chunk_name)) chunk_name1="" else chunk_name1=paste0(chunk_name,"-")
        if(is.null(chunk_name)) chunk_name="" else chunk_name=paste0(chunk_name,'-') %>%
      shQuote_cmd() %>% paste0('%chunk_name=',.)


    save_path=gsub("/","\\\\",save_path)

    # if (save_path=="" & is.null(chunk_name)) save_path=paste("EViewsR_files")
     # if (save_path=="" & !is.null(chunk_name)) save_path=paste0("EViewsR_files")
     #
     if (save_path=="") save_path=paste("EViewsR_files")
    if(opts_current$get("fig.path")=="") save_path=""
    save_path=gsub("[.,-]","_",save_path)
    if(save_path!="" && !dir.exists(save_path)) dir.create(save_path,recursive = TRUE)

     # dir.create(paste0("EViewsR_files/",chunk_name))
    save_path1=ifelse(save_path=="",".",save_path)
       # save_path1=paste0(save_path,"/")
    save_path=paste0("%save_path=",shQuote_cmd(save_path))

    save_options=paste(save_options,collapse = ",")
    save_options=paste0("%save_options=",shQuote_cmd(save_options))


    # eviews_graphics=list.files(pattern=paste0('_graph_eviewsr'),path=save_path1,ignore.case = T)
    # file.remove(paste0(save_path1,eviews_graphics))


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


%z=@wlookup(%series,"series")
%graph_command=@wreplace(%graph_command,"* ","*")
%mode=@wreplace(%mode,"* ","*")
%save_path=@wreplace(%save_path,"* ","*")
%save_path=@wreplace(%save_path,"/","\")


if %save_path<>"" then
%save_path=%save_path+"\"
endif

%save_options=@wreplace(%save_options,"* ","*")

if %save_options<>"" then
%save_options="("+%save_options+")"
endif

if %options<>"" then
%options="("+%options+")"
endif)'



if (group!=T){

  freeze_code=r'(group {%EviewsRGroup} {%z}
  !n={%EviewsRGroup}.@count

  for !k=1 to {!n}
  %x{!k}={%EviewsRGroup}.@seriesname({!k})


  freeze({%mode}{%x{!k}}_graph_EviewsR) {%x{!k}}.{%graph_command}{%options}
  next)'


  save_code=r'(for !k=1 to {!n}
  {%x{!k}}_graph_EviewsR.save{%save_options} {%save_path}{%chunk_name}{%x{!k}}
  next
  delete {%EviewsrGroup}
  exit)'
}

if (group){

      freeze_code=r'(group {%EviewsRGroup} {%z}

      %seriesNames=@replace(%z," ","")
      %seriesNames=%seriesNames
      freeze({%mode}{%seriesNames}_graph_EviewsR) {%EviewsRGroup}.{%graph_command}{%options})'

      save_code=r'({%seriesNames}_graph_EviewsR.save{%save_options} {%save_path}{%chunk_name}{%seriesNames}
      delete {%EviewsrGroup}
      exit)'
      }

writeLines(c(eviews_path(),chunk_name,EviewsRGroup,wf,page,series,graph_command,options,mode,save_path,save_options,eviews_code,freeze_code,graph_procs,save_code), fileName)

system_exec()
on.exit(unlink_eviews(),add = TRUE)




eviews_graphics=c()
# eviews_graphics=list.files(pattern=paste0('png$'),path=save_path1,ignore.case = T)

for (i in series1) eviews_graphics=append(eviews_graphics,list.files(pattern=paste0("^",chunk_name1,i,"\\.",extension,"$"),path=save_path1,ignore.case = T))

# b=list.files(paste0("^",a[1],".png","$"),path = ".")

if(save_path1==".") save_path1="" else save_path1=paste0(save_path1,"/")
eviews_graphics=paste0(save_path1,eviews_graphics)
include_graphics(eviews_graphics)
}




# DELETE CSV and WORKFILES

# eviews_graph(wf="",page = "page",series="x y",mode = "overwrite",options = "m")
# @param end_date Object or a character string representing the \code{end date}. It should be left blank for undated (when the \code{frequency} is \code{u}).

