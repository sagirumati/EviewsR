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
eviews_single_graph=function(graph_type="line",graph_options=c(),series=c(),wf_name="",page_name="",frequency="",start_date="",end_date="",path="",save=FALSE,merge=TRUE,align=c(2,1,1)){
  stopifnot("EViewsR works on Windows only"=Sys.info()["sysname"]=="Windows")
  #stopifnot("Please enter at least one series name"=!is.null(series),series!="",series!=" ",series %in% letters | series %in% LETTERS)
  stopifnot("Please enter at least one series name"=series %in% letters | series %in% LETTERS,!is.null(series))
  fileName=tempfile("EVIEWS", ".", ".prg")
  if(wf_name!="" & page_name!=""){
    #code1=paste(paste0("wfopen ",wf_name,"@char(13)","pageselect ",page_name,"@chr(13)","%z=@wlookup(",series,'"series")"',"@chr(13)",))
    code1=paste0("wfopen ",wf_name)
    code2=paste0("pageselect ",page_name)
    code3=paste0("%z=@wlookup(",'"',paste(series,collapse = " "),'"',',"series"',")")
  code4=ifelse(is.null(graph_options),paste0('%graphType="',graph_type,'"'),paste0('%graphType="',graph_type,'(',paste0(graph_options,collapse = ","),')"'))
    code5='if %z="" then
            %z=""
    else
        for %y {%z}
      graph graph_{%y}.{%graphType} {%y}
      next
endif'
    if(merge==TRUE){
      stopifnot('Length of the "series" must be at least 2'=length(series)>=2)
      #series=paste0(gsub(" ","_",series),collapse ="_") #if SERIES is space-delimited, replace with SPACE with "_", if SERIES is a vector of strings,separate the strings with "_".
      code6='%mergeName="graphs_of_"+@replace(%z," ","_")'
      code7='%z=@wlookup("graph_*","graph")'
      code8="graph {%mergeName}.merge {%z}"
      code9=paste0("{%mergeName}.align(",paste0(align,collapse =","),")")}else{
#If MERGE!=TRUE
        code6=""
        code7=""
        code8=""
        code9=""

    }


if(save==T){
      condition='save(t=%type) {%save_path}{%save_name}'
    } else{
      condition=""
    }
      writeLines(c("%path=@runpath","cd %path",code1,code2,code3,code4,code5,code6,code7,code8,code9), fileName)
  shell(fileName)
on.exit(unlink(fileName))
  }
}

# if (merge==TRUE){
#   include_graphics("")
# }
