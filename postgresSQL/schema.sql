-- Creating the postgresSQL table that will hold the benchmark stock market data (Kaggle dataset)

CREATE TABLE IF NOT EXISTS stock_prices (
    trade_date DATE NOT NULL,
    open_price DOUBLE PRECISION,
    high_price DOUBLE PRECISION,
    low_price DOUBLE PRECISION,
    close_price DOUBLE PRECISION,
    volume BIGINT,
    symbol TEXT NOT NULL
);
