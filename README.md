# NYC 311 Service Requests Big Data Analysis

## Project Description

This project focuses on analyzing NYC 311 Service Requests using Big Data technologies from the Hadoop ecosystem. Approximately 3.85 million service-request records were processed from the NYC 311 dataset.

HDFS was used for storing the large dataset, Hadoop MapReduce was used for large-scale data aggregation, and Apache Pig was used to perform different types of data analysis. The project demonstrates how Big Data tools can be used to process a large real-world dataset and extract useful information from it.

## Dataset

The dataset used in this project is the **NYC 311 Service Requests from 2020 to Present** dataset provided through NYC Open Data.

- **Dataset:** NYC 311 Service Requests
- **Records Used:** 3,850,000
- **CSV Files:** 77
- **Approximate Local Dataset Size:** 3.28 GB
- **Storage:** HDFS
- **Dataset Source:**  
[NYC Open Data - 311 Service Requests](https://opendata.cityofnewyork.us/311-service-requests-from-2010-to-present-updates/)

The complete CSV dataset is not included in this repository because of its large file size.

## Technologies Used

- **Hadoop HDFS** – Distributed storage of the dataset
- **Hadoop MapReduce** – Large-scale data processing and aggregation
- **Apache Pig** – Data analysis using Pig Latin
- **Java** – MapReduce program development
- **Windows Command Prompt** – Hadoop and Pig execution environment

## Analyses Performed

### Hadoop MapReduce

Three MapReduce analyses were implemented:

1. Requests by Borough
2. Requests by Agency
3. Requests by Submission Channel

### Apache Pig

Six Pig analyses were implemented:

1. Top Complaint Types
2. Complaints by Borough
3. Average Resolution Time
4. Monthly Complaint Trends
5. Complaint Status Distribution
6. Top Complaint Locations

## HDFS

The dataset was stored in HDFS under the following directories:

```text
/311data
/311data/input

