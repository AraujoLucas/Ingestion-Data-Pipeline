from pyspark.sql import SparkSession
from awsglue.context import GlueContext
import pyspark
import sys
from datetime import datetime
now = datetime.now()
from awsglue.utils import getResolvedOptions
from awsglue.job import Job

args = getResolvedOptions(sys.argv, ['bucket_name','connection_name','db_table_name','JOB_NAME'])
date_process = "%s%02d%s" % (now.year, now.month,now.day)

spark = (SparkSession
            .builder
            .config('spark.serializer','org.apache.spark.serializer.KryoSerializer')
            .config('spark.sql.hive.convertMetastoreParquet','false')
            .getOrCreate()
        )

sc = spark.sparkContext
glueContext = GlueContext(sc)
job = Job(glueContext)

job.init(args['JOB_NAME'], args)        
bucket_name=args['bucket_name']
connection_name=args['connection_name']
db_table_name=args['db_table_name']
connection=glueContext.extract_jdbc_conf(connection_name)

def read_table(table_name, connection, date_process, bucket_name, db_table_name):
    
    url=connection['url']
    user_bd=connection['user']
    user_pwd=connection['password']
    url_full=f"{url}/olisaude"
    
    connection_postgres_options = {
    "url":url_full,
    "dbtable":table_name,
    "user":user_bd,
    "password":user_pwd,
    'driver': "org.postgresql.Driver"}
    
    print('-----Connection in database-----')
    # Read from JDBC databases with custom driver
    dyf_postgresql = glueContext.create_dynamic_frame.from_options(connection_type="postgresql",
                                                    connection_options=connection_postgres_options)
    df_postgresql = dyf_postgresql.toDF()
    print('-----show tables extrac-----')
    df_postgresql.show()
    table_name_local="s3://%s/db_postegres/%s/%s/" % (bucket_name,table_name,date_process)
    df_postgresql.coalesce(1).write.mode('append').format('parquet').save(table_name_local)
    return df_postgresql
    
print("-----Extract tables in databse postgres-----")
tb_authority = read_table('col',connection, date_process, bucket_name, db_table_name)
