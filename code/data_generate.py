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

args = getResolvedOptions(sys.argv, ['bucket_name','connection_name'])
bucket_name=args['bucket_name']
connection_name=args['connection_name']
connection=glue_context.extract_jdbc_conf(connection_name)

def read_table(connection_postgres_options,date_process):
    
    url=connection['url']
    user_bd=connection['user']
    user_pwd=connection['password']
    
    connection_postgres_options = {
    "url":url,
    "dbtable": "olisaude",
    "table":"employee",
    "user":user_bd,
    "password":user_pwd,
    'driver': "org.postgresql.Driver"}
    
    # Read from JDBC databases with custom driver
    dyf_postgresql = glue_context.create_dynamic_frame.from_options(
        connection_type="postgresql",
        connection_options=connection_postgres_options)

    df_postgresql=dyf_postgresql.toDF()
    df_postgresql.show()
    table_name_local="s3://%s/postegres/%s/%s/"  % (bucket_name,table_name,date_process)
    df_postgresql.coalesce(1).write.mode('overwrite').format('parquet').save(table_name_local)
    return df_postgresql

print("vou comecar")
tb_user = read_table(date_process)
print("passei aqui", tb_user)