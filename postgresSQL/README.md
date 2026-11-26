# PostgreSQL Setup

This folder contains the PostgreSQL implementation used to compare performance against KDB+. Each row contains the prices and trading volume for one stock on one trading day.

## Get It Started

1. Install PostgreSQL. We tested this on PostgreSQL 18.6.
2. Download `all_stocks_5yr.csv` from [Cam Nugent's S&P 500 dataset on Kaggle](https://www.kaggle.com/camnugent/sandp500/data).
3. From the repository root, create the database (only if it doesn't already exist):

```bash
psql -U postgres -d postgres -c "CREATE DATABASE stock_market_benchmark;"
```

4. Create the stock data table using `schema.sql`:

```bash
psql -U postgres -d stock_market_benchmark -f postgresSQL/schema.sql
```

5. Connect to the database:

```bash
psql -U postgres -d stock_market_benchmark
```

6. Import the Kaggle CSV into an empty `stock_prices` table (replace the path with your CSV location):

```sql
\copy stock_prices (trade_date, open_price, high_price, low_price, close_price, volume, symbol) FROM '/path/to/all_stocks_5yr.csv' WITH (FORMAT csv, HEADER true)
```

Verify the import:

```sql
SELECT COUNT(*) FROM stock_prices;
```

You should see `619040`. This means the stock data was imported successfully, and CSV's `Name` is stored as `symbol`.

Do not import the same CSV twice into a populated table, or duplicate records will be inserted.

## Run the Queries

Inside psql, from the repository root:

```sql
\i postgresSQL/queries.sql

EXECUTE stock_prices_range('AAPL', '2018-01-29', '2018-02-07');

EXECUTE daily_volume('2018-01-29', '2018-02-07');

EXECUTE closing_prices('2018-02-07');
```

On the 10k subset, These should return 8 rows, 4,040 rows, and 505 rows, respectively. Both ends of the date range are included.

The query prepared statements must be loaded again when starting a new PostgreSQL session.

## Benchmark Sizes

Use 10k, 50k, 100k, 250k, and the full 619,040 rows for the 600k+ run.

Sort by date newest first, then ticker A-Z, and take the first N records. The PostgreSQL ordering is:

```sql
ORDER BY trade_date DESC, symbol COLLATE "C" ASC
```

Both databases must use identical subsets and query parameters. Load each subset before timing queries, and run the final experiments on the same machine.
