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
#' @seealso eng_eviews
#' @keywords documentation
#' @export
eviews_graph=function(series=c(),wf="",page="",mode="",graph_command="line",options=c(),dev="png",frequency="",start_date="",end_date="",save=FALSE,save_path="",file_name="",merge=TRUE,align=c(2,1,1)){
  #stopifnot("EViewsR works on Windows only"=Sys.info()["sysname"]=="Windows")
  # stopifnot("Please enter at least one series name"=!is.null(series),series!="",series!=" ",series %in% letters | series %in% LETTERS)
  #stopifnot("Please enter at least one series name"=series %in% letters | series %in% LETTERS,!is.null(series))
  fileName=tempfile("EVIEWS", ".", ".prg")
  # if(wf_name!="" & page_name!=""){
    #code1=paste(paste0("wfopen ",wf_name,"@char(13)","pageselect ",page_name,"@chr(13)","%z=@wlookup(",series,'"series")"',"@chr(13)",))
    wf=paste0('%wf=',shQuote(wf))
    page=paste0("%page=",shQuote(page))
    # series=paste0("%z=@wlookup(",shQuote(paste(series,collapse = " ")),',"series")')
    series=paste0("%series=",shQuote(paste(series,collapse = " ")))
    graph_command=paste0("%graph_command=",shQuote(graph_command))
    options=paste0("%options=",shQuote(options))
    mode=paste0("%mode=",shQuote(mode))
    file_name=paste0("%file_name=",shQuote(file_name))
    save_path=gsub("/","\\\\",save_path)
    save_path=paste0("%save_path=",shQuote(save_path))

eviews_code=r'(%path=@runpath
cd %path
close @wf
wfopen {%wf}
pageselect {%page}
%z=@wlookup(%series,"series")
%graph_command=@wreplace(%graph_command,"* *","**")
%mode=@wreplace(%mode,"* *","**")
!mode=@isempty(%mode)
%file_name=@wreplace(%file_name,"* *","**")
%save_path=@wreplace(%save_path,"* ","*")
%save_path=@wreplace(%save_path,"/","\")
!save_path=@isempty(%save_path)
group EviewsR_group {%z}
!n=EviewsR_group.@count

for !k=1 to {!n}
%x{!k}=EviewsR_group.@seriesname({!k})

if %mode="overwrite" then
freeze(mode={%mode},{%x{!k}}_graph_EviewsR) {%x{!k}}.{%graph_command}
endif

if !mode=1 then
freeze({%x{!k}}_graph_EviewsR) {%x{!k}}.{%graph_command}
endif

if %save="TRUE" or %save="T" then
if !save_path=1 then
{%x{!k}}_graph_EviewsR.save(t={%dev}) {%x{!k}}_graph_EviewsR
endif
if !save_path=0 then
'%save_path=%save_path+"\"+%file_name
{%x{!k}}_graph_EviewsR.save(t={%dev}) {%save_path}\{%x{!k}}_graph_EviewsR
endif
endif
next

for %y {%z}

if %mode="overwrite" then
freeze(mode={%mode},graph_EviewsR) EviewsR_group.{%graph_command}({%options})
endif

if !mode=1 then
freeze(graph_EviewsR) EviewsR_group.{%graph_command}({%options})
endif


graph_EviewsR.align(2,1,1)
if %save="TRUE" or %save="T" then
if !save_path=1 then
graph_EviewsR.save(t={%dev}) %file_name
endif
if !save_path=0 then
graph_EviewsR.save(t={%dev}) {%save_path}\{%file_name}
endif
endif
next

%allGraphs=@wlookup("*","graph")
for %y {%allGraphs}
{%y}.textdefault font(Times New Roman,20,-b,-i,-u,-s)
%freq=@pagefreq
if %freq="m" or %freq="M" then
{%y}.datelabel format("YYYY")
endif
if %freq="D7" or %freq="D5"  or %freq="d5"  or %freq="d7" then
{%y}.datelabel format("Mon YYYY")
endif
next)'

writeLines(c("%path=@runpath","cd %path",wf,page,series,graph_command,options,mode,file_name,save_path,eviews_code), fileName)
  system2("EViews",paste("run(c,q)",fileName))
on.exit(unlink(fileName))
}


# eviews_graph(wf="eviews/workfile",page = "page",series="x y",mode = "overwrite",options = "m")
