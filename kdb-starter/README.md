# kdb+ setup

This folder loads the same daily stock data we're using for the PostgreSQL comparison. Each row has the prices and volume for one stock on one trading day.

## Get it running

1. Install [KDB-X Community Edition](https://code.kx.com/kdb-x/get_started/kdb-x-install.html). We tested this on KDB-X 5.0 in Ubuntu under WSL.
2. Download the combined `all_stocks_5yr.csv` from [Cam Nugent's S&P 500 dataset on Kaggle](https://www.kaggle.com/camnugent/sandp500/data). Put it beside `setup.q` with the original header.
3. From this folder, run `q setup.q` and enter the following at the q prompt, one line at a time:

```q
prices:loadKagglePrices["all_stocks_5yr.csv"]
count prices
```

You should see `619040`. The table is now in memory, and the CSV's `Name` column appears as `symbol` in q.

If you want to check the setup before downloading the full dataset, run `count loadPrices["sample.csv"]`. It should return `3`.

## Run the queries

```q
\l queries.q
orderedPrices:benchmarkOrder prices
subset:10000#orderedPrices
stockPrices[subset;`AAPL;2018.01.29 2018.02.07]
dailyVolume[subset;2018.01.29 2018.02.07]
closingPrices[subset;2018.02.07]
```

On the 10k subset, these should return 8 rows, 4,040 rows, and 505 rows, respectively. Both ends of the date range are included.

## Benchmark sizes

Use 10k, 50k, 100k, 250k, and the full 619,040 rows for the 600k+ run. Sort by date newest first, then ticker A–Z, and take the first N rows. In PostgreSQL, use `COLLATE "C"` when sorting the ticker. Keep the same dates and ticker at each size. Set up each subset before timing the queries.
