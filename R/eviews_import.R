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
eviews_import=function(type="",options="",source_description="",smpl_string="",genr_string="",rename_string="",frequency="",start_date="",id="",destid="",append=T){
  fileName=tempfile("EVIEWS", ".", ".prg")
  options=paste0('%options=',shQuote(options))
  source_description=gsub("/","\\\\",source_description)
  source_description=paste0("%source_description=",shQuote(source_description))
  smpl_string=paste0("%smpl_string=",shQuote(smpl_string))
  genr_string=paste0("%genr_string=",shQuote(genr_string))
  rename_string=paste0("%rename_string=",shQuote(rename_string))
  frequency=paste0("%frequency=",shQuote(frequency))
  start_date=paste0("%start_date=",shQuote(start_date))
  id=paste0("%id=",shQuote(id))
  destid=paste0("%save=",shQuote(destid))
  append=paste0("%append=",shQuote(append))

  eviews_code=r'(%path=@runpath
  cd %path


  if %type<>"" then
  %type="type="+%type   'to avoid error if %TYPE=""
  endif


  if %option<>"" then
  %option="option="+%option   'to avoid error if %option=""
  endif

  if %smpl_string<>"" then
  %smpl_string="@smpl "+%smpl_string 'change %SMPL_STRING to @SMPL %SMPL_STRING if %SMPL_STRING<>""
  endif

  if %genr_string<>"" then
  %genr_string="@genr "+%genr_string
  endif

  if %rename_string<>"" then
  %rename_string="@rename "+%rename_string
  endif

  'Determine the IMPORT_SPECIFICATION for DATED

  if %frequency<>"" or %start_date<>"" then
  %import_type="dated"
  %import_specification="@freq "+%frequency+" "+%start_date
  endif

  if %id<>"" or %destid<>"" then
  %import_type="match-merged"
  %import_specification="@id "+%id+" @destid"+" "+%destid
  endif

  if (%append="T" or %append="TRUE") and %id="" and %destid="" and %frequency="" and %start_date="" then
  %import_type="appended"
  %import_specification="@append"
  endif

  if %id="" and %destid="" and %import_specification=""  then
  %import_type="sequential"
  %import_specification=""
  endif



  'OPTIONAL_ARGUMENTS=@smpl {%smpl_string} @genr {%genr_string} @rename {%rename_string}


  %optional_arguments=%smpl_string+" "+%genr_string+" "+%rename_string
  if %import_type="appended" then
  %optional_arguments=%genr_string+" "+%rename_string 'APPENDED syntax does not contain @SMPL_STRING
  endif
  'GENERAL
  import({%type}, {%options}) {%source_description} {%import_specification} {%optional_arguments}
  )'

writeLines(c(type,options,source_description,smpl_string,genr_string,rename_string,frequency,start_date,id,destid,append,eviews_code),fileName)
  system2("EViews",paste("run(c,q)",fileName))
  on.exit(unlink(fileName))
}


# eviews_import(source_description = "eviews/somefilename.csv",start_date = "1990",frequency = " m",rename_string = " series01 ab",smpl_string = "1990m10 1992m10")
