module Services.Logger where

data LogHandle m = LogHandle
  { writeLog :: String -> m ()
  }
