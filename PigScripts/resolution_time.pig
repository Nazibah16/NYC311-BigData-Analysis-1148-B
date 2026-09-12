-- Load NYC 311 data using proper CSV handling
data = LOAD 'D:/NYC311_Data/chunks/*.csv'
       USING org.apache.pig.piggybank.storage.CSVExcelStorage()
       AS (
           unique_key:chararray,
           created_date:chararray,
           closed_date:chararray,
           agency:chararray,
           agency_name:chararray,
           complaint_type:chararray
       );

-- Remove header rows and records without required dates
clean_data = FILTER data BY
             unique_key != 'unique_key'
             AND created_date IS NOT NULL
             AND created_date != ''
             AND closed_date IS NOT NULL
             AND closed_date != ''
             AND complaint_type IS NOT NULL
             AND complaint_type != '';

-- Convert date strings to date/time values
dates = FOREACH clean_data GENERATE
        complaint_type,
        ToDate(created_date, 'yyyy-MM-dd\'T\'HH:mm:ss.SSS') AS created,
        ToDate(closed_date, 'yyyy-MM-dd\'T\'HH:mm:ss.SSS') AS closed;

-- Convert dates to Unix time (seconds)
times = FOREACH dates GENERATE
        complaint_type,
        ToUnixTime(created) AS created_seconds,
        ToUnixTime(closed) AS closed_seconds;

-- Calculate resolution time in hours
resolution = FOREACH times GENERATE
             complaint_type,
             (closed_seconds - created_seconds) / 3600.0 AS resolution_hours;

-- Remove invalid negative resolution times
valid_resolution = FILTER resolution BY resolution_hours >= 0;

-- Group by complaint type
grouped = GROUP valid_resolution BY complaint_type;

-- Calculate average resolution time
average_resolution = FOREACH grouped GENERATE
                      group AS complaint_type,
                      COUNT(valid_resolution) AS total_requests,
                      AVG(valid_resolution.resolution_hours) AS average_hours;

-- Sort by average resolution time
sorted = ORDER average_resolution BY average_hours DESC;

-- Show the 10 complaint types with the longest average resolution time
top_10 = LIMIT sorted 10;

DUMP top_10;