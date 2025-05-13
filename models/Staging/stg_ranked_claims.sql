WITH ranked_claims AS (

SELECT
claim_id,
employee_id,
claim_date,
expense_type,
claimed_amount,
currency,
approval_status,
approver_id,
ROW_NUMBER() OVER (PARTITION BY claim_id ORDER BY claim_date DESC) AS rn
FROM raw.public.EXPENSE_CLAIMS)


SELECT
claim_id,
employee_id,
claim_date,
UPPER (expense_type) AS expense_type,
claimed_amount, currency, lower(approval_status) as approval_status, approver_id  from ranked_claims where rn=1