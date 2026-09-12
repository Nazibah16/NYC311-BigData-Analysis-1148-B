-- Load NYC 311 data using proper CSV handling
data = LOAD 'D:/NYC311_Data/chunks/*.csv'
       USING org.apache.pig.piggybank.storage.CSVExcelStorage()
       AS (
           unique_key:chararray,
           created_date:chararray,
           closed_date:chararray,
           agency:chararray,
           agency_name:chararray,
           complaint_type:chararray,
           descriptor:chararray,
           descriptor_2:chararray,
           location_type:chararray
       );

-- Remove repeated headers and empty locations
clean_data = FILTER data BY
             unique_key != 'unique_key'
             AND location_type IS NOT NULL
             AND location_type != '';

-- Group requests by location type
grouped_locations = GROUP clean_data BY location_type;

-- Count requests for each location
location_counts = FOREACH grouped_locations GENERATE
                  group AS location_type,
                  COUNT(clean_data) AS total_requests;

-- Sort from highest to lowest
sorted_locations = ORDER location_counts BY total_requests DESC;

-- Display top 10 locations
top_10 = LIMIT sorted_locations 10;

DUMP top_10;