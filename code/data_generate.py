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
tb_authority = read_table('olischema.authority',connection, date_process, bucket_name, db_table_name)
tb_authority_group = read_table('olischema.authority_group',connection, date_process, bucket_name, db_table_name)
tb_beneficiary = read_table('olischema.beneficiary',connection, date_process, bucket_name, db_table_name)
tb_beneficiary_external_crm = read_table('olischema.beneficiary_external_crm',connection, date_process, bucket_name, db_table_name)
tb_beneficiary_health_condition = read_table('olischema.beneficiary_health_condition',connection, date_process, bucket_name, db_table_name)
tb_beneficiary_health_condition_hist = read_table('olischema.beneficiary_health_condition_hist',connection, date_process, bucket_name, db_table_name)
tb_beneficiary_health_plan = read_table('olischema.beneficiary_health_plan',connection, date_process, bucket_name, db_table_name)
tb_beneficiary_procedure = read_table('olischema.beneficiary_procedure',connection, date_process, bucket_name, db_table_name)
tb_beneficiary_scorep = read_table('olischema.beneficiary_score',connection, date_process, bucket_name, db_table_name)
tb_beneficiary_score_hist = read_table('olischema.beneficiary_score_hist',connection, date_process, bucket_name, db_table_name)
tb_ciap = read_table('olischema.ciap',connection, date_process, bucket_name, db_table_name)
tb_classification = read_table('olischema.classification',connection, date_process, bucket_name, db_table_name)
tb_company = read_table('olischema.company',connection, date_process, bucket_name, db_table_name)
tb_company_hc_provider = read_table('olischema.company_hc_provider',connection, date_process, bucket_name, db_table_name)
tb_employee = read_table('olischema.employee',connection, date_process, bucket_name, db_table_name)
tb_health_care_provider = read_table('olischema.health_care_provider',connection, date_process, bucket_name, db_table_name)
tb_health_conditions = read_table('olischema.health_condition',connection, date_process, bucket_name, db_table_name)
tb_network_reference = read_table('olischema.network_reference',connection, date_process, bucket_name, db_table_name)
tb_procedure = read_table('olischema.procedure',connection, date_process, bucket_name, db_table_name)
tb_risk_factor = read_table('olischema.risk_factor',connection, date_process, bucket_name, db_table_name)
tb_soap = read_table('olischema.soap',connection, date_process, bucket_name, db_table_name)
tb_soap_ciap = read_table('olischema.soap_ciap',connection, date_process, bucket_name, db_table_name)
tb_user = read_table('olischema.user',connection, date_process, bucket_name, db_table_name)
tb_user_authorities = read_table('olischema.user_authorities',connection, date_process, bucket_name, db_table_name)
