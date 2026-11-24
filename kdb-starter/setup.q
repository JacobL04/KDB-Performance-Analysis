/ Use this for sample.csv or a file with the same columns.
loadPrices:{[path]
  data:("DSFFFFJ";enlist ",") 0: hsym `$path;
  expected:`date`symbol`open`high`low`close`volume;
  if[not (cols data)~expected;'"unexpected CSV header"];
  data
  };

/ Read the Kaggle CSV as downloaded. Name is the stock ticker.
loadKagglePrices:{[path]
  data:("DFFFFJS";enlist ",") 0: hsym `$path;
  expected:`date`open`high`low`close`volume`Name;
  if[not (cols data)~expected;'"unexpected Kaggle CSV header"];
  select date,symbol:Name,open,high,low,close,volume from data
  };
