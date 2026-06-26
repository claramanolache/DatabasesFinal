/* Verify each Asset links to the Product created from the same source
   Manufacturer and Model values. This query should return zero rows. */
USE acme_commercial_property;

SELECT
    a.AssetID,
    a.Name AS AssetName,
    a.ProductID,
    p.ModelNum,
    m.Name AS ManufacturerName
FROM Asset AS a
         LEFT JOIN Product AS p
                   ON a.ProductID = p.ProductID
         LEFT JOIN Manufacturer AS m
                   ON p.ManufacturerID = m.ManufacturerID
WHERE p.ProductID IS NULL;

# result is zero rows