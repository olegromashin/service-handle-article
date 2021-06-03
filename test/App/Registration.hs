module App.Registration where

import qualified App.Handlers.Registration as Registration
import App.Types.APISuccess (APISuccess (..))
import App.Types.User (User (..), UserId (..))
import Data.Functor.Identity (Identity)
import Services.Logger (LogHandle (..))
import Test.Hspec

logHandle :: LogHandle Identity
logHandle = LogHandle {writeLog = \logMessage -> return ()}

handle :: Registration.Handle Identity
handle =
  Registration.Handle
    { Registration.createUser = \login password email -> return (),
      Registration.findUserByLogin = \login -> return Nothing,
      Registration.findUserByEmail = \email -> return Nothing,
      Registration.logHandle = logHandle
    }

registration :: IO ()
registration = hspec $ do
  describe "Testing user registration" $ do
    it "Should successfully register user" $ do
      let result = Registration.registerUser handle "Login" "Password" "email@email.com"
      result `shouldBe` return (Right APISuccess)
    it "Should fail if login is already taken" $ do
      let handleCase = handle {Registration.findUserByLogin = \login -> return . Just $ User (UserId 1) "Login" "hashedPassword" "someEmail@email.com"}
      let result = Registration.registerUser handleCase "Login" "Password" "email@email.com"
      result `shouldBe` return (Left "LOGIN_ALREADY_TAKEN")
    it "Should fail if e-mail is already taken" $ do
      let handleCase = handle {Registration.findUserByEmail = \email -> return . Just $ User (UserId 1) "SomeLogin" "hashedPassword" "email@email.com"}
      let result = Registration.registerUser handleCase "Login" "Password" "email@email.com"
      result `shouldBe` return (Left "EMAIL_ALREADY_TAKEN")
