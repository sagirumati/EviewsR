#' Create an `EViews` graph in R, R Markdown and Quarto.
#'
#' Use this function to create an `EViews` graph in R and R Markdown
#'
#' @param series A vector of names or wildcard expressions for series object(s) contained in an `EViews` workfile. An R dataframe is also acceptable.
#' @param save_copy Logical. Whether to save the copy of the graph objects.
#' @param wf Object or a character string representing the name of an `EViews` workfile.
#' @param save_options A vector of options to be passed to `EViews` \code{save} command. It can take values like \code{"t=png"},\code{-c} and so on.
#' @param page Object or a character string representing the name of an `EViews` workfile page.
#' @param mode Set `mode="overwrite"` to overwrite existing `EViews` graph objects that match the new `EViews` graph object to be created on the workfile. Set `mode=""` to avoid overwriting exising `EViews` graph object.
#' @param graph_command Object or a character string of any of the acceptable `EViews` graphical commands, such as \code{line}, \code{bar}, \code{pie}.
#' @param graph_options Object or a character string of any of the acceptable `EViews` graphical options, such as \code{""}, \code{m}, \code{s}.
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
#' eviews_graph(wf="EviewsR_exec_commands",page = "page",series="x y",mode = "overwrite",
#' graph_options = "m")
#'
#' Data=data.frame(x=cumsum(rnorm(100)),y=cumsum(rnorm(100)))
#' eviews_graph(series=Data,start_date=1990,frequency="m")
#'}
#' @family important functions
#' @keywords documentation
#' @export
eviews_graph=function(wf="",page="*",series="*",group=FALSE,graph_command="line",graph_options="",mode="overwrite",graph_procs="",datelabel="",save_options='',save_path="",frequency="m",start_date="",save_copy=FALSE){

if(wf!="" && save_path=="") save_path=dirname(wf)
  graphicsDefault=r'(
  if %page="*" then
  %pagelist=@pagelist
  endif

  if %page<>"*" then
  %pagelist=%page
  endif


  for %page {%pagelist}
  pageselect {%page}
  %selectedGraphs=@wlookup(%graph,"graph")
  if @wcount(%selectedGraphs)>0 then
  for %y {%selectedGraphs}
  {%y}.axis(l) font(Calibri,14,-b,-i,-u,-s)
  {%y}.axis(r) font(Calibri,14,-b,-i,-u,-s)
  {%y}.axis(b) font(Calibri,14,-b,-i,-u,-s)
  {%y}.axis(t) font(Calibri,14,-b,-i,-u,-s)
  {%y}.legend columns(5) inbox position(BOTCENTER) font(Calibri,12,-b,-i,-u,-s)
  {%y}.options antialias(on)
  {%y}.options size(6,3)
  {%y}.options -background frameaxes(all) framewidth(0.5)
  {%y}.setelem(1) linecolor(@rgb(57,106,177)) linewidth(1.5)
  {%y}.setelem(2) linecolor(@rgb(218,124,48)) linewidth(1.5)
  {%y}.setelem(3) linecolor(@rgb(62,150,81)) linewidth(1.5)
  {%y}.setelem(4) linecolor(@rgb(204,37,41)) linewidth(1.5)
  {%y}.setelem(5) linecolor(@rgb(83,81,84)) linewidth(1.5)
  {%y}.setelem(6) linecolor(@rgb(107,76,154)) linewidth(1.5)
  {%y}.setelem(7) linecolor(@rgb(146,36,40)) linewidth(1.5)
  {%y}.setelem(8) linecolor(@rgb(148,139,61)) linewidth(1.5)
  {%y}.setelem(9) linecolor(@rgb(255,0,255)) linewidth(1.5)
  {%y}.setelem(10) linewidth(1.5)
  {%y}.setelem(11) linecolor(@rgb(192,192,192)) linewidth(1.5)
  {%y}.setelem(12) linecolor(@rgb(0,255,255)) linewidth(1.5)
  {%y}.setelem(13) linecolor(@rgb(255,255,0)) linewidth(1.5)
  {%y}.setelem(14) linecolor(@rgb(0,0,255)) linewidth(1.5)
  {%y}.setelem(15) linecolor(@rgb(255,0,0)) linewidth(1.5)
  {%y}.setelem(16) linecolor(@rgb(0,127,0)) linewidth(1.5)
  {%y}.setelem(17) linecolor(@rgb(0,0,0)) linewidth(1.5)
  {%y}.setelem(18) linecolor(@rgb(0,127,127)) linewidth(1.5)
  {%y}.setelem(19) linecolor(@rgb(127,0,127)) linewidth(1.5)
  {%y}.setelem(20) linecolor(@rgb(127,127,0)) linewidth(1.5)
  {%y}.setelem(21) linecolor(@rgb(0,0,127)) linewidth(1.5)
  {%y}.setelem(22) linecolor(@rgb(255,0,255)) linewidth(1.5)
  {%y}.setelem(23) linecolor(@rgb(127,127,127)) linewidth(1.5)
  {%y}.setelem(24) linecolor(@rgb(192,192,192)) linewidth(1.5)
  {%y}.setelem(25) linecolor(@rgb(0,255,255)) linewidth(1.5)
  {%y}.setelem(26) linecolor(@rgb(255,255,0)) linewidth(1.5)
  {%y}.setelem(27) linecolor(@rgb(0,0,255)) linewidth(1.5)
  {%y}.setelem(28) linecolor(@rgb(255,0,0)) linewidth(1.5)
  {%y}.setelem(29) linecolor(@rgb(0,127,0)) linewidth(1.5)
  {%y}.setelem(30) linecolor(@rgb(0,0,0)) linewidth(1.5)
  {%y}.setfont legend(Calibri,12,-b,-i,-u,-s) text(Calibri,14,-b,-i,-u,-s) obs(Calibri,14,-b,-i,-u,-s) axis(Calibri,14,-b,-i,-u,-s)
  {%y}.setfont obs(Calibri,14,-b,-i,-u,-s)
  {%y}.textdefault font(Calibri,14,-b,-i,-u,-s)
  next
  endif
  next
  )'



  chunkLabel=opts_current$get("label")

  if(!is.null(chunkLabel)) chunkLabel= gsub("^fig-","",chunkLabel)

  # if(wf=="") wf=page=tempfile('EviewsrR','.') %>% basename

  if(is.data.frame(series)) series1=names(series) else series1=series

  if(group) {
    if(grepl("date",series1[1])) series1=series1[-1]
    series1=paste0(series1,collapse = "")
  }

   if(group & length(series1)==1) series1=gsub(" ","",series1)

  if(!group & length(series1)==1){
    series1=trimws(series1)
    series1=unlist(strsplit(series1,split=" "))
  }

  if(is.data.frame(series)) {

    wf=chunkLabel %n% "EViewsR"
    wf=gsub("[.-]","_",wf)
    wf1=wf
    csvFile=paste0(wf,".csv")
        write.csv(series,csvFile,row.names = F)
        eviews_import(wf=wf,source_description = csvFile,frequency = frequency,start_date = start_date,save_path = save_path)
# export_dataframe(source_description = series,wf=wf,start_date = start_date,frequency = frequency)
        series = names(series)

        on.exit(unlink(c(csvFile,paste0(wf1,".wf1")),force = T),add = T)
}

  dev=opts_current$get('dev')

  if(!is.null(dev) && dev=="png" && save_options=='') save_options="t=png,d=300"
  if(!is.null(dev) && dev=="pdf" && save_options=='') save_options="t=pdf"
  if(is.null(dev) && save_options=='') save_options="t=png,d=300"

# Append "d=300" if "d=" (dpi) is not defined in "save_options"

    save_options1=c("t=bmp","t=gif", "t=jpg", "t=png")

    if(length(intersect(save_options,save_options1)>0)){
    if(intersect(save_options,save_options1) %in% save_options1 & sum(grepl("\\s*d\\s*=",save_options, ignore.case = T))==0) save_options=append(save_options,"d=300")
    }

    save_options2=paste0(save_options,collapse=",") %>% trimws() %>%  gsub('[[:blank:]]','',.) %>% strsplit(split=",") %>% unlist()

    extensions= c("t=emf", "t=wmf", "t=eps", "t=bmp", "t=gif", "t=jpg", "t=png", "t=pdf", "t=tex", "t=md")

    extension=intersect(extensions,save_options2) %>% gsub('t=','',.)

    if(length(extension)==0) extension="emf"


        fileName=tempfile("EVIEWS", ".", ".prg")
  EviewsRGroup=basename(tempfile("EviewsRGroup"))

  eviewsrText=gsub("\\.prg$",'',fileName) %>% basename
  eviewsrText1=eviewsrText
  eviewsrText %<>%
    shQuote_cmd %>% paste0('%eviewsrText=',.)


if(group && graph_options=='m') {
  align='align(2,0.5,1)'
graph_procs=append(align,graph_procs)
}

if(!identical(graph_procs,"")){
  graph_procs=paste0("{%y}.",graph_procs)
  graph_procs=append(c('for %page {%pagelist}
pageselect {%page}
%selectedGraphs=@wlookup("*","graph")
if @wcount(%selectedGraphs)>0 then
for %y {%selectedGraphs}')
,c(graph_procs,'next','endif','next'))
}

  if(any(grepl("^\\s*$", graph_procs))) graph_procs=graph_procs[-grep("^\\s*$",graph_procs)]


  EviewsRGroup=paste0('%EviewsRGroup=',shQuote_cmd(EviewsRGroup))
   wf=paste0('%wf=',shQuote_cmd(wf))
    page=paste0("%page=",shQuote_cmd(page))
    series=paste(series,collapse = " ")
    series=paste0("%series=",shQuote_cmd(series))
    graph_command=paste0("%graph_command=",shQuote_cmd(graph_command))
    graph_options=paste0("%graph_options=",shQuote_cmd(graph_options))
    mode=paste0("%mode=",shQuote_cmd(mode))




    if(is.null(chunkLabel)) chunkLabel1="" else chunkLabel1=paste0(chunkLabel,"-")
        if(is.null(chunkLabel)) chunkLabel="" else chunkLabel=paste0(chunkLabel,'-') %>%
      shQuote_cmd() %>% paste0('%chunkLabel=',.)


    save_path=gsub("/","\\\\",save_path)

    save_path=opts_current$get("fig.path") %n% save_path

        if(save_path!="" && !dir.exists(save_path)) dir.create(save_path,recursive = TRUE)

    save_path1=ifelse(save_path=="",".",save_path)
    save_path=paste0("%save_path=",shQuote_cmd(save_path))

    save_options=paste(save_options,collapse = ",")
    save_options=paste0("%save_options=",shQuote_cmd(save_options))


eviewsCode=r'(close @wf

if %wf<>"" then
wfopen {%wf}
endif


if %mode<>"" then
%mode="mode="+%mode+","
endif


%allSeries=@wlookup(%series,"series")
%allSeries=@wdrop(%allSeries,"DATE")
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

if %graph_options<>"" then
%graph_options="("+%graph_options+")"
endif)'



if (!group){

  freezeCode=r'(if %page="*" then
  %pagelist=@pagelist
  endif

  if %page<>"*" then
  %pagelist=%page
  endif

for %page {%pagelist}
pageselect {%page}
  %allSeries=@wlookup(%series,"series")
  %allSeries=@wdrop(%allSeries,"DATE")
  if @wcount(%allSeries)>0 then
  group {%EviewsRGroup} {%allSeries}
  !n={%EviewsRGroup}.@count

  for !k=1 to {!n}
  %x{!k}={%EviewsRGroup}.@seriesname({!k})


  freeze({%mode}{%x{!k}}_graph_EviewsR) {%x{!k}}.{%graph_command}{%graph_options}
  next
  endif
  next
  )'


  saveCode=r'(%graphPath=""
  for %page {%pagelist}
  pageselect {%page}
  %allSeries=@wlookup(%series,"series")
  %allSeries=@wdrop(%allSeries,"DATE")
  if @wcount(%allSeries)>0 then
  group {%EviewsRGroup} {%allSeries}
  !n={%EviewsRGroup}.@count

  for !k=1 to {!n}
  %x{!k}={%EviewsRGroup}.@seriesname({!k})
  {%x{!k}}_graph_EviewsR.save{%save_options} {%save_path}{%chunkLabel}{%page}-{%x{!k}}
  %graphPath=%graphPath+" "+%chunkLabel+%page+"-"+%x{!k}
  next
  delete {%EviewsrGroup}
  endif
  next


  text {%eviewsrText}_graph
  {%eviewsrText}_graph.append {%graphPath}
  {%eviewsrText}_graph.save  {%eviewsrText}-graph
  exit)'
}

if (group){

      freezeCode=r'(if %page="*" then
      %pagelist=@pagelist
      endif

      if %page<>"*" then
      %pagelist=%page
      endif

      for %page {%pagelist}
      pageselect {%page}
      %allSeries=@wlookup(%series,"series")
      %allSeries=@wdrop(%allSeries,"DATE")
      if @wcount(%allSeries)>0 then
      group {%EviewsRGroup} {%allSeries}

      %seriesNames=@replace(%allSeries," ","")
     ' %seriesNames=%seriesNames
      freeze({%mode}{%seriesNames}_graph_EviewsR) {%EviewsRGroup}.{%graph_command}{%graph_options}
      endif
      next
      )'

      saveCode=r'(if %page="*" then
      %pagelist=@pagelist
      endif

      if %page<>"*" then
      %pagelist=%page
      endif

      %graphPath=""

      for %page {%pagelist}
      pageselect {%page}
      %allSeries=@wlookup(%series,"series")
      %allSeries=@wdrop(%allSeries,"DATE")
      if @wcount(%allSeries)>0 then
      {%seriesNames}_graph_EviewsR.save{%save_options} {%save_path}{%chunkLabel}{%page}-{%seriesNames}
      %graphPath=%graphPath+" "+%chunkLabel+%page+"-"+%seriesNames
      endif
      delete {%EviewsrGroup}
      next


      text {%eviewsrText}_graph
      {%eviewsrText}_graph.append {%graphPath}
      {%eviewsrText}_graph.save  {%eviewsrText}-graph
      exit)'
      }

writeLines(c(eviews_path(),chunkLabel,eviewsrText,EviewsRGroup,wf,page,series,graph_command,graph_options,mode,save_path,save_options,eviewsCode,freezeCode,graphicsDefault,graph_procs,saveCode), fileName)

system_exec()
on.exit(unlink_eviews(),add = TRUE)

on.exit(unlink(paste0(eviewsrText1,"-graph.txt")),add = TRUE)


if(file.exists(paste0(eviewsrText1,"-graph.txt"))) graphPath=readLines(paste0(eviewsrText1,"-graph.txt")) %>%
  strsplit(split=" ") %>% unlist()

eviewsGraphics=paste0(save_path1,'/',graphPath,'.',extension)
include_graphics(eviewsGraphics)
}


