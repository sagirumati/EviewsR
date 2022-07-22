%eviews_path="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR\sagiru"
cd %eviews_path
%eviewsrText="EVIEWS11d0307b5828"
%wf="eviewsr1"
%page="*"
%equation="*"
open {%wf}



  %pagelist=@pagelist

  if %page<>"*" then
   %pagelist=%page
  endif


  %equationPath=""

  for %page {%pagelist}
  pageselect {%page}
  %equation1=@wlookup(%equation,"equation")

  if @wcount(%equation1)<>0 then
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
  {%y}_table_{%eviewsrText}.save(t=csv) {%page}_{%y}-{%eviewsrText}

  next

  endif
  next

  text {%eviewsrText}_equation
  {%eviewsrText}_equation.append {%equationPath}
  {%eviewsrText}_equation.save {%eviewsrText}-equation

  exit
  
open {%wf}



  %pagelist=@pagelist

  if %page<>"*" then
   %pagelist=%page
  endif


  %equationPath=""

  for %page {%pagelist}
  pageselect {%page}
  %equation1=@wlookup(%equation,"equation")

  if @wcount(%equation1)<>0 then
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
  {%y}_table_{%eviewsrText}.save(t=csv) {%page}_{%y}-{%eviewsrText}

  next

  endif
  next

  text {%eviewsrText}_equation
  {%eviewsrText}_equation.append {%equationPath}
  {%eviewsrText}_equation.save {%eviewsrText}-equation

  exit
  
