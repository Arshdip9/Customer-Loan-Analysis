use project;
select * from Finance_CSV;
select * from financeX;

/*Year wise loan amount Stats*/

select year(issue_d) issue_year,sum(loan_amnt) loanamt from Finance_CSV group by year(issue_d)  order by year(issue_d) asc;

/* year and subgrade wise revol_bal*/

select grade, sub_grade, SUM(revol_bal) rev_bal 
from Finance_CSV a left join financeX b 
on a.id=b.id  
group by grade, sub_grade 
order by grade asc, sub_grade asc;


/*Total Payment for Verified Status Vs Total Payment for Non Verified Status*/


select verification_status, round(sum(total_pymnt),2) totalpymt 
from Finance_CSV a left join financeX b on a.id=b.id 
group by verification_status 
having verification_status='verified' or verification_status='not verified';


/*State wise and last_credit_pull_d wise loan status*/


select addr_state,YEAR(last_credit_pull_d) last_credit_year,  count(a.id) total_id , loan_status
from Finance_CSV a left join financeX b
on a.id=b.id 
group by  addr_state,YEAR(last_credit_pull_d), loan_status 
order by addr_state asc, YEAR(last_credit_pull_d) asc, total_id desc;


/*Home ownership Vs last payment date stats*/

select home_ownership, coalesce (year(last_pymnt_d),'2007') Yr_last_pymnt, COUNT(a.id) total_cust
from Finance_CSV a left join financeX b 
on a.id=b.id 
group by home_ownership, coalesce (year(last_pymnt_d),'2007')
order by home_ownership asc, coalesce (year(last_pymnt_d),'2007') asc;
