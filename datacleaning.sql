select*
from [nashvill house]


Select saleDate, CONVERT(Date,SaleDate)
from [nashvill house]


Update [nashvill house]
SET SaleDate = CONVERT(Date,SaleDate)


select*
from [nashvill house]
order by ParcelID


select  a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress) as addresss
from [project 2 ]..[nashvill house]a
join [project 2 ]..[nashvill house]b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is not null 

update a 
set propertyaddress = ISNULL(a.PropertyAddress,b.PropertyAddress) 
from [project 2 ]..[nashvill house]a
join [project 2 ]..[nashvill house]b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is  null  

--Breaking out Address into Individual Columns (Address, City, State)


select PropertyAddress
from [project 2 ]..[nashvill house]
--order by 

SELECT
SUBSTRING(PropertyAddress,1, CHARINDEX(',', PropertyAddress)-1 ) as Address
from [nashvill house]

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address
from [nashvill house]

alter table[nashvill house]
add propertysplitaddress nvarchar(225)

Update [nashvill house]
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


alter table[nashvill house] 
add propertysplitcity nvarchar(225)

update [nashvill house]
set propertysplitcity = sUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))


select PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
from [nashvill house]

alter table[nashvill house]
add ownersplitaddress nvarchar(225)

Update [nashvill house]
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


alter table[nashvill house] 
add ownersplitcity nvarchar(225)

update [nashvill house]
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2) 

alter table[nashvill house] 
add ownersplitstate nvarchar(225)

update [nashvill house]
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)


-- Change Y and N to Yes and No in "Sold as Vacant" field
select DISTINCT (SoldAsVacant)
from [nashvill house]

Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
	   from [nashvill house]


	   update [nashvill house]
	   set  SoldAsVacant =  CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END


-- Remove Duplicates
select*
from [nashvill house] 

Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num
			from [nashvill house]
			--order by ParcelID




			WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From [nashvill house]
--order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress



Select *
From [nashvill house]

alter table [nashvill house]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

			

