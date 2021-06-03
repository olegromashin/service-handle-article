module App.Types.User where

newtype UserId = UserId {getUserId :: Int}
type Login = String
type Password = String
type Email = String

data User = User UserId Login Password Email
