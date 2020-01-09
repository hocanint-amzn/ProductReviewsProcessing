# ProductReviewsProcessing

This repo contains a sample Notebook that you can use to play with Hudi operations. This Notebook was demostrated during 2019 Re:Invent, in which a video of it can be found at https://www.youtube.com/watch?v=aIwJlfEAlHQ&t=27s. 

## Setup

Please follow the instructions located on EMR's Hudi documentation located at https://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-hudi-work-with-dataset.html. This will ensure that you have copied the necessary jars into HDFS so that Hudi libraries can be setup and usable within Jupyter Notebook. You can also run the copy_hudi_jars_to_hdfs.sh script located in this repo to run the necessary commands when the cluster starts up.

## Data

The data that is used with this code was generated from the Amazon Reviews Public Dataset. The dataset that was used during ReInvent was a modified version of it. Although the code works with the normal dataset, it will take more time to run as the amount of data is larger. 

To generate the data identically to the one used during ReInvents demo, run generate_data.hql located in this repo within Apache Hive to generate the appropriate data.