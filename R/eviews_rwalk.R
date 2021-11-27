#' Simulate a random walk process using an `EViews` engine from R.
#'
#' Use this function to simulate a random walk process using an `EViews` engine.
#'
#' @usage eviews_wfcreate(wf_name="",page_name="",frequency="",start_date="",end_date="",path="",save=T)
#' @inheritParams eviews_wfcreate
#' @param drift Numeric value as the drift term for random walk.
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#' eviews_wfcreate(wf_name="EVIEWSR_WORKFILE",page_name="EVIEWSR_PAGE",frequency="m",start_date="1990m1",end_date="2021m4",path="",save=T)
#'}
#' @seealso eng_eviews, eviews_commands, eviews_graph, eviews_import, eviews_object, eviews_pagesave, eviews_rwalk, eviews_wfcreate, eviews_wfsave, export, import_table, import
#' @keywords documentation
#' @export
eviews_rwalk=function(wf="",page="",series="",drift=NA,rndseed=NA,frequency="m",start_date="1990",end_date="2020",num_observations=1){

  fileName=tempfile("EviewsR", ".", ".prg")

  if(wf=="") {
   wf=basename(gsub(".prg","",fileName))
     eviews_wfcreate(wf=wf,page=wf,frequency=frequency,start_date=start_date,end_date=end_date,num_observations = num_observations)
  }

  wf1=paste0(wf,".wf1")
  wf=paste0('%wf=',shQuote(wf))
  page=paste0('%page=',shQuote(page))
  rndseed=paste0('!rndseed=',rndseed)
  drift=paste0("!drift=",drift)

  series1=paste(series,collapse = "") %>%  gsub(" ","",.)
  series=paste0("%series=",shQuote(paste(series,collapse = " ")))

    eviews_code=r'(
    if %wf<>"" then
    open {%wf}
    endif

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

    if !drift<>NA then
    genr {%x{!k}}_drift={!drift}+{%x{!k}}
    endif

    smpl @all
    next

    %drift_series=@wlookup("*drift","series")
    group randomwalk_group_drift {%drift_series}

    if !drift<>NA then
    pagesave randomwalk_group.csv @keep randomwalk_group_drift
    else
    pagesave randomwalk_group.csv @keep randomwalk_group
    endif

    exit)'

  writeLines(c(eviews_path(),wf,page,rndseed,drift,series,eviews_code),fileName)
    system_exec()
    on.exit(unlink_eviews(),add = TRUE)
    on.exit(unlink(c("randomwalk_group.csv")),add = TRUE)
    on.exit(unlink(wf1),add = TRUE)

    # if(options$label!="") series1=options$label else series1=series1
    assign(series1,read.csv("randomwalk_group.csv"),envir = ev)


}


# eviews_rwalk(wf="",series="X Y Z",page="",rndseed=NA,num_observations=1)
