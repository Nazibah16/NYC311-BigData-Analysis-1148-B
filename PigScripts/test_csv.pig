data = LOAD 'D:/NYC311_Data/chunks/311_part_0001.csv'
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

clean = FILTER data BY unique_key != 'unique_key';

result = FOREACH clean GENERATE
         unique_key,
         created_date,
         complaint_type,
         borough;

result = LIMIT result 10;

DUMP result;