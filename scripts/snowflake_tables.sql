-- Create raw table
create or replace table yelp_businesses (business_text variant);

-- Load data  yelp business file from S3
COPY INTO yelp_businesses
FROM 's3://yelp-project01/yelp_academic_dataset_business.json'
CREDENTIALS = (
    AWS_KEY_ID ='YOUR_ACCESS_KEY',
    AWS_SECRET_KEY = 'YOUR_SECRET_KEY'
)
FILE_FORMAT = (TYPE = 'JSON');

-- Create tabular format table
create or replace table tbl_yelp_businesses as 
select business_text:business_id::string as business_id,
       business_text:name::string as name,
       business_text:city::string as city,
       business_text:state::string as state,
       business_text:review_count::string as review_count,
       business_text:stars::number as stars,
       business_text:categories::string as categories
from yelp_businesses;

-- Load data  yelp reviews file from S3
create or replace table yelp_reviews (review_text variant);

COPY INTO yelp_reviews
FROM 's3://yelp-project01/'
CREDENTIALS = (
    AWS_KEY_ID = '[REDACTED]',
    AWS_SECRET_KEY = '[REDACTED]'
)
FILE_FORMAT = (TYPE = JSON);

-- Create tabular format table
create or replace table tbl_yelp_businesses as 
select business_text:business_id::string as business_id,
       business_text:name::string as name,
       business_text:city::string as city,
       business_text:state::string as state,
       business_text:review_count::string as review_count,
       business_text:stars::number as stars,
       business_text:categories::string as categories
from yelp_businesses;
