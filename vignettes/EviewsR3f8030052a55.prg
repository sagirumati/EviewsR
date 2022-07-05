%eviews_path="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR\vignettes"
cd %eviews_path
%pagelist1=""
%figKeep1="all"
%eviewsrText="eviewsrText3f807d88bb4"
%chunkName="EviewsR-"
%save_path="C:/Users/SMATI/AppData/Local/Temp/RtmpWclc4l/preview-2fe84620575e.dir/EviewsR_files/figure-html/"
    'This program is created in R Markdown with the help of EviewsR package
  
  wfcreate(page=EviewsR_page,wf=EviewsR_workfile) m 2000 2022
  for %y EviewsR package page1 page2
  pagecreate(page={%y}) EviewsR m 2000 2022
  next
  pageselect EviewsR_page
  rndseed 123456
  genr y=rnd
  genr x=rnd
  equation ols.ls y c x
  freeze(EviewsROLS,mode=overwrite) ols
  freeze(yy,mode=overwrite) y.line
  freeze(xx,mode=overwrite) x.line
  wfsave EviewsR_workfile

%save_options="t=png,d=300"

   %pagelist=@pagelist

   if %pagelist1<>"" then
   %pagelist=%pagelist1
   endif

   for %page {%pagelist}
   pageselect {%page}


   if %figKeep1="first" then
   %figKeep=@wlookup("*","graph")
   %figKeep=@wleft(%figKeep,1)
   endif

   if %figKeep1="last" then
   %figKeep=@wlookup("*","graph")
   %figKeep=@wright(%figKeep,1)
   endif

   if %figKeep1="all" then
   %figKeep=@wlookup("*","graph")
   endif

   if %figKeep1="none" then
   %figKeep=""
   endif

   if %figKeep1="" then
   %figKeep=@wlookup("*","graph")
   endif


   if @wcount(%figKeep)>0 then
   for %y {%figKeep}
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
   

if %save_path<>"" then
     %save_path=%save_path+"\"
     endif

     %figPath=""

     %pagelist=@pagelist

     if %pagelist1<>"" then
     %pagelist=%pagelist1
     endif

     for %page {%pagelist}
     pageselect {%page}


     if %figKeep1="first" then
     %figKeep=@wlookup("*","graph")
     %figKeep=@wleft(%figKeep,1)
     endif

     if %figKeep1="last" then
     %figKeep=@wlookup("*","graph")
     %figKeep=@wright(%figKeep,1)
     endif

     if %figKeep1="all" then
     %figKeep=@wlookup("*","graph")
     endif

     if %figKeep1="none" then
     %figKeep=""
     endif




     if @wcount(%figKeep)<>0 then
     for %y {%figKeep}
     %figPath=%figPath+" "+%chunkName+%page+"-"+%y
     {%y}.save({%save_options}) {%eviews_path}\{%save_path}{%chunkName}{%page}-{%y}
     next
     endif

     next

     %figPath=@wunique(%figPath)


     text {%eviewsrText}_graph
     {%eviewsrText}_graph.append {%figpath}
     {%eviewsrText}_graph.save {%eviewsrText}-graph

     


   %tablePath=""

   %pagelist=@pagelist

   if %pagelist1<>"" then
   %pagelist=%pagelist1
   endif

   for %page {%pagelist}
   pageselect {%page}
   %tables=@wlookup("*" ,"table")

   if @wcount(%tables)<>0 then
   for %y {%tables}
   'table {%page}_{%y}
   %tablePath=%tablePath+" "+%page+"_"+%y+"-"+%eviewsrText
   {%y}.save(t=csv) {%eviews_path}\{%save_path}{%page}_{%y}-{%eviewsrText}
   next
   endif

   text {%eviewsrText}_table
   {%eviewsrText}_table.append {%tablePath}
   {%eviewsrText}_table.save {%eviewsrText}-table

   next


   %equationPath=""

   for %page {%pagelist}
   pageselect {%page}
   %equation=@wlookup("*","equation")

   if @wcount(%equation)<>0 then
   for %y {%equation}
   table {%y}_table_{%eviewsrText}

   %equationMembers="aic df coefs  dw f fprob hq logl meandep ncoef pval r2 rbar2 regobs schwarz sddep se ssr stderrs tstats"

   scalar n=@wcount(%equationMembers)
   for !j =1 to n
   %x{!j}=@word(%equationMembers,{!j})
   {%y}_table_{%eviewsrText}(1,!j)=%x{!j}

   %vectors="coefs pval stderrs tstats"
   if @wcount(@wintersect(%x{!j},%vectors))>0 then
   !eqCoef={%y}.@ncoef
   for !i= 2 to !eqCoef+1
   {%y}_table_{%eviewsrText}(!i,!j)={%y}.@{%x{!j}}(!i-1)
   next
   else
   {%y}_table_{%eviewsrText}(2,!j)={%y}.@{%x{!j}}
   endif
   next

   %equationPath=%equationPath+" "+%page+"_"+%y+"-"+%eviewsrText
   {%y}_table_{%eviewsrText}.save(t=csv) {%eviews_path}\{%save_path}{%page}_{%y}-{%eviewsrText}

   next

   endif
   next

   text {%eviewsrText}_equation
   {%eviewsrText}_equation.append {%equationPath}
   {%eviewsrText}_equation.save {%eviewsrText}-equation


   %seriesPath=""
   for %page {%pagelist}
   pageselect {%page}
   pagesave {%page}-{%chunkName}{%eviewsrText}.csv @drop date
   %seriesPath=%seriesPath+" "+%page+"-"+%chunkName+%eviewsrText
   next

   text {%eviewsrText}_series
   {%eviewsrText}_series.append {%seriesPath}
   {%eviewsrText}_series.save {%eviewsrText}-series
   exit
   
