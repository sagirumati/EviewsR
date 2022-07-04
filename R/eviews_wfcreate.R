#' Create an `EViews` workfile from R
#'
#' Use this function to create an `EViews` workfile from R
#'
#' @usage eviews_wfcreate(source_description="",wf="",page="",prompt=F,frequency="",
#' subperiod_opts="",start_date="",end_date="",num_cross_sections=NA,num_observations=NA,
#' save_path="")
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
#' eviews_wfcreate(wf="EviewsR_eviews_wfcreate",page="EviewsR_page",frequency = "m",
#' start_date = "1990",end_date = "2022")
#'}
#' @family important functions
#' @keywords documentation
#' @export
eviews_wfcreate=function(source_description="",wf="",page="",prompt=F,frequency="",subperiod_opts="",start_date="",end_date="",num_cross_sections=NA,num_observations=NA,save_path=""){

  if(toupper(frequency)=="U" & is.na(num_observations)) stop("If 'frequency=\"u\"' (undated workfile),'num_observations' cannot be NA or blank")
  if(toupper(frequency)!="U" & (start_date=="" & is.na(num_observations))) stop("If 'frequency' is not equal to \"u\" (dated workfile),'start_date' and 'num_observations' cannot be blank or NA")
  if(toupper(frequency)!="U" & (start_date!="" & end_date=="" & is.na(num_observations))) stop("If 'frequency' is not equal to \"u\" (dated workfile) and 'start_date' is not blank, then 'end_date' or 'num_observations' cannot be blank or NA")

  if(end_date!="" & !is.na(num_observations)) stop("Please set the value of either 'end_date=\"\"' or  'num_observations=NA'.")

  if(start_date!="" && !is.na(num_observations) && end_date=="") end_date=paste0('+',num_observations)

  save_path=gsub("/","\\\\",save_path)
  save_path1=save_path
  save_path=paste0("%save_path=",shQuote_cmd(save_path))

   if(save_path1!=""){
     if(!dir.exists(save_path1)) dir.create(save_path1,recursive = T)
  }

if(is.data.frame(source_description)){

    if(wf=="") wf=paste0(paste0(names(source_description),collapse = ""),"_Workfile")

    csvFile=paste0(wf,".csv")
    write.csv(source_description,csvFile,row.names = FALSE)
    eviews_import(wf=wf,source_description = csvFile,start_date = start_date,frequency = frequency,save_path = save_path1)
    on.exit(unlink(csvFile),add = T)
  }else{

  fileName=tempfile("EVIEWS", ".", ".prg")

if(wf=="") wf=basename(gsub(".prg","",fileName))
if(page=="") page=wf
if(prompt==T) prompt="prompt"

wf=paste0("wf=",wf)
page=paste0("page=",page)

  options=paste(wf,page,prompt,sep = ",")
  options=paste0("%options=",shQuote_cmd(options))

  frequency=paste0("%frequency=",shQuote_cmd(frequency))
  subperiod_opts=paste0("%subperiod_opts=",shQuote_cmd(subperiod_opts))
  start_date=paste0("%start_date=",shQuote_cmd(start_date))
  end_date=paste0("%end_date=",shQuote_cmd(end_date))
  num_cross_sections=paste0("!num_cross_sections=",num_cross_sections)
  num_observations=paste0("!num_observations=",num_observations)


  eviewsCode=r'(%wf=@wreplace(%wf,"* ","*")
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

writeLines(c(eviews_path(),options,save_path,frequency,subperiod_opts,start_date,end_date,num_cross_sections,num_observations,save_path,eviewsCode),fileName)


  system_exec()
  on.exit(unlink_eviews(),add = TRUE)

}

}



# eviews_wfcreate(wf="smati",page="academy",frequency = "m",start_date = "1990",end_date = "2020",num_observations = 2,save_path = "eviews/path")
