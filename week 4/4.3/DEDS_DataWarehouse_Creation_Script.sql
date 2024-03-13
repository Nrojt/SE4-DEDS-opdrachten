IF NOT EXISTS (
    SELECT name FROM sys.databases
    WHERE name = N'DEDS_DataWarehouse'
)
CREATE DATABASE DEDS_DataWarehouse; -- Create the database if it does not exist
GO  -- This is used to separate batches of SQL statements.

USE DEDS_DataWarehouse;
GO  -- Switch to the newly created database

CREATE TABLE Unit (
UNIT_SK int IDENTITY (1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  UNIT_id int,
  UNIT_COST_cost money NOT NULL,
  UNIT_PRICE_price money NOT NULL,
  UNIT_SALE_sale money NOT NULL
);

CREATE TABLE Sales_staff (
  SALES_STAFF_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  SALES_STAFF_code int,
  SALES_STAFF_email varchar(255) NOT NULL,
  SALES_STAFF_extension varchar(50) NOT NULL,
  SALES_STAFF_POSITION_EN_position varchar(50) NOT NULL,
  SALES_STAFF_WORK_PHONE_work_phone varchar(50) NOT NULL,
  SALES_STAFF_DATE_HIRED_hired date NOT NULL,
  SALES_STAFF_MANAGER_CODE_manager int,
  SALES_STAFF_FAX varchar(50) NOT NULL,
  SALES_STAFF_FIRST_NAME_first_name varchar(50) NOT NULL,
  SALES_STAFF_LAST_NAME_last_name varchar(50) NOT NULL,
  SALES_STAFF_FULL_NAME_full_name AS (SALES_STAFF_FIRST_NAME_first_name + ' ' + SALES_STAFF_LAST_NAME_last_name) PERSISTED, -- persisted so it can be indexed and is only calculated once (at first insert)
  SALES_STAFF_SALES_BRANCH_CODE_branch_code int,
  SALES_STAFF_SALES_BRANCH_ADDRESS_address varchar(255),
  SALES_STAFF_SALES_BRANCH_ADDRESS_EXTRA_address_extra varchar(255)
);

CREATE TABLE Satisfaction_type (
    SATISFACTION_TYPE_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  SATISFACTION_TYPE_code int,
  SATISFACTION_TYPE_description varchar(255) NOT NULL,
  SATISFACTION_TYPE_description_short varchar(50) NOT NULL
);

CREATE TABLE Course (
    COURSE_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  COURSE_code int,
  COURSE_description varchar(255) NOT NULL,
  COURSE_description_short varchar(255) NOT NULL
);

CREATE TABLE Year (
  Year int PRIMARY KEY,
  CHECK (Year >= 1000 AND Year <= 9999) -- Adjust year range as needed
);

CREATE TABLE Date (
  DATE_date date PRIMARY KEY -- Store the complete date in a single column
);

CREATE TABLE "Order" (
    ORDER_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  ORDER_order_number int,
  ORDER_ORDER_METHOD_CODE_method_code int,
  ORDER_ORDER_METHOD_EN_method varchar(50) NOT NULL,
);

CREATE TABLE Retailer_site (
    RETAILER_SITE_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  RETAILER_SITE_code int,
  RETAILER_SITE_COUNTRY_CODE_country int NOT NULL,
  RETAILER_SITE_CITY_city varchar(50) NOT NULL,
  RETAILER_SITE_REGION_region varchar(50),
  RETAILER_SITE_POSTAL_ZONE_postal_zone varchar(20),
  RETAILER_SITE_RETAILER_CODE_retailer_code int,
  RETAILER_SITE_ACTIVE_INDICATOR_indicator bit NOT NULL,
  RETAILER_SITE_ADDRESS1_address varchar(255),
  RETAILER_SITE_ADDRESS2_address varchar(255),
  RETAILER_SITE_MAIN_ADDRESS_address varchar(255)
);

CREATE TABLE Retailer_segment (
    RETAILER_SEGMENT_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  RETAILER_SEGMENT_segment_code int,
  RETAILER_SEGMENT_language char(2) NOT NULL,
  RETAILER_SEGMENT_segment_name varchar(50) NOT NULL,
  RETAILER_SEGMENT_SEGMENT_DESCRIPTION_description varchar(255) NOT NULL
);

CREATE TABLE Retailer_headquarter (
    RETAILER_HEADQUARTER_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  RETAILER_HEADQUARTER_codemr int,
    RETAIL_HEADQUARTER_retailer_name varchar(50) NOT NULL,
    RETAILER_HEADQUARTER_address1_address varchar(255),
    RETAILER_HEADQUARTER_address2_address varchar(255),
    RETAILER_HEADQUARTER_main_address_address varchar(255),
    RETAILER_HEADQUARTER_country_code_country int NOT NULL,
    RETAILER_HEADQUARTER_region_region varchar(50),
    RETAILER_HEADQUARTER_city_city varchar(50) NOT NULL,
    RETAILER_HEADQUARTER_postal_zone_postal_zone varchar(20),
    RETAILER_HEADQUARTER_fax_fax varchar(50),
    RETAILER_HEADQUARTER_phone_phone varchar(50) NOT NULL,
    RETAILER_HEADQUARTER_segment_code int,
);


CREATE TABLE Sales_branch (
    SALE_BRANCH_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  SALES_BRANCH_code int,
  SALES_BRANCH_COUNTRY_CODE_country int NOT NULL,
  SALES_BRANCH_REGION_region varchar(50),
  SALES_BRANCH_CITY_city varchar(50) NOT NULL,
  SALES_BRANCH_POSTAL_ZONE_postal_zone varchar(20),
  SALES_BRANCH_ADDRESS1_address varchar(255),
  SALES_BRANCH_ADDRESS2_address varchar(255),
  SALES_BRANCH_MAIN_ADDRESS_address varchar(255)
);

CREATE TABLE Retailer_contact (
    RETAILER_CONTACT_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  RETAILER_CONTACT_code int,
  RETAILER_CONTACT_email varchar(255) NOT NULL,
  RETAILER_CONTACT_RETAILER_SITE_CODE_site_code int,
  FOREIGN KEY (RETAILER_CONTACT_RETAILER_SITE_CODE_site_code) REFERENCES Retailer_site(RETAILER_SITE_code),
  RETAILER_CONTACT_JOB_POSITION_EN_position varchar(50),
  RETAILER_CONTACT_EXTENSION_extension varchar(50),
  RETAILER_CONTACT_FAX_fax varchar(50),
  RETAILER_CONTACT_GENDER_gender char(1),
  RETAILER_CONTACT_FIRST_NAME_first_name varchar(50) NOT NULL,
  RETAILER_CONTACT_LAST_NAME_last_name varchar(50) NOT NULL,
  RETAILER_CONTACT_FULL_NAME_full_name AS (RETAILER_CONTACT_FIRST_NAME_first_name + ' ' + RETAILER_CONTACT_LAST_NAME_last_name) PERSISTED -- persisted so it can be indexed and is only calculated once (at first insert)
);

CREATE TABLE Retailer (
    RETAILER_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  RETAILER_code int,
  RETAILER_name varchar(255) NOT NULL,
  RETAILER_COMPANY_CODE_MR_company varchar(50),
  RETAILER_RETAILER_TYPE_code int,
  RETAILER_RETAILER_TYPE_EN varchar(50) NOT NULL,
);

CREATE TABLE Product (
    PRODUCT_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  PRODUCT_number INT,
  PRODUCT_name_product VARCHAR(MAX) NOT NULL,
  PRODUCT_description_description VARCHAR(MAX),
  PRODUCT_image_image VARCHAR(255), -- url to image
  PRODUCT_INTRODUCTION_DATE_introduced DATE,
  PRODUCT_PRODUCTION_COST_cost DECIMAL(10, 2) NOT NULL,
  PRODUCT_MARGIN_margin DECIMAL(5, 2) NOT NULL,
  PRODUCT_LANGUAGE_language VARCHAR(5) NOT NULL,
  PRODUCT_MINIMUM_SALE_PRICE_minPrice DECIMAL(10, 2) NOT NULL,
  PRODUCT_PRODUCT_LINE_code varchar,
  PRODUCT_PRODUCT_LINE_code_en VARCHAR(5),
  PRODUCT_PRODUCT_TYPE_code varchar,
  PRODUCT_PRODUCT_TYPE_code_en VARCHAR(5)
);


CREATE TABLE Order_details (
    ORDER_DETAILS_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  ORDER_DETAILS_code int,
  ORDER_DETAILS_QUANTITY_quantity int NOT NULL,
  ORDER_DETAILS_TOTAL_COST_total money NOT NULL,
  ORDER_DETAILS_TOTAL_MARGIN_margin money NOT NULL,
  ORDER_DETAILS_RETURN_CODE_returned varchar(50),
  ORDER_DETAILS_ORDER_NUMBER_order int,
  ORDER_DETAILS_PRODUCT_NUMBER_product int,
  ORDER_DETAILS_UNIT_ID_unit int,
  FOREIGN KEY (ORDER_DETAILS_ORDER_NUMBER_order) REFERENCES "Order"(ORDER_order_number),
  FOREIGN KEY (ORDER_DETAILS_PRODUCT_NUMBER_product) REFERENCES Product(PRODUCT_number),
  FOREIGN KEY (ORDER_DETAILS_UNIT_ID_unit) REFERENCES Unit(UNIT_id)
);

CREATE TABLE Returned_item (
    RETURNED_ITEM_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
    Returned_item INT,
    RETURNED_ITEM_code VARCHAR(20) NOT NULL,
    RETURNED_ITEM_DATE DATETIME NOT NULL,
    RETURNED_ITEM_QUANTITY INT NOT NULL,
    RETURNED_ITEM_ORDER_DETAIL_CODE INT REFERENCES Order_details(ORDER_DETAILs_code),
    RETURNED_ITEM_RETURN_REASON_code INT NOT NULL,
    RETURNED_ITEM_RETURN_REASON_desctiption_en VARCHAR(255),
    RETURNED_ITEM_RETURNED_ITEMS_TOTAL_PRICE DECIMAL(10, 2) NOT NULL
);

CREATE TABLE SALES_TARGETDATA (
    SALES_TARGETDATA_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  SALES_TARGETDATA_id int,
  SALES_TARGETDATA_SALES_YEAR int NOT NULL,
  SALES_TARGETDATA_SALES_PERIOD varchar(50) NOT NULL,
  SALES_TARGETDATA_RETAILER_NAME varchar(255),
  SALES_TARGETDATA_SALES_TARGET money NOT NULL,
  SALES_TARGETDATA_TARGET_COST money NOT NULL,
  SALES_TARGETDATA_TARGET_MARGIN money NOT NULL,
  SALES_TARGETDATA_SALES_STAFF_CODE int NOT NULL,
  SALES_TARGETDATA_PRODUCT_NUMBER int NOT NULL,
  SALES_TARGETDATA_RETAILER_CODE int NOT NULL,
  FOREIGN KEY (SALES_TARGETDATA_SALES_STAFF_CODE) REFERENCES Sales_staff(SALES_STAFF_code),
  FOREIGN KEY (SALES_TARGETDATA_PRODUCT_NUMBER) REFERENCES Product(PRODUCT_number),
  FOREIGN KEY (SALES_TARGETDATA_RETAILER_CODE) REFERENCES Retailer(RETAILER_code)
);

CREATE TABLE Training (
  TRAINING_SALES_STAFF_CODE INT NOT NULL,
  FOREIGN KEY (TRAINING_SALES_STAFF_CODE) REFERENCES Sales_staff(SALES_STAFF_code),
  TRAINING_COURSE_CODE INT NOT NULL,
    FOREIGN KEY (TRAINING_COURSE_CODE) REFERENCES Course(COURSE_code),
    TRAINING_YEAR INT NOT NULL,
    CHECK (TRAINING_YEAR >= 1000 AND TRAINING_YEAR <= 9999),  -- Year range check
    PRIMARY KEY (TRAINING_SALES_STAFF_CODE, TRAINING_COURSE_CODE)  -- Use composite primary key for unique combination
);

CREATE TABLE Satisfaction (
  SATISFACTION_SALES_STAFF_CODE INT NOT NULL,
  FOREIGN KEY (SATISFACTION_SALES_STAFF_CODE) REFERENCES Sales_staff(SALES_STAFF_code),
  SATISFACTION_SATISFACTION_TYPE_CODE INT NOT NULL,
  FOREIGN KEY (SATISFACTION_SATISFACTION_TYPE_CODE) REFERENCES Satisfaction_type(SATISFACTION_TYPE_code),
  PRIMARY KEY (SATISFACTION_SALES_STAFF_CODE, SATISFACTION_SATISFACTION_TYPE_CODE),  -- Use composite primary key for unique combination
  SATISFACTION_YEAR INT NOT NULL,
);

CREATE TABLE Order_header (
    ORDER_HEADER_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  ORDER_HEADER_number int,  -- Unique order identifier
  ORDER_HEADER_RETAILER_CODE int NOT NULL,  -- Foreign key referencing Retailer table
  FOREIGN KEY (ORDER_HEADER_RETAILER_CODE) REFERENCES Retailer(RETAILER_code),
  ORDER_HEADER_SALES_STAFF_CODE int NOT NULL,  -- Foreign key referencing Sales_staff table
  FOREIGN KEY (ORDER_HEADER_SALES_STAFF_CODE) REFERENCES Sales_staff(SALES_STAFF_code),
  ORDER_HEADER_SALES_BRANCH_CODE int,  -- Foreign key referencing Sales_branch table (nullable)
  FOREIGN KEY (ORDER_HEADER_SALES_BRANCH_CODE) REFERENCES Sales_branch(SALES_BRANCH_code),
  ORDER_HEADER_ORDER_DATE date NOT NULL,
  ORDER_HEADER_RETAILER_SITE_CODE int,  -- Foreign key referencing Retailer_site table (nullable)
  FOREIGN KEY (ORDER_HEADER_RETAILER_SITE_CODE) REFERENCES Retailer_site(RETAILER_SITE_code),
  ORDER_HEADER_RETAILER_CONTACT_CODE int,  -- Foreign key referencing Retailer_contact table (nullable)
  FOREIGN KEY (ORDER_HEADER_RETAILER_CONTACT_CODE) REFERENCES Retailer_contact(RETAILER_CONTACT_code)
);

CREATE TABLE GO_SALES_INVENTORY_LEVELS (
  GO_SALES_INVENTORY_LEVELS_id INT PRIMARY KEY IDENTITY, -- Use auto-incrementing ID as primary key
  GO_SALES_INVENTORY_LEVELS_INVENTORY_COUNT INT NOT NULL,
  GO_SALES_INVENTORY_LEVELS_PRODUCT_NUMBER INT NOT NULL,
  FOREIGN KEY (GO_SALES_INVENTORY_LEVELS_PRODUCT_NUMBER) REFERENCES Product (PRODUCT_number),
  GO_SALES_INVENTORY_LEVELS_YEAR_MONTH INT NOT NULL,  -- Combine year and month for efficient storage and retrieval
CHECK (GO_SALES_INVENTORY_LEVELS_YEAR_MONTH BETWEEN 100000 AND 999912)  -- Enforce year-month format (YYYYMM) -- Enforce year-month format (YYYYMM)
);

CREATE TABLE GO_SALES_PRODUCT_FORECAST (
  GO_SALES_PRODUCT_FORECAST_id INT PRIMARY KEY IDENTITY, -- Use auto-incrementing ID as primary key
  GO_SALES_PRODUCT_FORECAST_EXPECTED_VOLUME INT NOT NULL,
  GO_SALES_PRODUCT_FORECAST_EXPECTED_COST money NOT NULL,
  GO_SALES_PRODUCT_FORECAST_EXPECTED_MARGIN money NOT NULL,
  GO_SALES_PRODUCT_FORECAST_PRODUCT_NUMBER INT NOT NULL,
  FOREIGN KEY (GO_SALES_PRODUCT_FORECAST_PRODUCT_NUMBER) REFERENCES Product(PRODUCT_number),
  GO_SALES_PRODUCT_FORECAST_YEAR_MONTH INT NOT NULL,  -- Combine year and month for efficient storage and retrieval
CHECK (GO_SALES_PRODUCT_FORECAST_YEAR_MONTH BETWEEN 100000 AND 999912)  -- Enforce year-month format (YYYYMM)
);
