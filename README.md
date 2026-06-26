# Final Project Assigment #
Required to use an AI assistant to populate data in SQL from source data (CMMS_assets.xlsx).

![Database ER diagram .png](res/Database%20ER%20diagram%20.png)

# Files 
**src/tables creation.sql** - creates the database tables, primary keys, and foreign key constraints required for the commercial property data schema.

**src/data population.sql** - inserts the manufacturer, category, product, and asset data into the appropriate tables.

**src/helper/Drop Order.sql** - use this if the tables need to be reset. It drops the tables in the correct order to account for foreign key relationships and prevent errors caused by linked columns.

**src/helper/Testing.sql** - contains test queries used to verify that the tables were created correctly, all data was inserted, foreign keys are valid, and no required records are missing.
