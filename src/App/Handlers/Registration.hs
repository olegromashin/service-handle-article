module App.Handlers.Registration where

import Services.Logger (LogHandle (..))
import App.Types.APISuccess (APISuccess (..))
import App.Types.User (Email, Login, Password, User)

data Handle m = Handle
  { createUser :: Login -> Password -> Email -> m (),
    findUserByLogin :: Login -> m (Maybe User),
    findUserByEmail :: Email -> m (Maybe User),
    logHandle :: LogHandle m
  }

-- Функция registerUser становится полиморфной.
registerUser :: Monad m => Handle m -> Login -> Password -> Email -> m (Either String APISuccess)
registerUser handle login password email = do
  writeLog (logHandle handle) $ "Registering user with login " ++ login ++ " and e-mail: " ++ email
  loginTaken <- isLoginAlreadyTaken
  if loginTaken
    then return $ Left "LOGIN_ALREADY_TAKEN"
    else do
      emailTaken <- isEmailAlreadyTaken
      if emailTaken
        then return $ Left "EMAIL_ALREADY_TAKEN"
        else do
          createUser handle login password email
          return $ Right APISuccess
  where
    isLoginAlreadyTaken = do
      user <- findUserByLogin handle login
      case user of
        Nothing -> return False
        Just _ -> return True
    isEmailAlreadyTaken = do
      user <- findUserByEmail handle email
      case user of
        Nothing -> return False
        Just _ -> return True
