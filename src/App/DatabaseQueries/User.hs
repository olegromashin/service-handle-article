module App.DatabaseQueries.User where

import App.Types.Config (Config)
import App.Types.User (Email, Login, Password, User, UserId)

createUser :: Config -> Login -> Password -> Email -> IO ()
createUser _ _ _ _ = return ()

findUserByLogin :: Config -> Login -> IO (Maybe User)
findUserByLogin _ _ = return Nothing

findUserByEmail :: Config -> Email -> IO (Maybe User)
findUserByEmail _ _ = return Nothing

isUserAuthor :: Config -> UserId -> IO (Maybe Bool)
isUserAuthor _ _ = return $ Just True
