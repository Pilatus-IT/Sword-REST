{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import Data.Aeson
import Data.Text (Text)
import GHC.Generics (Generic)
import Servant

type SwordAPI = "compile" :> ReqBody '[JSON] CompileRequest :> Post '[JSON] CompileResponse
           :<|> "ping" :> Get '[JSON] PingResponse

data CompileRequest = CompileRequest
  { contract   :: Text
  , blockchain :: Text
  } deriving (Generic)

instance FromJSON CompileRequest

data CompileResponse = CompileResponse
  { bytecode :: Text
  , parties  :: Int
  } deriving (Generic)

instance ToJSON CompileResponse

data PingResponse = PingResponse
  { running :: Bool
  } deriving (Generic)

instance ToJSON PingResponse

main :: IO ()
main = putStrLn "Sword+REST"
