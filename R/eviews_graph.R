#' Create an `EViews` graph in R Markdown
#'
#' Use this function to create an `EViews` graph in R Markdown
#'
#' @usage eviews_wfcreate(wf_name="",page_name="",frequency="",start_date="",end_date="",path="",save=T)
#' @param wf_name Object or a character string representing the name of a workfile to be created
#'
#' @param page_name Object or a character string representing the name of a workfile page to be created
#'
#' @param frequency Object or a character string representing the frequency of a workfile page to be created. Only letters accepted by EViews are allowed. For example \code{u} for undated, \code{a} for annual, \code{m} for monthly and so on.
#'
#' @param start_date Object or a character string representing the \code{start date}. It should be left blank for undated (when the \code{frequency} is \code{u}).
#'
#' @param end_date Object or a character string representing the \code{end date}. It should be left blank for undated (when the \code{frequency} is \code{u}).
#'
#' @param path Object or a character string representing the path to the folder for the  workfile to be saved. The current working directory is the default `path`. Specify the `path` only if you want the workfile to live in different path from the current working directory.
#'
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#' eviews_wfcreate(wf_name="WORKFILE",page_name="PAGE",frequency="m",start_date="1990m1",end_date="2021m4",path="",save=T)
#'}
#' @seealso eng_eviews, eviews_commands, eviews_graph, eviews_import, eviews_object, eviews_pagesave, eviews_rwalk, eviews_wfcreate, eviews_wfsave, export, import_table, import
#' @keywords documentation
#' @export
eviews_graph=function(series="",wf="",page="",mode="overwrite",graph_command="line",options="m",frequency="7",start_date="",save=FALSE,save_options=c("t=png"),save_path="",file_name="",graph_procs=c('textdefault font("Times",20,-b,-i,-u,-s)','align(2,1,1)'),datelabel="",merge_graphs=FALSE){

    if(frequency!="" & start_date!=""){
    stopifnot("The 'series' object must be a dataframe"=is.data.frame(series))
    wf=basename(tempfile("EViewsR"))
    csvFile=paste0(wf,".csv")
        write.csv(series,csvFile,row.names = F)
        eviews_import(source_description = csvFile,frequency = frequency,start_date = start_date)

  series = names(series);wf=wf
        on.exit(unlink(c(csvFile,paste0(wf,".wf1"))))
          }

  if(is.data.frame(series)) series1=names(series) else series1=series

  save_options1=c("t=bmp","t=gif", "t=jpeg", "t=png")
  if(intersect(save_options,save_options1) %in% save_options1) save_options=append(save_options,"dpi=300")

  #stopifnot("EViewsR works on Windows only"=Sys.info()["sysname"]=="Windows")
  # stopifnot("Please enter at least one series name"=!is.null(series),series!="",series!=" ",series %in% letters | series %in% LETTERS)
  #stopifnot("Please enter at least one series name"=series %in% letters | series %in% LETTERS,!is.null(series))
  fileName=tempfile("EVIEWS", ".", ".prg")
  EviewsRGroup=basename(tempfile("EviewsRGroup"))



if(datelabel==""){
datelabel <- '%freq=@pagefreq
  if %freq="m" or %freq="M" then
  {%y}.datelabel format("YYYY")
  endif
  if %freq="D7" or %freq="D5"  or %freq="d5"  or %freq="d7" then
  {%y}.datelabel format("Mon YYYY")
  endif'
}else{
datelabel=paste('{%y}.datelabel',datelabel)
}


  graph_procs=paste0("{%y}.",graph_procs)
  graph_procs=append(c('%allEviewsGraphs=@wlookup("*","graph")\n','for %y {%allEviewsGraphs}\n')
,c(datelabel,graph_procs,'next'))
  # graphProcs=wf=paste0(graphProcs)

  EviewsRGroup=paste0('%EviewsRGroup=',shQuote(EviewsRGroup))
   wf=paste0('%wf=',shQuote(wf))
    page=paste0("%page=",shQuote(page))
    # series=paste0("%z=@wlookup(",shQuote(paste(series,collapse = " ")),',"series")')
    series=paste(series,collapse = " ")
    series=paste0("%series=",shQuote(series))
    graph_command=paste0("%graph_command=",shQuote(graph_command))
    options=paste0("%options=",shQuote(options))
    mode=paste0("%mode=",shQuote(mode))
    file_name=paste0("%file_name=",shQuote(file_name))
    save_path=gsub("/","\\\\",save_path)
    save_path1=save_path
    save_path=paste0("%save_path=",shQuote(save_path))

    save_options=paste(save_options,collapse = ",")
    save_options=paste0("%save_options=",shQuote(save_options))

if (merge_graphs!=T){
eviews_code=r'(close @wf

if %wf<>"" then
wfopen {%wf}
endif

if %page<>"" then
pageselect {%page}
endif

if %mode<>"" then
%mode="mode="+%mode+","
string mode="mode="+%mode+","
endif


%z=@wlookup(%series,"series")
%graph_command=@wreplace(%graph_command,"* ","*")
%mode=@wreplace(%mode,"* ","*")
%file_name=@wreplace(%file_name,"* ","*")
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
endif


group {%EviewsRGroup} {%z}
!n={%EviewsRGroup}.@count

for !k=1 to {!n}
%x{!k}={%EviewsRGroup}.@seriesname({!k})


freeze({%mode}{%x{!k}}_graph_EviewsR) {%x{!k}}.{%graph_command}{%options}
next)'


save_code=r'(for !k=1 to {!n}
{%x{!k}}_graph_EviewsR.save{%save_options} {%save_path}{%x{!k}}_graph_EviewsR
next)'
}

    if (merge_graphs==TRUE){

eviews_code=r'(close @wf

if %wf<>"" then
wfopen {%wf}
endif

if %page<>"" then
pageselect {%page}
endif

if %mode<>"" then
%mode="mode="+%mode+","
string mode="mode="+%mode+","
endif

%z=@wlookup(%series,"series")
%graph_command=@wreplace(%graph_command,"* ","*")
%mode=@wreplace(%mode,"* ","*")
%file_name=@wreplace(%file_name,"* ","*")
%save_path=@wreplace(%save_path,"* ","*")
%save_path=@wreplace(%save_path,"/","\")
%save_options=@wreplace(%save_options,"* ","*")

if %save_options<>"" then
%save_options="("+%save_options+")"
endif

if %options<>"" then
%options="("+%options+")"
endif


group {%EviewsRGroup} {%z}
!n={%EviewsRGroup}.@count

%seriesNames=@replace(%z," ","")
freeze({%mode}{%seriesNames}_graph_EviewsR) {%EviewsRGroup}.{%graph_command}{%options})'

save_code=r'({%seriesNames}_graph_EviewsR.save{%save_options} {%save_path}{%seriesNames}_graph_EviewsR)'
}

writeLines(c(eviews_path(),EviewsRGroup,wf,page,series,graph_command,options,mode,file_name,save_path,save_options,eviews_code,graph_procs,save_code), fileName)

system_exec()
on.exit(unlink_eviews(),add = TRUE)

if(merge_graphs==TRUE){
  series1=paste(series1,collapse = "")
  eviews_graphics=list.files(pattern=paste0(series1,'_graph_eviewsr'))
  include_graphics(eviews_graphics)
}


if(merge_graphs!=TRUE){

  for (i in series1){
    eviews_graphics=list.files(pattern=paste0(i,'_graph_eviewsr'))
   include_graphics(eviews_graphics)
}
}

if (save==TRUE){
  if(save_path1!=""){
  if(!dir.exists(save_path1)) dir.create(save_path1,recursive = TRUE)
    for (i in series1){
    eviews_graphics=list.files(pattern=paste0(i,'_graph_eviewsr'))
    file.copy(eviews_graphics,save_path1,overwrite = T)
  unlink(eviews_graphics)
  }

  }

}else{
  for (i in series1){
    eviews_graphics=list.files(pattern=paste0(i,'_graph_eviewsr'))
    unlink(eviews_graphics)
  }

}

}


# NEXT IS TO REMOVE DATA WHEN ATTACHED TO THE NAME OF MERGED GRAPHS

# eviews_graph(wf="",page = "page",series="x y",mode = "overwrite",options = "m")
