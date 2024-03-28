-- database name and some columns are modified for privacy concerns
WITH latest_times AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY date_actual ORDER BY to_timestamp(time_actual, 'HH24:MI:SS') DESC) AS rn
    FROM 
        db_gold_price
    WHERE 
        region = 'Ho Chi Minh City' 
        AND
        gold_type = 'SJC'
)
SELECT 
	purchase_price
	, selling_price
	, date_actual
FROM 
    latest_times
WHERE 
    rn = 1
ORDER BY 
    to_date(date_actual, 'YYYY-MM-DD') DESC;

-- the result is saved as csv file "sjc_price_hochiminh_07022024" in folder "raw_dataset"