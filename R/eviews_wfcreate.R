#' Create an `EViews` workfile from R
#'
#' Use this function to create an `EViews` workfile from R
#'
#' @usage eviews_wfcreate(source_description="",wf="",page="",prompt=F,frequency="",subperiod_opts="",start_date="",end_date="",
#' num_cross_sections=NA,num_observations=NA,save_path="")
#' @param wf Object or a character string representing the name of a workfile to be created
#' @param page Object or a character string representing the name of a workfile page to be created
#'
#' @param frequency Object or a character string representing the frequency of a workfile page to be created. Only letters accepted by EViews are allowed. For example \code{u} for undated, \code{a} for annual, \code{m} for monthly and so on.
#'
#' @param start_date Object or a character string representing the \code{start date}. It should be left blank for undated (when the \code{frequency} is \code{u}).
#'
#' @param end_date Object or a character string representing the \code{end date}. It should be left blank for undated (when the \code{frequency} is \code{u}).
#'
#' @inheritParams eviews_import
#' @param num_cross_sections Optional integer value. Include \code{num_cross_sections} in order to create an `EViews` balanced panel page using integer identifiers for each of the cross-sections.
#' @param subperiod_opts Optional integer value. Include \code{subperiod_opts} to define subperiod options for \code{frequency} argument.
#' @param num_observations Numeric value. Specify the number of observations if the \code{frequency="u"}.
#' @param save_path Specify where to save the `EViews` workfile.
#' @param prompt Logical, whether to force the dialog to appear from within an `EViews` program
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#' eviews_wfcreate(wf_name="EVIEWSR_WORKFILE",page_name="EVIEWSR_PAGE",frequency="m",start_date="1990m1",end_date="2021m4",path="",save=T)
#'}
#' @seealso eng_eviews, eviews_commands, eviews_graph, eviews_import, eviews_object, eviews_pagesave, eviews_rwalk, eviews_wfsave, export, import_table, import
#' @keywords documentation
#' @export
eviews_wfcreate=function(source_description="",wf="",page="",prompt=F,frequency="",subperiod_opts="",start_date="",end_date="",num_cross_sections=NA,num_observations=NA,save_path=""){

  if(is.data.frame(source_description)){

    if(wf=="") wf=paste0(paste0(names(source_description),collapse = ""),"_EviewsR")

    save_path=gsub("/","\\\\",save_path)
    save_path1=save_path
    save_path=paste0("%save_path=",shQuote(save_path))

    # if(save_path1!=""){
    #   if(!dir.exists(save_path1)) dir.create(save_path1,recursive = T)
    #}

    csvFile=paste0(wf,".csv")
    write.csv(source_description,csvFile,row.names = FALSE)
    eviews_import(wf=wf,source_description = csvFile,start_date = start_date,frequency = frequency,save_path = save_path1)
    on.exit(unlink(csvFile),add = T)
  }else{

  fileName=tempfile("EVIEWS", ".", ".prg")

  #   wf=paste0('%wf=',shQuote(wf))
  # page=paste0("%page=",shQuote(page))
  # prompt=paste0("%prompt=",shQuote(prompt))
if(wf!="") wf=paste0("wf=",wf)
if(page!="") page=paste0("page=",wf)
if(prompt==T) prompt="prompt"
  options=paste(wf,page,prompt,collapse = ",")
  options=paste0("%options=",shQuote(options))

  frequency=paste0("%frequency=",shQuote(frequency))
  subperiod_opts=paste0("%subperiod_opts=",shQuote(subperiod_opts))
  start_date=paste0("%start_date=",shQuote(start_date))
  end_date=paste0("%end_date=",shQuote(end_date))
  # save=paste0("%save=",shQuote(save))
  save_path=gsub("/","\\\\",save_path)
  save_path1=save_path
  save_path=paste0("%save_path=",shQuote(save_path))
  num_cross_sections=paste0("!num_cross_sections=",num_cross_sections)
  num_observations=paste0("!num_observations=",num_observations)

  eviews_code=r'('%wf=@wreplace(%wf,"* ","*")
  '%page=@wreplace(%page,"* ","*")
  %subperiod_opts=@wreplace(%subperiod_opts,"* ","*")

  @stripcommas(%options)

  if %subperiod_opts<>"" then
  %subperiod_opts="("+%subperiod_opts+")"
  endif

  if %frequency="u" or %frequency="U" then
  wfcreate({%options}) {%frequency} {!num_observations}
  else
  wfcreate({%options}) {%frequency}{%subperiod_opts} {%start_date} {%end_date} {!num_cross_sections}
  endif

  if !num_cross_sections=NA then
  !num_cross_sections=1
  endif


  %wf=@wfname

  if %save_path<>"" then
  %save_path=%save_path+"\"
  endif

  wfsave {%save_path}{%wf}

  exit
  )'

writeLines(c(eviews_path(),options,save_path,frequency,subperiod_opts,start_date,end_date,num_cross_sections,num_observations,save_path,eviews_code),fileName)

  if(save_path1!=""){
    if(!dir.exists(save_path1)) dir.create(save_path1,recursive = T)
  }

  system_exec()
  on.exit(unlink_eviews(),add = TRUE)

}

}



# eviews_wfcreate(wf="smati",page="academy",frequency = "m",start_date = "1990",end_date = "2020",num_observations = 2,save_path = "eviews/path")
