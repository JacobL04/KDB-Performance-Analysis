-- PostgreSQL benchmark queries

-- Closing prices fpr a stock within a given date range
PREPARE stock_prices_range(TEXT, DATE, DATE) AS
SELECT
    trade_date AS date,
    close_price AS close
FROM stock_prices
WHERE symbol = $1
  AND trade_date BETWEEN $2 AND $3
ORDER BY trade_date ASC;


-- Total trading volume per stock per day over a given date range
PREPARE daily_volume(DATE, DATE) AS
SELECT
    trade_date AS date,
    symbol,
    SUM(volume) AS "totalVolume"
FROM stock_prices
WHERE trade_date BETWEEN $1 AND $2
GROUP BY trade_date, symbol
ORDER BY trade_date ASC,
         symbol COLLATE "C" ASC;


-- Closing prices for all stocks on a given day
PREPARE closing_prices(DATE) AS
SELECT
    symbol,
    close_price AS close
FROM stock_prices
WHERE trade_date = $1
ORDER BY symbol COLLATE "C" ASC;
