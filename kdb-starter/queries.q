/ Sort newest dates first, then ticker A-Z, before taking each subset.
benchmarkSizes:10000 50000 100000 250000 619040;
benchmarkOrder:{`date xdesc `symbol xasc x};

stockPrices:{[prices;ticker;dates]
  `date xasc select date,close from prices where symbol=ticker,date within dates
  };

dailyVolume:{[prices;dates]
  select totalVolume:sum volume by date,symbol from prices where date within dates
  };

closingPrices:{[prices;day]
  `symbol xasc select symbol,close from prices where date=day
  };
