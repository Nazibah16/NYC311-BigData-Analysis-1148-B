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
           status:chararray
       );

clean_data = FILTER data BY
             unique_key != 'unique_key'
             AND status IS NOT NULL
             AND status != '';

grouped_status = GROUP clean_data BY status;

status_counts = FOREACH grouped_status GENERATE
                group AS status,
                COUNT(clean_data) AS total_requests;

sorted_status = ORDER status_counts BY total_requests DESC;

DUMP sorted_status;