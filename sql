create table DUPLICATED_INVOICES(
INVOICE_NUMBER INT,COUNT_OF_DUPLICATES INT
);
INSERT INTO DUPLICATED_INVOICES(INVOICE_NUMBER,COUNT_OF_DUPLICATES)
SELECT `Invoice Number`,COUNT(*) AS COUNT_OF_DUPLICATES 
FROM evolve_academy_technical_assessment_invoice_transactions_1
group by `Invoice Number`
;
select * from DUPLICATED_INVOICES;
create table BLOCKED_VENDORS(VENDOR_NAME TEXT);
INSERT INTO BLOCKED_VENDORS(VENDOR_NAME)
SELECT distinct Name FROM evolve_academy_technical_assessment_vendor_data
JOIN evolve_academy_technical_assessment_invoice_transactions_1
ON evolve_academy_technical_assessment_vendor_data.`ï»¿Legacy Unique Identifier`=evolve_academy_technical_assessment_invoice_transactions_1.`Vendor Number`
WHERE `Invoice Status`= 'B';
SELECT * FROM BLOCKED_VENDORS;
create table TOTAL_VENDOR(Total int);
INSERT INTO TOTAL_VENDOR(Total)
select count(`ï»¿Legacy Unique Identifier`) from evolve_academy_technical_assessment_vendor_data
where name = 'Incorporated Path';
select * from TOTAL_VENDOR;
ALTER TABLE evolve_academy_technical_assessment_invoice_transactions_1
add Invoice_date  date,
add Invoice_time time;
UPDATE evolve_academy_technical_assessment_invoice_transactions_1
SET Invoice_date = STR_TO_DATE(SUBSTRING(`Invoice Date`, 1, 10), '%d/%m/%Y'),
    Invoice_time = TIME_FORMAT('00:00:00', '%H:%i:%s');

