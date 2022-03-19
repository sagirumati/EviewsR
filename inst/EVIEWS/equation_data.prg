%equation=@wlookup("*","equation")
if @wcount(%equation)<>0 then

for %y {%equation}
table {%y}_table

%equationMembers="aic df coefs  dw f fprob hq logl meandep ncoef pval r2 rbar2 regobs schwarz sddep se ssr stderrs tstats"

scalar n=@wcount(%equationMembers)
for !j =1 to n
%x{!j}=@word(%equationMembers,{!j})
{%y}_table(1,!j)=%x{!j}

%vectors="coefs pval stderrs tstats"
if @wcount(@wintersect(%x{!j},%vectors))>0 then
!eqCoef={%y}.@ncoef
for !i= 2 to !eqCoef+1 'first row for the header
{%y}_table(!i,!j)={%y}.@{%x{!j}}(!i-1)
next
else 
{%y}_table(2,!j)={%y}.@{%x{!j}}
endif
next

{%y}_table.save(t=csv) Eviewsr_files\EviewsR\{%y}

next

endif
