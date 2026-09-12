-- Load NYC 311 data using proper CSV handling
data = LOAD 'D:/NYC311_Data/chunks/*.csv'
       USING org.apache.pig.piggybank.storage.CSVExcelStorage()
       AS (
           unique_key:chararray,
           created_date:chararray
       );

-- Remove repeated headers and invalid dates
clean_data = FILTER data BY
             unique_key != 'unique_key'
             AND created_date IS NOT NULL
             AND created_date != '';

-- Extract Year-Month from the created date
monthly_data = FOREACH clean_data GENERATE
               SUBSTRING(created_date, 0, 7) AS year_month;

-- Group requests by month
grouped_months = GROUP monthly_data BY year_month;

-- Count requests for each month
monthly_counts = FOREACH grouped_months GENERATE
                 group AS year_month,
                 COUNT(monthly_data) AS total_requests;

-- Sort chronologically
sorted_months = ORDER monthly_counts BY year_month ASC;

-- Display monthly results
DUMP sorted_months;