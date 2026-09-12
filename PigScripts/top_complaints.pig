-- Load all NYC 311 CSV files
data = LOAD 'D:/NYC311_Data/chunks/*.csv'
       USING PigStorage(',')
       AS (
           unique_key:chararray,
           created_date:chararray,
           closed_date:chararray,
           agency:chararray,
           agency_name:chararray,
           complaint_type:chararray
       );

-- Remove repeated CSV header rows and empty complaint types
clean_data = FILTER data BY
             unique_key != 'unique_key'
             AND complaint_type IS NOT NULL
             AND complaint_type != '';

-- Group requests by complaint type
grouped_complaints = GROUP clean_data BY complaint_type;

-- Count requests for each complaint type
complaint_counts = FOREACH grouped_complaints GENERATE
                   group AS complaint_type,
                   COUNT(clean_data) AS total_requests;

-- Sort from highest to lowest
sorted_complaints = ORDER complaint_counts BY total_requests DESC;

-- Keep the top 10
top_10 = LIMIT sorted_complaints 10;

-- Display the result
DUMP top_10;