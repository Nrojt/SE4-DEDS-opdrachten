IF EXISTS (
    SELECT name FROM sys.databases
    WHERE name = N'DEDS_DataWarehouse'
)
DROP DATABASE DEDS_DataWarehouse; -- Drop the database if it already exists
GO

CREATE DATABASE DEDS_DataWarehouse; -- Create the database
GO

USE DEDS_DataWarehouse;
GO

CREATE TABLE Year (
  Year int PRIMARY KEY,
  CHECK (Year >= 1000 AND Year <= 9999) -- Adjust year range as needed
);

CREATE TABLE Date (
  DATE_date DATE PRIMARY KEY -- Store the complete date in a single column
);

CREATE TABLE Unit (
UNIT_SK int IDENTITY (1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  UNIT_id int NOT NULL,
  UNIT_COST_cost money NOT NULL,
  UNIT_PRICE_price money NOT NULL,
  UNIT_SALE_sale money NOT NULL,
  LAST_UPDATED datetime2 NOT NULL DEFAULT SYSDATETIME(), -- Add LAST_UPDATED column
  CURRENT_VALUE bit NOT NULL DEFAULT 1
);

CREATE TABLE Sales_staff (
  SALES_STAFF_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  SALES_STAFF_code int NOT NULL,
  SALES_STAFF_email varchar(255) NOT NULL,
  SALES_STAFF_extension varchar(50) NOT NULL,
  SALES_STAFF_POSITION_EN_position varchar(50) NOT NULL,
  SALES_STAFF_WORK_PHONE_work_phone varchar(50) NOT NULL,
  SALES_STAFF_DATE_HIRED_hired date NOT NULL,
  FOREIGN KEY (SALES_STAFF_DATE_HIRED_hired) REFERENCES Date(DATE_date),
  SALES_STAFF_MANAGER_CODE_manager int NULL,
  FOREIGN KEY (SALES_STAFF_MANAGER_CODE_manager) REFERENCES Sales_staff(SALES_STAFF_SK),
  SALES_STAFF_FAX varchar(50) NOT NULL,
  SALES_STAFF_FIRST_NAME_first_name varchar(50) NOT NULL,
  SALES_STAFF_LAST_NAME_last_name varchar(50) NOT NULL,
  SALES_STAFF_FULL_NAME_full_name AS (SALES_STAFF_FIRST_NAME_first_name + ' ' + SALES_STAFF_LAST_NAME_last_name),
  SALES_STAFF_SALES_BRANCH_CODE_branch_code int,
  SALES_STAFF_SALES_BRANCH_ADDRESS1_address varchar(255),
  SALES_STAFF_SALES_BRANCH_ADDRESS2_address varchar(255) NULL,
  LAST_UPDATED datetime2 NOT NULL DEFAULT SYSDATETIME(), -- Add LAST_UPDATED column
  CURRENT_VALUE bit NOT NULL DEFAULT 1 -- Add CURRENT column
);

CREATE TABLE Satisfaction_type (
  SATISFACTION_TYPE_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  SATISFACTION_TYPE_code int NOT NULL,
  SATISFACTION_TYPE_description varchar(255) NOT NULL,
  SATISFACTION_TYPE_description_short varchar(50) NULL,
  LAST_UPDATED datetime2 NOT NULL DEFAULT SYSDATETIME(), -- Add LAST_UPDATED column
  CURRENT_VALUE bit NOT NULL DEFAULT 1 -- Add CURRENT column
);

CREATE TABLE Course (
  COURSE_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  COURSE_code int NOT NULL,
  COURSE_description varchar(255) NOT NULL,
  COURSE_description_short varchar(255) NULL,
  LAST_UPDATED datetime2 NOT NULL DEFAULT SYSDATETIME(), -- Add LAST_UPDATED column
  CURRENT_VALUE bit NOT NULL DEFAULT 1 -- Add CURRENT column
);

CREATE TABLE "Order" (
  ORDER_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  ORDER_order_number int NOT NULL,
  ORDER_ORDER_METHOD_CODE_method_code int,
  ORDER_ORDER_METHOD_EN_method varchar(50) NOT NULL,
  LAST_UPDATED datetime2 NOT NULL DEFAULT SYSDATETIME(), -- Add LAST_UPDATED column
  CURRENT_VALUE bit NOT NULL DEFAULT 1 -- Add CURRENT column
);

CREATE TABLE Retailer_site (
  RETAILER_SITE_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  RETAILER_SITE_code int NOT NULL ,
  RETAILER_SITE_COUNTRY_CODE_country int NOT NULL,
  RETAILER_SITE_CITY_city varchar(50) NOT NULL,
  RETAILER_SITE_REGION_region varchar(50),
  RETAILER_SITE_POSTAL_ZONE_postal_zone varchar(20),
  RETAILER_SITE_RETAILER_CODE_retailer_code int,
  RETAILER_SITE_ACTIVE_INDICATOR_indicator bit NOT NULL,
  RETAILER_SITE_ADDRESS1_address varchar(255) NULL,
  RETAILER_SITE_ADDRESS2_address varchar(255) NULL,
  RETAILER_SITE_MAIN_ADDRESS_address varchar(255) NULL,
  LAST_UPDATED datetime2 NOT NULL DEFAULT SYSDATETIME(), -- Add LAST_UPDATED column
  CURRENT_VALUE bit NOT NULL DEFAULT 1 -- Add CURRENT column
);

CREATE TABLE Retailer_segment (
  RETAILER_SEGMENT_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  RETAILER_SEGMENT_segment_code int NOT NULL,
  RETAILER_SEGMENT_language char(2) NOT NULL,
  RETAILER_SEGMENT_segment_name varchar(50) NOT NULL,
  RETAILER_SEGMENT_SEGMENT_DESCRIPTION_description varchar(255) NOT NULL,
  SEGMENT_DESCRIPTION_description_short varchar(50) NULL,
  LAST_UPDATED datetime2 NOT NULL DEFAULT SYSDATETIME(), -- Add LAST_UPDATED column
  CURRENT_VALUE bit NOT NULL DEFAULT 1 -- Add CURRENT column
);

CREATE TABLE Retailer_headquarter (
  RETAILER_HEADQUARTER_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  RETAILER_HEADQUARTER_codemr int NOT NULL,
  RETAIL_HEADQUARTER_retailer_name varchar(50) NOT NULL,
  RETAILER_HEADQUARTER_address1_address varchar(255) NULL,
  RETAILER_HEADQUARTER_address2_address varchar(255) NULL,
  RETAILER_HEADQUARTER_main_address_address varchar(255) NULL,
  RETAILER_HEADQUARTER_country_code_country int NOT NULL,
  RETAILER_HEADQUARTER_region_region varchar(50),
  RETAILER_HEADQUARTER_city_city varchar(50) NOT NULL,
  RETAILER_HEADQUARTER_postal_zone_postal_zone varchar(20),
  RETAILER_HEADQUARTER_fax_fax varchar(50),
  RETAILER_HEADQUARTER_phone_phone varchar(50) NOT NULL,
  RETAILER_HEADQUARTER_segment_code int,
  LAST_UPDATED datetime2 NOT NULL DEFAULT SYSDATETIME(), -- Add LAST_UPDATED column
  CURRENT_VALUE bit NOT NULL DEFAULT 1 -- Add CURRENT column
);

CREATE TABLE Sales_branch (
  SALES_BRANCH_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  SALES_BRANCH_code int NOT NULL,
  SALES_BRANCH_COUNTRY_CODE_country int NOT NULL,
  SALES_BRANCH_REGION_region varchar(50) NULL,
  SALES_BRANCH_CITY_city varchar(50) NOT NULL,
  SALES_BRANCH_POSTAL_ZONE_postal_zone varchar(20),
  SALES_BRANCH_ADDRESS1_address varchar(255),
  SALES_BRANCH_ADDRESS2_address varchar(255),
  SALES_BRANCH_MAIN_ADDRESS_address varchar(255) NULL,
  LAST_UPDATED datetime2 NOT NULL DEFAULT SYSDATETIME(), -- Add LAST_UPDATED column
  CURRENT_VALUE bit NOT NULL DEFAULT 1 -- Add CURRENT column
);

CREATE TABLE Retailer_contact (
  RETAILER_CONTACT_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  RETAILER_CONTACT_code int NOT NULL,
  RETAILER_CONTACT_email varchar(255) NOT NULL,
  RETAILER_CONTACT_RETAILER_SITE_CODE_site_code int,
  FOREIGN KEY (RETAILER_CONTACT_RETAILER_SITE_CODE_site_code) REFERENCES Retailer_site(RETAILER_SITE_SK),
  RETAILER_CONTACT_JOB_POSITION_EN_position varchar(50),
  RETAILER_CONTACT_EXTENSION_extension varchar(50),
  RETAILER_CONTACT_FAX_fax varchar(50),
  RETAILER_CONTACT_GENDER_gender char(1),
  RETAILER_CONTACT_FIRST_NAME_first_name varchar(50) NOT NULL,
  RETAILER_CONTACT_LAST_NAME_last_name varchar(50) NOT NULL,
  RETAILER_CONTACT_FULL_NAME_full_name AS (RETAILER_CONTACT_FIRST_NAME_first_name + ' ' + RETAILER_CONTACT_LAST_NAME_last_name),
  LAST_UPDATED datetime2 NOT NULL DEFAULT SYSDATETIME(), -- Add LAST_UPDATED column
  CURRENT_VALUE bit NOT NULL DEFAULT 1 -- Add CURRENT column
);

CREATE TABLE Retailer (
  RETAILER_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  RETAILER_code int NOT NULL,
  RETAILER_name varchar(255) NOT NULL,
  RETAILER_COMPANY_CODE_MR_company varchar(50) NULL,
  RETAILER_RETAILER_TYPE_code int,
  RETAILER_RETAILER_TYPE_EN varchar(50) NOT NULL,
  LAST_UPDATED datetime2 NOT NULL DEFAULT SYSDATETIME(), -- Add LAST_UPDATED column
  CURRENT_VALUE bit NOT NULL DEFAULT 1 -- Add CURRENT column
);

CREATE TABLE Product (
  PRODUCT_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  PRODUCT_number INT NOT NULL,
  PRODUCT_name_product VARCHAR(MAX) NOT NULL,
  PRODUCT_description_description VARCHAR(MAX),
  PRODUCT_image_image VARCHAR(255), -- url to image
  PRODUCT_INTRODUCTION_DATE_introduced DATE,
  FOREIGN KEY (PRODUCT_INTRODUCTION_DATE_introduced) REFERENCES Date(DATE_date),
  PRODUCT_PRODUCTION_COST_cost money NOT NULL,
  PRODUCT_MARGIN_margin money NOT NULL,
  PRODUCT_LANGUAGE_language VARCHAR(5) NOT NULL,
  PRODUCT_MINIMUM_SALE_PRICE_minPrice AS (PRODUCT_PRODUCTION_COST_cost + PRODUCT_MARGIN_margin),
  PRODUCT_PRODUCT_LINE_code varchar(50),
  PRODUCT_PRODUCT_LINE_code_en VARCHAR(50),
  PRODUCT_PRODUCT_TYPE_code varchar(50),
  PRODUCT_PRODUCT_TYPE_code_en VARCHAR(50),
  LAST_UPDATED datetime2 NOT NULL DEFAULT SYSDATETIME(), -- Add LAST_UPDATED column
  CURRENT_VALUE bit NOT NULL DEFAULT 1 -- Add CURRENT column
);


CREATE TABLE Order_details (
  ORDER_DETAILS_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  ORDER_DETAILS_code int NOT NULL,
  ORDER_DETAILS_QUANTITY_quantity int NOT NULL,
  ORDER_DETAILS_TOTAL_COST_total money NOT NULL,
  ORDER_DETAILS_TOTAL_MARGIN_margin money NOT NULL,
  ORDER_DETAILS_RETURN_CODE_returned varchar(50),
  ORDER_DETAILS_ORDER_NUMBER_order int,
  ORDER_DETAILS_PRODUCT_NUMBER_product int,
  ORDER_DETAILS_UNIT_ID_unit int,
  FOREIGN KEY (ORDER_DETAILS_ORDER_NUMBER_order) REFERENCES "Order"(ORDER_SK),
  FOREIGN KEY (ORDER_DETAILS_PRODUCT_NUMBER_product) REFERENCES Product(PRODUCT_SK),
  FOREIGN KEY (ORDER_DETAILS_UNIT_ID_unit) REFERENCES Unit(UNIT_SK),
  LAST_UPDATED datetime2 NOT NULL DEFAULT SYSDATETIME(), -- Add LAST_UPDATED column
  CURRENT_VALUE bit NOT NULL DEFAULT 1 -- Add CURRENT column
);

CREATE TABLE Returned_item (
  RETURNED_ITEM_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  RETURNED_ITEM_code VARCHAR(20) NOT NULL,
  RETURNED_ITEM_DATE DATE NOT NULL,
  FOREIGN KEY (RETURNED_ITEM_DATE) REFERENCES Date(DATE_date),
  RETURNED_ITEM_QUANTITY INT NOT NULL,
  RETURNED_ITEM_ORDER_DETAIL_CODE INT REFERENCES Order_details(ORDER_DETAILS_SK),
  RETURNED_ITEM_RETURN_REASON_code INT NOT NULL,
  RETURNED_ITEM_RETURN_REASON_description_en VARCHAR(255),
  RETURNED_ITEM_RETURNED_ITEMS_TOTAL_PRICE money NOT NULL,
  LAST_UPDATED datetime2 NOT NULL DEFAULT SYSDATETIME(), -- Add LAST_UPDATED column
  CURRENT_VALUE bit NOT NULL DEFAULT 1 -- Add CURRENT column
);

CREATE TABLE SALES_TARGETDATA (
  SALES_TARGETDATA_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  SALES_TARGETDATA_SALES_TARGETDATA_ID int NOT NULL,
  SALES_TARGETDATA_SALES_YEAR int NOT NULL,
  SALES_TARGETDATA_SALES_PERIOD varchar(50) NOT NULL,
  SALES_TARGETDATA_RETAILER_NAME varchar(255),
  SALES_TARGETDATA_SALES_TARGET money NOT NULL,
  SALES_TARGETDATA_TARGET_COST money NOT NULL,
  SALES_TARGETDATA_TARGET_MARGIN money NOT NULL,
  SALES_TARGETDATA_SALES_STAFF_CODE int NOT NULL,
  SALES_TARGETDATA_PRODUCT_NUMBER int NOT NULL,
  SALES_TARGETDATA_RETAILER_CODE int NOT NULL,
  FOREIGN KEY (SALES_TARGETDATA_SALES_STAFF_CODE) REFERENCES Sales_staff(SALES_STAFF_SK),
  FOREIGN KEY (SALES_TARGETDATA_PRODUCT_NUMBER) REFERENCES Product(PRODUCT_SK),
  FOREIGN KEY (SALES_TARGETDATA_RETAILER_CODE) REFERENCES Retailer(RETAILER_SK),
  LAST_UPDATED datetime2 NOT NULL DEFAULT SYSDATETIME(), -- Add LAST_UPDATED column
  CURRENT_VALUE bit NOT NULL DEFAULT 1 -- Add CURRENT column
);

CREATE TABLE Training (
  TRAINING_SALES_STAFF_CODE INT NOT NULL,
  FOREIGN KEY (TRAINING_SALES_STAFF_CODE) REFERENCES Sales_staff(SALES_STAFF_SK),
  TRAINING_COURSE_CODE INT NOT NULL,
  FOREIGN KEY (TRAINING_COURSE_CODE) REFERENCES Course(COURSE_SK),
  TRAINING_YEAR INT NOT NULL,
  FOREIGN KEY (TRAINING_YEAR) REFERENCES Year(Year),
  PRIMARY KEY (TRAINING_SALES_STAFF_CODE, TRAINING_COURSE_CODE),  -- Use composite primary key for unique combination
  LAST_UPDATED datetime2 NOT NULL DEFAULT SYSDATETIME(), -- Add LAST_UPDATED column
  CURRENT_VALUE bit NOT NULL DEFAULT 1 -- Add CURRENT column
);

CREATE TABLE Satisfaction (
  SATISFACTION_SALES_STAFF_CODE INT NOT NULL,
  FOREIGN KEY (SATISFACTION_SALES_STAFF_CODE) REFERENCES Sales_staff(SALES_STAFF_SK),
  SATISFACTION_SATISFACTION_TYPE_CODE INT NOT NULL,
  FOREIGN KEY (SATISFACTION_SATISFACTION_TYPE_CODE) REFERENCES Satisfaction_type(SATISFACTION_TYPE_SK),
  PRIMARY KEY (SATISFACTION_SALES_STAFF_CODE, SATISFACTION_SATISFACTION_TYPE_CODE),  -- Use composite primary key for unique combination
  SATISFACTION_YEAR INT NOT NULL,
  FOREIGN KEY (SATISFACTION_YEAR) REFERENCES Year(Year),
  LAST_UPDATED datetime2 NOT NULL DEFAULT SYSDATETIME(), -- Add LAST_UPDATED column
  CURRENT_VALUE bit NOT NULL DEFAULT 1 -- Add CURRENT column
);

CREATE TABLE Order_header (
  ORDER_HEADER_SK int IDENTITY(1,1) PRIMARY KEY, -- Use auto-incrementing ID as primary key
  ORDER_HEADER_number int NOT NULL,
  ORDER_HEADER_RETAILER_CODE int NOT NULL,  -- Foreign key referencing Retailer table
  FOREIGN KEY (ORDER_HEADER_RETAILER_CODE) REFERENCES Retailer(RETAILER_SK),
  ORDER_HEADER_SALES_STAFF_CODE int NOT NULL,  -- Foreign key referencing Sales_staff table
  FOREIGN KEY (ORDER_HEADER_SALES_STAFF_CODE) REFERENCES Sales_staff(SALES_STAFF_SK),
  ORDER_HEADER_SALES_BRANCH_CODE int,  -- Foreign key referencing Sales_branch table (nullable)
  FOREIGN KEY (ORDER_HEADER_SALES_BRANCH_CODE) REFERENCES Sales_branch(SALES_BRANCH_SK),
  ORDER_HEADER_ORDER_DATE date NOT NULL,
  FOREIGN KEY (ORDER_HEADER_ORDER_DATE) REFERENCES Date(DATE_date),
  ORDER_HEADER_RETAILER_SITE_CODE int,  -- Foreign key referencing Retailer_site table (nullable)
  FOREIGN KEY (ORDER_HEADER_RETAILER_SITE_CODE) REFERENCES Retailer_site(RETAILER_SITE_SK),
  ORDER_HEADER_RETAILER_CONTACT_CODE int,  -- Foreign key referencing Retailer_contact table (nullable)
  FOREIGN KEY (ORDER_HEADER_RETAILER_CONTACT_CODE) REFERENCES Retailer_contact(RETAILER_CONTACT_SK),
  LAST_UPDATED datetime2 NOT NULL DEFAULT SYSDATETIME(), -- Add LAST_UPDATED column
  CURRENT_VALUE bit NOT NULL DEFAULT 1 -- Add CURRENT column
);

CREATE TABLE GO_SALES_INVENTORY_LEVELS (
  GO_SALES_INVENTORY_LEVELS_SK INT PRIMARY KEY IDENTITY(1,1), -- Use auto-incrementing ID as primary key
  GO_SALES_INVENTORY_LEVELS_id INT NOT NULL,
  GO_SALES_INVENTORY_LEVELS_INVENTORY_COUNT INT NOT NULL,
  GO_SALES_INVENTORY_LEVELS_PRODUCT_NUMBER INT NOT NULL,
  FOREIGN KEY (GO_SALES_INVENTORY_LEVELS_PRODUCT_NUMBER) REFERENCES Product (PRODUCT_SK),
  GO_SALES_INVENTORY_LEVELS_YEAR_MONTH char(7) NOT NULL,  -- Combine year and month for efficient storage and retrieval
  LAST_UPDATED datetime2 NOT NULL DEFAULT SYSDATETIME(), -- Add LAST_UPDATED column
  CURRENT_VALUE bit NOT NULL DEFAULT 1 -- Add CURRENT column
);

CREATE TABLE GO_SALES_PRODUCT_FORECAST (
  GO_SALES_PRODUCT_FORECAST_SK INT PRIMARY KEY IDENTITY(1,1), -- Use auto-incrementing ID as primary key
  GO_SALES_PRODUCT_FORECAST_id INT NOT NULL, -- Use auto-incrementing ID as primary key
  GO_SALES_PRODUCT_FORECAST_EXPECTED_VOLUME INT NOT NULL,
  GO_SALES_PRODUCT_FORECAST_EXPECTED_COST money NOT NULL,
  GO_SALES_PRODUCT_FORECAST_EXPECTED_MARGIN money NOT NULL,
  GO_SALES_PRODUCT_FORECAST_PRODUCT_NUMBER INT NOT NULL,
  FOREIGN KEY (GO_SALES_PRODUCT_FORECAST_PRODUCT_NUMBER) REFERENCES Product(PRODUCT_SK),
  GO_SALES_PRODUCT_FORECAST_YEAR_MONTH char(7) NOT NULL,  -- Combine year and month for efficient storage and retrieval
  LAST_UPDATED datetime2 NOT NULL DEFAULT SYSDATETIME(), -- Add LAST_UPDATED column
  CURRENT_VALUE bit NOT NULL DEFAULT 1 -- Add CURRENT column
);
GO

-- triggers
CREATE TRIGGER trg_Unit_CurrentValue
ON Unit
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE CURRENT_VALUE = 1)
    BEGIN
        DECLARE @sk int = (SELECT UNIT_SK FROM inserted);
        DECLARE @code int = (SELECT UNIT_id from inserted)
        UPDATE Unit
        SET CURRENT_VALUE = 0
        WHERE UNIT_id = @code AND UNIT_SK != @sk;
    END
END;
GO

CREATE TRIGGER trg_Sales_staff_CurrentValue
ON Sales_staff
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE CURRENT_VALUE = 1)
    BEGIN
        DECLARE @sk int = (SELECT SALES_STAFF_SK FROM inserted);
        DECLARE @code int = (SELECT SALES_STAFF_code from inserted)
        UPDATE Sales_staff
        SET CURRENT_VALUE = 0
        WHERE SALES_STAFF_code = @code AND SALES_STAFF_SK != @sk;
    END
END;
GO

CREATE TRIGGER trg_Satisfaction_type_CurrentValue
ON Satisfaction_type
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE CURRENT_VALUE = 1)
    BEGIN
        DECLARE @sk int = (SELECT SATISFACTION_TYPE_SK FROM inserted);
        DECLARE @code int = (SELECT SATISFACTION_TYPE_code from inserted)
        UPDATE Satisfaction_type
        SET CURRENT_VALUE = 0
        WHERE SATISFACTION_TYPE_code = @code AND SATISFACTION_TYPE_SK != @sk;
    END
END;
GO

CREATE TRIGGER trg_Course_CurrentValue
ON Course
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE CURRENT_VALUE = 1)
    BEGIN
        DECLARE @sk int = (SELECT COURSE_SK FROM inserted);
        DECLARE @code int = (SELECT COURSE_code from inserted)
        UPDATE COURSE
        SET CURRENT_VALUE = 0
        WHERE COURSE_code = @code AND COURSE_SK != @sk;
    END
END;
GO

CREATE TRIGGER trg_Order_CurrentValue
    ON "Order"
    AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (SELECT 1 FROM inserted WHERE CURRENT_VALUE = 1)
        BEGIN
            DECLARE @sk int = (SELECT ORDER_SK FROM inserted);
            DECLARE @code int = (SELECT ORDER_order_number from inserted)
            UPDATE "Order"
            SET CURRENT_VALUE = 0
            WHERE ORDER_order_number = @code AND ORDER_SK != @sk;
        END
    END;
GO

CREATE TRIGGER trg_Retailer_site_CurrentValue
    ON Retailer_site
    AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (SELECT 1 FROM inserted WHERE CURRENT_VALUE = 1)
        BEGIN
            DECLARE @sk int = (SELECT RETAILER_SITE_SK FROM inserted);
            DECLARE @code int = (SELECT RETAILER_SITE_code from inserted)
            UPDATE Retailer_site
            SET CURRENT_VALUE = 0
            WHERE RETAILER_SITE_code = @code AND RETAILER_SITE_SK != @sk;
        END
    END;
GO

CREATE TRIGGER trg_Retailer_segment_CurrentValue
    ON Retailer_segment
    AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (SELECT 1 FROM inserted WHERE CURRENT_VALUE = 1)
        BEGIN
            DECLARE @sk int = (SELECT RETAILER_SEGMENT_SK FROM inserted);
            DECLARE @code int = (SELECT RETAILER_SEGMENT_segment_code from inserted)
            UPDATE Retailer_segment
            SET CURRENT_VALUE = 0
            WHERE RETAILER_SEGMENT_segment_code = @code AND RETAILER_SEGMENT_SK != @sk;
        END
    END;
GO

CREATE TRIGGER trg_Retailer_headquarter_CurrentValue
    ON Retailer_headquarter
    AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (SELECT 1 FROM inserted WHERE CURRENT_VALUE = 1)
        BEGIN
            DECLARE @sk int = (SELECT RETAILER_HEADQUARTER_SK FROM inserted);
            DECLARE @code int = (SELECT RETAILER_HEADQUARTER_codemr from inserted)
            UPDATE Retailer_headquarter
            SET CURRENT_VALUE = 0
            WHERE RETAILER_HEADQUARTER_codemr = @code AND RETAILER_HEADQUARTER_SK != @sk;
        END
    END;
GO

CREATE TRIGGER trg_Sales_branch_CurrentValue
    ON Sales_branch
    AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (SELECT 1 FROM inserted WHERE CURRENT_VALUE = 1)
        BEGIN
            DECLARE @sk int = (SELECT SALES_BRANCH_SK FROM inserted);
            DECLARE @code int = (SELECT SALES_BRANCH_code from inserted)
            UPDATE Sales_branch
            SET CURRENT_VALUE = 0
            WHERE SALES_BRANCH_code = @code AND SALES_BRANCH_SK != @sk;
        END
    END;
GO

CREATE TRIGGER trg_Retailer_contact_CurrentValue
    ON Retailer_contact
    AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (SELECT 1 FROM inserted WHERE CURRENT_VALUE = 1)
        BEGIN
            DECLARE @sk int = (SELECT RETAILER_CONTACT_SK FROM inserted);
            DECLARE @code int = (SELECT RETAILER_CONTACT_code from inserted)
            UPDATE Retailer_contact
            SET CURRENT_VALUE = 0
            WHERE RETAILER_CONTACT_code = @code AND RETAILER_CONTACT_SK != @sk;
        END
    END;
GO

CREATE TRIGGER trg_Retailer_CurrentValue
    ON Retailer
    AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (SELECT 1 FROM inserted WHERE CURRENT_VALUE = 1)
        BEGIN
            DECLARE @sk int = (SELECT RETAILER_SK FROM inserted);
            DECLARE @code int = (SELECT RETAILER_code from inserted)
            UPDATE Retailer
            SET CURRENT_VALUE = 0
            WHERE RETAILER_code = @code AND RETAILER_SK != @sk;
        END
    END;
GO

CREATE TRIGGER trg_Product_CurrentValue
    ON Product
    AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (SELECT 1 FROM inserted WHERE CURRENT_VALUE = 1)
        BEGIN
            DECLARE @sk int = (SELECT PRODUCT_SK FROM inserted);
            DECLARE @code int = (SELECT PRODUCT_number from inserted)
            UPDATE Product
            SET CURRENT_VALUE = 0
            WHERE PRODUCT_number = @code AND PRODUCT_SK != @sk;
        END
    END;
GO

CREATE TRIGGER trg_Order_details_CurrentValue
    ON Order_details
    AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (SELECT 1 FROM inserted WHERE CURRENT_VALUE = 1)
        BEGIN
            DECLARE @sk int = (SELECT ORDER_DETAILS_SK FROM inserted);
            DECLARE @code int = (SELECT ORDER_DETAILS_code from inserted)
            UPDATE Order_details
            SET CURRENT_VALUE = 0
            WHERE ORDER_DETAILS_code = @code AND ORDER_DETAILS_SK != @sk;
        END
    END;
GO

CREATE TRIGGER trg_Returned_item_CurrentValue
    ON Returned_item
    AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (SELECT 1 FROM inserted WHERE CURRENT_VALUE = 1)
        BEGIN
            DECLARE @sk int = (SELECT RETURNED_ITEM_SK FROM inserted);
            DECLARE @code int = (SELECT RETURNED_ITEM_code from inserted)
            UPDATE Returned_item
            SET CURRENT_VALUE = 0
            WHERE RETURNED_ITEM_code = @code AND RETURNED_ITEM_SK != @sk;
        END
    END;
GO

CREATE TRIGGER trg_SALES_TARGETDATA_CurrentValue
    ON SALES_TARGETDATA
    AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (SELECT 1 FROM inserted WHERE CURRENT_VALUE = 1)
        BEGIN
            DECLARE @sk int = (SELECT SALES_TARGETDATA_SK FROM inserted);
            DECLARE @code int = (SELECT SALES_TARGETDATA_SALES_TARGETDATA_ID from inserted)
            UPDATE SALES_TARGETDATA
            SET CURRENT_VALUE = 0
            WHERE SALES_TARGETDATA_SALES_TARGETDATA_ID = @code AND SALES_TARGETDATA_SK != @sk;
        END
    END;
GO

CREATE TRIGGER trg_Order_header_CurrentValue
    ON Order_header
    AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (SELECT 1 FROM inserted WHERE CURRENT_VALUE = 1)
        BEGIN
            DECLARE @sk int = (SELECT ORDER_HEADER_SK FROM inserted);
            DECLARE @code int = (SELECT ORDER_HEADER_number from inserted)
            UPDATE Order_header
            SET CURRENT_VALUE = 0
            WHERE ORDER_HEADER_number = @code AND ORDER_HEADER_SK != @sk;
        END
    END;
GO

CREATE TRIGGER trg_GO_SALES_INVENTORY_LEVELS_CurrentValue
    ON GO_SALES_INVENTORY_LEVELS
    AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (SELECT 1 FROM inserted WHERE CURRENT_VALUE = 1)
        BEGIN
            DECLARE @sk int = (SELECT GO_SALES_INVENTORY_LEVELS_SK FROM inserted);
            DECLARE @code int = (SELECT GO_SALES_INVENTORY_LEVELS_id from inserted)
            UPDATE GO_SALES_INVENTORY_LEVELS
            SET CURRENT_VALUE = 0
            WHERE GO_SALES_INVENTORY_LEVELS_id = @code AND GO_SALES_INVENTORY_LEVELS_SK != @sk;
        END
    END;
GO

CREATE TRIGGER trg_GO_SALES_PRODUCT_FORECAST_CurrentValue
    ON GO_SALES_PRODUCT_FORECAST
    AFTER INSERT, UPDATE
AS
    BEGIN
        IF EXISTS (SELECT 1 FROM inserted WHERE CURRENT_VALUE = 1)
        BEGIN
            DECLARE @sk int = (SELECT GO_SALES_PRODUCT_FORECAST_SK FROM inserted);
            DECLARE @code int = (SELECT GO_SALES_PRODUCT_FORECAST_id from inserted)
            UPDATE GO_SALES_PRODUCT_FORECAST
            SET CURRENT_VALUE = 0
            WHERE GO_SALES_PRODUCT_FORECAST_id = @code AND GO_SALES_PRODUCT_FORECAST_SK != @sk;
        END
    END;
GO

CREATE TRIGGER trg_Sales_Staff_Address2
ON Sales_staff
AFTER INSERT, UPDATE
AS
BEGIN
    -- Check if SALES_STAFF_ADDRESS2_address is an empty string
    IF EXISTS (SELECT 1 FROM inserted WHERE inserted.SALES_STAFF_SALES_BRANCH_ADDRESS2_address = '')
    BEGIN
        -- If it is, set it to NULL
        UPDATE Sales_staff
        SET SALES_STAFF_SALES_BRANCH_ADDRESS2_address = NULL
        WHERE SALES_STAFF_SK IN (SELECT SALES_STAFF_SK FROM inserted WHERE SALES_STAFF_SALES_BRANCH_ADDRESS2_address = '');
    END
END;
GO

CREATE TRIGGER trg_Sales_Branch_Address2
ON Sales_branch
AFTER INSERT, UPDATE
AS
BEGIN
    -- Check if SALES_STAFF_ADDRESS2_address is an empty string
    IF EXISTS (SELECT 1 FROM inserted WHERE inserted.SALES_BRANCH_ADDRESS2_address = '')
    BEGIN
        -- If it is, set it to NULL
        UPDATE Sales_branch
        SET SALES_BRANCH_ADDRESS2_address = NULL
        WHERE SALES_BRANCH_SK IN (SELECT SALES_BRANCH_SK FROM inserted WHERE SALES_BRANCH_ADDRESS2_address = '');
    END
END;
GO

CREATE TRIGGER trg_Retailer_Site_Address2
ON Retailer_site
AFTER INSERT, UPDATE
AS
BEGIN
    -- Check if SALES_STAFF_ADDRESS2_address is an empty string
    IF EXISTS (SELECT 1 FROM inserted WHERE inserted.RETAILER_SITE_ADDRESS2_address = '')
    BEGIN
        -- If it is, set it to NULL
        UPDATE Retailer_site
        SET RETAILER_SITE_ADDRESS2_address = NULL
        WHERE RETAILER_SITE_SK IN (SELECT RETAILER_SITE_SK FROM inserted WHERE RETAILER_SITE_ADDRESS2_address = '');
    END
END;
GO

CREATE TRIGGER trg_Retailer_Headquarters_Address2
ON Retailer_headquarter
AFTER INSERT, UPDATE
AS
BEGIN
    -- Check if SALES_STAFF_ADDRESS2_address is an empty string
    IF EXISTS (SELECT 1 FROM inserted WHERE inserted.RETAILER_HEADQUARTER_address2_address = '')
    BEGIN
        -- If it is, set it to NULL
        UPDATE Retailer_headquarter
        SET RETAILER_HEADQUARTER_address2_address = NULL
        WHERE RETAILER_HEADQUARTER_SK IN (SELECT RETAILER_HEADQUARTER_SK FROM inserted WHERE RETAILER_HEADQUARTER_address2_address = '');
    END
END;