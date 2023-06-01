CREATE TABLE dates AS (
    SELECT 
        d::date AS "Date",
        EXTRACT(YEAR FROM d)::text AS "Year",
        EXTRACT(MONTH FROM d)::text AS "Month Number",
        'M' || EXTRACT(MONTH FROM d)::text AS "Month",
        EXTRACT(DAY FROM d)::text AS "Day",
        TO_CHAR(d, 'YYYYMM') AS "Year Month",
        TO_CHAR(d, 'Month') AS "Month Name",
        (EXTRACT(DOW FROM d)::integer + 1)::text AS "Day Number", -- PostgreSQL counts Sunday as 0, so we add 1 to match the DAX version.
        TO_CHAR(d, 'Day') AS "Day Name"
    FROM generate_series(
        '2019-01-01'::date, 
        '2021-12-31'::date, 
        '1 day'::interval
    ) AS d
);