USE acme_commercial_property;

/* 1. Display every product with its linked manufacturer. */
SELECT
    p.ProductID,
    p.Name AS ProductName,
    p.ModelNum,
    p.ManufacturerID,
    m.Name AS ManufacturerName
FROM Product AS p
LEFT JOIN Manufacturer AS m
    ON p.ManufacturerID = m.ManufacturerID
ORDER BY p.ProductID;


/* 2. Find products whose ManufacturerID does not exist.
   This query should return zero rows. */
SELECT
    p.ProductID,
    p.Name AS ProductName,
    p.ManufacturerID
FROM Product AS p
LEFT JOIN Manufacturer AS m
    ON p.ManufacturerID = m.ManufacturerID
WHERE m.ManufacturerID IS NULL;


/* 3. Count products with invalid ManufacturerID values.
   InvalidManufacturerCount should equal 0. */
SELECT
    COUNT(*) AS InvalidManufacturerCount
FROM Product AS p
LEFT JOIN Manufacturer AS m
    ON p.ManufacturerID = m.ManufacturerID
WHERE m.ManufacturerID IS NULL;


/* 4. Check that the manufacturer in the generated product name
   matches the linked Manufacturer table record.

   Products with a NULL manufacturer should use Generic.
   This query should return zero rows. */
SELECT
    p.ProductID,
    p.Name AS ProductName,
    p.ManufacturerID,
    m.Name AS LinkedManufacturer,
    SUBSTRING_INDEX(
        SUBSTRING_INDEX(p.Name, ':', 2),
        ':',
        -1
    ) AS ManufacturerInProductName
FROM Product AS p
INNER JOIN Manufacturer AS m
    ON p.ManufacturerID = m.ManufacturerID
WHERE
    (
        m.Name IS NULL
        AND SUBSTRING_INDEX(
                SUBSTRING_INDEX(p.Name, ':', 2),
                ':',
                -1
            ) <> 'Generic'
    )
    OR
    (
        m.Name IS NOT NULL
        AND SUBSTRING_INDEX(
                SUBSTRING_INDEX(p.Name, ':', 2),
                ':',
                -1
            ) <> m.Name
    );


/* 5. Show a summary of valid and invalid manufacturer links. */
SELECT
    COUNT(*) AS TotalProducts,
    SUM(
        CASE
            WHEN m.ManufacturerID IS NOT NULL THEN 1
            ELSE 0
        END
    ) AS ValidManufacturerLinks,
    SUM(
        CASE
            WHEN m.ManufacturerID IS NULL THEN 1
            ELSE 0
        END
    ) AS InvalidManufacturerLinks
FROM Product AS p
LEFT JOIN Manufacturer AS m
    ON p.ManufacturerID = m.ManufacturerID;


/* 6. Verify that every Product.ManufacturerID is present
   in the Manufacturer table using NOT EXISTS.
   This query should return zero rows. */
SELECT
    p.ProductID,
    p.Name,
    p.ManufacturerID
FROM Product AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM Manufacturer AS m
    WHERE m.ManufacturerID = p.ManufacturerID
);


/* 7. Review manufacturer assignments together with model numbers. */
SELECT
    p.ProductID,
    m.Name AS ManufacturerName,
    p.ModelNum,
    p.Name AS GeneratedProductName
FROM Product AS p
INNER JOIN Manufacturer AS m
    ON p.ManufacturerID = m.ManufacturerID
ORDER BY
    m.Name,
    p.ModelNum,
    p.ProductID;
