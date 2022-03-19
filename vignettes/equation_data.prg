table ols_table

%equationMembers="aic df coefs  dw f fprob hq logl meandep ncoef pval r2 rbar2 regobs schwarz sddep se ssr stderrs tstats"

scalar n=@wcount(%equationMembers)
for !j =1 to n
%x{!j}=@word(%equationMembers,{!j})
ols_table(1,!j)=%x{!j}

%vectors="coefs pval stderrs tstats"
if @wcount(@wintersect(%x{!j},%vectors))>0 then
!olscoef=ols.@ncoef
for !i= 2 to !olscoef+1 'first row for the header
ols_table(!i,!j)=ols.@{%x{!i}}(!i-1)
next
else 
ols_table(2,!j)=ols.@{%x{!j}}
endif
next


