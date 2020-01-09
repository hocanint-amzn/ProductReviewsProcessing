# This is the source data (publicly available)
CREATE EXTERNAL TABLE amazon_reviews_parquet(
  marketplace string, 
  customer_id string, 
  review_id string, 
  product_id string, 
  product_parent string, 
  product_title string, 
  star_rating int, 
  helpful_votes int, 
  total_votes int, 
  vine string, 
  verified_purchase string, 
  review_headline string, 
  review_body string, 
  review_date date, 
  year int)
PARTITIONED BY (product_category string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat'
LOCATION
  's3://amazon-reviews-pds/parquet/'

# Load partitions.
MSCK REPAIR TABLE amazon_reviews_parquet;

# This is the output table that will be used to feed the demo
CREATE EXTERNAL TABLE amazon_reviews_parquet_for_demo (
  marketplace string, 
  customer_id string, 
  review_id string, 
  product_id string, 
  product_parent string, 
  product_title string, 
  star_rating int, 
  helpful_votes int, 
  total_votes int, 
  vine string, 
  verified_purchase string, 
  review_headline string, 
  review_body string, 
  review_date string, 
  year int)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat'
LOCATION
  's3://<REPLACE WITH YOUR OWN BUCKET>/parquet/product_category=Home_Improvement/'
;

INSERT OVERWRITE TABLE amazon_reviews_parquet_for_demo
SELECT
  marketplace, 
  customer_id, 
  review_id,
  product_id, 
  product_parent, 
  product_title, 
  #This is to simulate some bad data.
  case when customer_id = "42351637" then
    100
  else
    star_rating
  end as star_rating, 
  helpful_votes, 
  total_votes, 
  vine, 
  verified_purchase, 
  review_headline, 
  review_body, 
  review_date, 
  year
FROM amazon_reviews_parquet
#Select only one year and one category of data.
WHERE product_category='Home_Improvement' and year = 2015;
