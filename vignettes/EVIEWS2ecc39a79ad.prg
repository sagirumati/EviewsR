%eviews_path="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR\vignettes"
cd %eviews_path
%chunkLabel="eviewsGraph1-"
%eviewsrText="EVIEWS2ecc39a79ad"
%EviewsRGroup="EviewsRGroup2ecc29c117"
%wf="eviewsGraph1"
%page="*"
%series="x y"
%graph_command="line"
%graph_options=""
%mode="overwrite"
%save_path="C:/Users/SMATI/AppData/Local/Temp/RtmpaE4Sxo/preview-b742e3c156f.dir/EviewsR_files/figure-html/"
%save_options="t=png,d=300"
close @wf

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
endif
if %page="*" then
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
      freeze({%mode}{%seriesNames}_{%eviewsrText}) {%EviewsRGroup}.{%graph_command}{%graph_options}
      endif
      next
      

  %pagelist=@pagelist

  if %page<>"*" then
  %pagelist=%page
  endif


  for %page {%pagelist}
  pageselect {%page}
  %selectedGraphs=@wlookup("*","graph")
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
  
if %page="*" then
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
      {%seriesNames}_{%eviewsrText}.save{%save_options} {%save_path}{%chunkLabel}{%page}-{%seriesNames}
      %graphPath=%graphPath+" "+%chunkLabel+%page+"-"+%seriesNames
      endif
      delete {%EviewsrGroup}
      next


      text {%eviewsrText}_graph
      {%eviewsrText}_graph.append {%graphPath}
      {%eviewsrText}_graph.save  {%eviewsrText}-graph
      exit
