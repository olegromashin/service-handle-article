module Main where

import Services.Logger (LogHandle (..))
import App.Registration (registerUser)

main :: IO ()
main = do
  let config = ()
  let logHandle = LogHandle {writeLog = putStrLn}
  registerChandler config logHandle
  where
    registerChandler config logHandle = do
      let login = "Chandler"
      let password = "123456"
      let email = "cbing@amusebush.com"
      createUserRes <- registerUser config logHandle login password email
      case createUserRes of
        Left err -> writeLog logHandle err
        Right _ -> writeLog logHandle $ "User " ++ login ++ " registered successfuly."
