/*

Cleaning Data in SQL Queries

*/

-- retrieve loaded data
SELECT 
	* 
FROM 
	portfolio_project.nashville_housing
;

--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format

-- build and test the query...
SELECT 
	n_haus.SaleDate AS 'Original Sale Date',
--     n_haus.SaleDate_conv,
    CONVERT(n_haus.SaleDate, date) AS 'Converted Sale Date'
FROM 
	portfolio_project.nashville_housing as n_haus
;

-- create a column and dump the SaleDate values (converted into standard date format)...

-- alter the table and add column
ALTER TABLE nashville_housing
ADD SaleDate_conv date;

-- update the table column and load with converted data
UPDATE nashville_housing
SET SaleDate_conv = convert(SaleDate, date);

-- retrieve loaded data
SELECT 
	SaleDate_conv
FROM 
	nashville_housing
;

 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data if NULL

-- retrieve data...
SELECT 
	n_haus.UniqueID,
        n_haus.ParcelID,
	n_haus.PropertyAddress
FROM 
	portfolio_project.nashville_housing as n_haus
WHERE
	n_haus.PropertyAddress IS NULL
ORDER BY
		n_haus.ParcelID
;

-- build and test the query...
SELECT 
	n_haus1.ParcelID, 
    n_haus1.UniqueID,
	n_haus1.PropertyAddress AS 'Destination Address',
    n_haus2.ParcelID, 
    n_haus2.UniqueID,
	n_haus2.PropertyAddress AS 'Source Address'
FROM
	portfolio_project.nashville_housing n_haus1
    JOIN
		portfolio_project.nashville_housing n_haus2
	ON
		n_haus1.ParcelID = n_haus2.ParcelID
	AND
		n_haus1.UniqueID <> n_haus2.UniqueID
-- WHERE
-- 	n_haus1.PropertyAddress IS NULL
;

-- update the (NULL) table column...
UPDATE 
	portfolio_project.nashville_housing AS n_haus1
	JOIN
		portfolio_project.nashville_housing AS n_haus2
		ON
		n_haus1.ParcelID = n_haus2.ParcelID
		AND
		n_haus1.UniqueID <> n_haus2.UniqueID
SET 
	n_haus1.PropertyAddress = n_haus2.PropertyAddress
WHERE
	n_haus1.PropertyAddress IS NULL
;
     
-- retrieve data...
SELECT 
	UniqueID,
    ParcelID,
	PropertyAddress
FROM 
	portfolio_project.nashville_housing
WHERE
	PropertyAddress IS NULL
;

-----------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)

-- ********Split the PROPERTY address column value********
 
-- retrieve data...
SELECT
	PropertyAddress
FROM 
	portfolio_project.nashville_housing
;

-- Split the property addess and have it as (1) STREET and (2) CITY
-- build and test the query...
SELECT
	SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) -1) AS 'Addr Street Split',
    SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) +1) AS 'Addr City Split'
FROM 
	portfolio_project.nashville_housing
;

-- alter the table and add column
ALTER TABLE nashville_housing
ADD AddrStreet_split varchar(255);

-- update the table column and load with converted data
UPDATE nashville_housing
SET AddrStreet_split = SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) -1)
;

-- alter the table and add column
ALTER TABLE nashville_housing
ADD AddrCity_split varchar(255);

-- update the table column and load with converted data
UPDATE nashville_housing
SET AddrCity_split = SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) +1)
;

-- retrieve loaded data
SELECT
	AddrStreet_split,
    AddrCity_split
FROM
	nashville_housing
;

-- ********Split the OWNER address column value********
 
-- retrieve data...
SELECT
	OwnerAddress
FROM 
	portfolio_project.nashville_housing
;

-- Split the addess and have it as (1) Street and (2) City
-- build and test the query...
SELECT
	SUBSTRING(OwnerAddress, 1, LOCATE(',', OwnerAddress) -1) AS 'OAddr Street Split',
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1)) AS 'OAddr City Split',
	TRIM(SUBSTRING_INDEX(OwnerAddress, ',', -1)) AS 'OAddr State Split'
FROM 
	portfolio_project.nashville_housing
;

-- alter the table and add column (STREET)
ALTER TABLE nashville_housing
ADD OAddrStreet_split varchar(255);

-- update the table column and load with converted data
UPDATE nashville_housing
SET OAddrStreet_split = SUBSTRING(OwnerAddress, 1, LOCATE(',', OwnerAddress) -1)
;

-- alter the table and add column (CITY)
ALTER TABLE nashville_housing
ADD OAddrCity_split varchar(255);

-- update the table column and load with converted data
UPDATE nashville_housing
SET OAddrCity_split = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1))
;

-- alter the table and add column (STATE)
ALTER TABLE nashville_housing
ADD OAddrState_split varchar(255);

-- update the table column and load with converted data
UPDATE nashville_housing
SET OAddrState_split = TRIM(SUBSTRING_INDEX(OwnerAddress, ',', -1))
;

-- retrieve loaded data
SELECT
	OAddrStreet_split,
    OAddrCity_split,
	OAddrState_split
FROM
	nashville_housing
;
--------------------------------------------------------------------------------------------------------------------------

-- Change Y and N to Yes and No in "Sold as Vacant" field

-- retrieve data...
SELECT 
	DISTINCT(SoldAsVacant),
    COUNT(SoldAsVacant)
FROM 
	portfolio_project.nashville_housing
GROUP BY
	SoldAsVacant
ORDER BY
	2
;

-- change any 'Y' to 'Yes' and 'N' to 'No'
SELECT 
	SoldAsVacant,
CASE
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
    WHEN SoldAsVacant = 'N' THEN 'No'
    ELSE SoldAsVacant
END AS 'Updated Sold As Vacant'
FROM
	nashville_housing
-- WHERE SoldAsVacant = 'N' 
;

-- update the table column and load with converted data
UPDATE nashville_housing
SET SoldAsVacant =
CASE
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
    WHEN SoldAsVacant = 'N' THEN 'No'
    ELSE SoldAsVacant
END
;

-- retrieve data...
SELECT 
	DISTINCT(SoldAsVacant),
    COUNT(SoldAsVacant)
FROM 
	portfolio_project.nashville_housing
GROUP BY
	SoldAsVacant
ORDER BY
	2
;
-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

-- retrieve data (sampling of duplicates)...
SELECT
	* 
FROM
	portfolio_project.nashville_housing
WHERE
	ParcelID = '107 14 0 157.00'
;

-- using CTE (DISPLAY all duplicates)...
WITH RowNumCTE AS (
SELECT
	*,
ROW_NUMBER() OVER(
	PARTITION BY
		ParcelID,
        PropertyAddress,
        SalePrice,
        SaleDate,
        LegalReference
	ORDER BY
		UniqueID
	) AS RowNum
FROM
	portfolio_project.nashville_housing
ORDER BY
	ParcelID
    )
-- with CTE (temp table), RETRIEVE data from it (duplicates)
SELECT
	*
FROM
	RowNumCTE
WHERE
	RowNum > 1
ORDER BY
	PropertyAddress
;

-- using CTE (DELETE all duplicates)...
WITH RowNumCTE AS 
(
SELECT
	*,
	ROW_NUMBER() OVER(
		PARTITION BY
			ParcelID,
			PropertyAddress,
			SalePrice,
			SaleDate,
			LegalReference
		ORDER BY
			UniqueID
		) AS RowNum
FROM
	portfolio_project.nashville_housing
)
    -- with CTE, JOIN with the main table to be able to DELETE the duplicate data
DELETE
FROM
	nashville_housing
	USING
		nashville_housing 
		JOIN
			RowNumCTE 
		ON 
			nashville_housing.ParcelID = RowNumCTE.ParcelID
	WHERE
		RowNum > 1
;

---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns (part of the data cleanup for this exercise)

-- retrieve data...
SELECT
	PropertyAddress,
    OwnerAddress,
    SaleDate,
    TaxDistrict
FROM
	portfolio_project.nashville_housing
;

-- delete columns
ALTER TABLE 
	portfolio_project.nashville_housing
DROP COLUMN PropertyAddress,
DROP COLUMN OwnerAddress,
DROP COLUMN SaleDate,
DROP COLUMN TaxDistrict
;

SELECT
	*
FROM
	portfolio_project.nashville_housing
;


-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
