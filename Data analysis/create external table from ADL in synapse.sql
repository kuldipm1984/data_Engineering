USE mydbsql;
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '1984@bhel';
CREATE DATABASE SCOPED CREDENTIAL cred_sales
WITH IDENTITY = 'Managed Identity';
-- Create external data source
CREATE EXTERNAL DATA SOURCE my_sales_data
WITH (
    LOCATION = 'https://mystore1984.dfs.core.windows.net/document',
    CREDENTIAL = cred_sales
);
-- Create external file format for Parquet
CREATE EXTERNAL FILE FORMAT my_parquet
WITH (
    FORMAT_TYPE = PARQUET
);
-- Create external table
CREATE EXTERNAL TABLE dbo.sales_data1 (
    Temperature INT,
    Humidity INT,
    WindSpeed FLOAT,
    Precipitation INT,
    AtmosphericPressure FLOAT,
    UVIndex INT,
    Visibility FLOAT,
    WeatherType INT
)
WITH (
    LOCATION = '/weather_db2/mytable/',
    DATA_SOURCE = my_sales_data,
    FILE_FORMAT = my_parquet
);

SELECT * from dbo.sales_data1