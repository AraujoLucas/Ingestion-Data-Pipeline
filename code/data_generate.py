from pyspark.sql import SparkSession
from awsglue.context import GlueContext
import pyspark
from datetime import datetime
now = datetime.now()
from awsglue.utils import getResolvedOptions

date_process = "%s%02d%s" % (now.year, now.month,now.day)
bucket_name = "corp-raw-684264620210"
table_name = "user"

sc = pyspark.SparkContext()
glue_context = GlueContext(sc)
spark = glue_context.spark_session

connection_postgres_options = {
    "url": "jdbc:postgresql://10.100.133.37:5432/oliprod",
    "dbtable": "olisaude",
    "table":"employee",
    "user": "luciano.stoppa@olisaude.com.br",
    "password": "holistico123",
    "customJdbcDriverS3Path": "s3://artifacts-684264620210/jars/postgresql-42.3.1.jar",
    "customJdbcDriverClassName": "org.postgresql.Driver"}

def read_table(connection_postgres_options,date_process):
    
    # Read from JDBC databases with custom driver
    dyf_postgresql = glue_context.create_dynamic_frame.from_options(connection_type="postgresql",connection_options=connection_postgres_options)
    #table_name_local="s3://%s/postegres/%s/%s/"  % (bucket_name,table_name,date_process)
    #df_postgresql.coalesce(1).write.mode('overwrite').format('parquet').save(table_name_local)
    return dyf_postgresql

print("vou comecar", connection_postgres_options)
tb_user = read_table(connection_postgres_options,date_process)
print("passei aqui", tb_user)