{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}
module Lib
    ( startApp
    , app
    ) where

import           Data.Aeson
import           Data.Aeson.TH
import           Data.Time.Calendar       (Day, fromGregorian)
import           GHC.Generics
import           Network.Wai
import           Network.Wai.Handler.Warp
import           Servant                  ((:>))
import qualified Servant

data User = User {
  name              :: String,
  age               :: Int,
  email             :: String,
  registration_date :: Day
} deriving (Eq, Show, Generic)

$(deriveJSON defaultOptions ''User)

type API = "users" :> Servant.Get '[Servant.JSON] [User]

startApp :: IO ()
startApp = run 8080 app

app :: Application
app = Servant.serve api server

api :: Servant.Proxy API
api = Servant.Proxy

server :: Servant.Server API
server = return users

users :: [User]
users =
  [ User "Isaac Newton"    372 "isaac@newton.co.uk" (fromGregorian 1683  3 1)
  , User "Albert Einstein" 136 "ae@mc2.org"         (fromGregorian 1905 12 1)
  ]
