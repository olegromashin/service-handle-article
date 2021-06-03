module App.Registration where

import qualified App.DatabaseQueries.User as DB
import qualified App.Handlers.Registration as Handler
import App.Types.APISuccess (APISuccess)
import App.Types.Config (Config)
import App.Types.User (Email, Login, Password)
import Services.Logger (LogHandle)

registerUser :: Config -> LogHandle IO -> Login -> Password -> Email -> IO (Either String APISuccess)
registerUser config logHandle login password email =
  Handler.registerUser handle login password email
  where
    handle =
      Handler.Handle
        { Handler.createUser = \login password email -> DB.createUser config login password email,
          Handler.findUserByLogin = \login -> DB.findUserByLogin config login,
          Handler.findUserByEmail = \email -> DB.findUserByEmail config email,
          Handler.logHandle = logHandle
        }
