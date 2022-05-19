#' Import data to `EViews` workfile
#'
#' Use this function to import data to `EViews` workfile from R
#'
#' @usage eviews_import(source_description="",wf="",type="",options="",smpl_string="",
#' genr_string="",rename_string="",frequency="",start_date="",id="",destid="",
#' append=FALSE,save_path="")
#' @inheritParams eviews_graph
#' @inheritParams eviews_wfcreate
#' @param type Optional. Specify the file type, it can values allowed by `EViews` \code{import} commands like \code{access}, \code{text}. For the most part, you should not need to specify a “type=” option as EViews will automatically determine the type from the filename.
#' @param save_path Specify the path to save the `Eviews` workfile
#' @param options Optional.Specify the `EViews` \code{options} for \code{import} command like \code{resize}, \code{link}, \code{page=page_name}.
#' @param source_description Description of the file from which the data is to be imported. The specification of the description is usually just the path and file name of the file.
#' @param smpl_string Optional. Specify the sample to be used for the data import.
#' @param genr_string Optional. Any valid `EViews` series creation expression to be used to generate a new series in the workfile as part of the import procedure.
#' @param id Name of `EViews` ID series. Required for `EViews` \code{Match-Merge Import}.
#' @param destid Name of the destination ID.  Required for `EViews` \code{Match-Merge Import}.
#' @param append Logical, whether to append to the bottom of the `EViews` workfile page or not.
#' @param rename_string Optional. Pairs of old object names followed by the new name to be used to rename some of the imported series.
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#' x=runif(100); y=runif(100); data=data.frame(x,y)
#' write.csv(data,"EviewsR_eviews_import.csv",row.names = FALSE)
#'
#' eviews_import(source_description = "EviewsR_eviews_import.csv",start_date = "1990",frequency = "m",
#' rename_string = "x ab",smpl_string = "1990m10 1992m10")
#'
#' Alternatively, use the dataframe as the source_description
#'
#' eviews_import(source_description = data,wf="EviewsR_eviews_import1",start_date = "1990",
#' frequency = "m",rename_string = "x ab",smpl_string = "1990m10 1992m10")
#'}
#' @family important functions
#' @keywords documentation
#' @export
eviews_import=function(source_description="",wf="",type="",options="",smpl_string="",genr_string="",rename_string="",frequency="",start_date="",id="",destid="",append=FALSE,save_path=""){

  if(is.data.frame(source_description)){
    if(wf=="") wf=paste0(paste0(names(source_description),collapse = ""),"_EviewsR")
    csvFile=paste0(wf,".csv")
    write.csv(source_description,csvFile,row.names = FALSE)

    source_description=csvFile

    on.exit(unlink(csvFile),add = T)
  }


    fileName=tempfile("EVIEWS", ".", ".prg")
  options=paste0('%options=',shQuote_cmd(options))
  # source_description=gsub("/","\\\\",source_description)
  source_description=paste0("%source_description=",shQuote_cmd(source_description))
  smpl_string=paste0("%smpl_string=",shQuote_cmd(smpl_string))
  genr_string=paste0("%genr_string=",shQuote_cmd(genr_string))
  rename_string=paste0("%rename_string=",shQuote_cmd(rename_string))
  frequency=paste0("%frequency=",shQuote_cmd(frequency))
  start_date=paste0("%start_date=",shQuote_cmd(start_date))
  id=paste0("%id=",shQuote_cmd(id))
  destid=paste0("%destid=",shQuote_cmd(destid))
  append=paste0("%append=",shQuote_cmd(append))
  wf=paste0("%wf=",shQuote_cmd(wf))
  save_path1=save_path
  save_path=paste0("%save_path=",shQuote_cmd(save_path))

  eviews_code=r'(
  if %type<>"" then
  %type="type="+%type+","   'to avoid error if %TYPE=""
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
  'open {%wf}
  %import_specification="@id "+%id+" @destid"+" "+%destid
  endif

  if (%append="T" or %append="TRUE") and %id="" and %destid="" and %frequency="" and %start_date="" then
  %import_type="appended"
  open {%wf}
    %import_specification="@append"
  endif

  if %id="" and %destid="" and %import_specification=""  then
  %import_type="sequential"
  'open {%wf}
  %import_specification=""
  endif



  'OPTIONAL_ARGUMENTS=@smpl {%smpl_string} @genr {%genr_string} @rename {%rename_string}


  %optional_arguments=%smpl_string+" "+%genr_string+" "+%rename_string
  if %import_type="appended" then
  'open {%wf}
  %optional_arguments=%genr_string+" "+%rename_string 'APPENDED syntax does not contain @SMPL_STRING
  endif
  'GENERAL
  import({%type}{%options}) {%source_description} colhead=1  {%import_specification} {%optional_arguments}

  %wf=@wfname

  if %save_path<>"" then
  %save_path=%save_path+"/"
  endif

  wfsave {%save_path}{%wf}

exit
  )'

writeLines(c(eviews_path(),wf,save_path,type,options,source_description,smpl_string,genr_string,rename_string,frequency,start_date,id,destid,append,eviews_code),fileName)


  if(save_path1!=""){
    if(!dir.exists(save_path1)) dir.create(save_path1,recursive = T)
  }

  system_exec()
  on.exit(unlink_eviews(),add = TRUE)
}


# eviews_import(source_description = "eviews/somefilename.csv",start_date = "1990",frequency = " m",rename_string = " series01 ab",smpl_string = "1990m10 1992m10")
