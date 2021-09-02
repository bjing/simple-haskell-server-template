{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import Lib (app)
import Test.Hspec
import Test.Hspec.Wai
import Test.Hspec.Wai.JSON

main :: IO ()
main = hspec spec

spec :: Spec
spec = with (return app) $ do
    describe "GET /users" $ do
        it "responds with 200" $ do
            get "/users" `shouldRespondWith` 200
        it "responds with [User]" $ do
            let users = "[{\"name\":\"Isaac Newton\",\"age\":372,\"email\":\"isaac@newton.co.uk\",\"registration_date\":\"1683-03-01\"},{\"name\":\"Albert Einstein\",\"age\":136,\"email\":\"ae@mc2.org\",\"registration_date\":\"1905-12-01\"}]"
            get "/users" `shouldRespondWith` users
