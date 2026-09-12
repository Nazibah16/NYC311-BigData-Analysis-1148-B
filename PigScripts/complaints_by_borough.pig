-- Load all NYC 311 CSV files using proper CSV handling
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
           location_type:chararray,
           incident_zip:chararray,
           incident_address:chararray,
           street_name:chararray,
           cross_street_1:chararray,
           cross_street_2:chararray,
           intersection_street_1:chararray,
           intersection_street_2:chararray,
           address_type:chararray,
           city:chararray,
           landmark:chararray,
           facility_type:chararray,
           status:chararray,
           due_date:chararray,
           resolution_description:chararray,
           resolution_action_updated_date:chararray,
           community_board:chararray,
           council_district:chararray,
           police_precinct:chararray,
           bbl:chararray,
           borough:chararray
       );

-- Remove repeated headers and empty borough values
clean_data = FILTER data BY
             unique_key != 'unique_key'
             AND borough IS NOT NULL
             AND borough != '';

-- Group by borough
grouped_boroughs = GROUP clean_data BY borough;

-- Count complaints
borough_counts = FOREACH grouped_boroughs GENERATE
                 group AS borough,
                 COUNT(clean_data) AS total_requests;

-- Sort highest to lowest
sorted_boroughs = ORDER borough_counts BY total_requests DESC;

DUMP sorted_boroughs;