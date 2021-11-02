#' Create an `EViews` workfile from R
#'
#' Use this function to create an `EViews` workfile from R
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
#' eviews_wfcreate(wf_name="EVIEWSR_WORKFILE",page_name="EVIEWSR_PAGE",frequency="m",start_date="1990m1",end_date="2021m4",path="",save=T)
#'}
#' @seealso eng_eviews
#' @keywords documentation
#' @export
eviews_rwalk=function(wf="",page="",series="",rndseed=NA){

  fileName=tempfile("EVIEWS", ".", ".prg")

  wf=paste0('%wf=',shQuote(wf))
  page=paste0('%page=',shQuote(page))
  rndseed=paste0('!rndseed=',rndseed)
  series=paste0('%series=',shQuote(series))

    eviews_code=r'(%runpath=@runpath
    cd %runpath
    open {%wf}

    if %page<>"" then
    pageselect {%page}
    endif

    for %y {%series}
    series {%y}
    next

    group randomwalk_group {%series}
    !n=randomwalk_group.@count


    if !rndseed<>NA then
    ' White noise
    'Seed the generator, so each run is the same
    rndseed {!rndseed}
    endif

    'Generate a white noise series (in this case, of normals)
    for !i=1 to !n
    series wn{!i}=nrnd
    next


    for !k=1 to {!n}
    %x{!k}=randomwalk_group.@seriesname({!k})
    ' Random walks
    ' Declare new series, set equal to wn1
    series {%x{!k}}=wn{!k}
    ' Change sample period
    smpl @first+1 @last
    {%x{!k}}={%x{!k}}+{%x{!k}}(-1)
    smpl @all
    next

    randomwalk_group.line)'
# path=here()
   path=getwd()
writeLines(c(wf,page,rndseed,series,eviews_code),fileName)
  system2("EViews",paste0("run(c,q)",shQuote(paste0(path,"/",fileName))))
  on.exit(unlink(fileName))
}


# eviews_rwalk(wf="eviews/workfile",series="X Y Z",page="",rndseed=NA)
