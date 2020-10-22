{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Sword.Types where

import Data.Aeson (FromJSON, ToJSON, toJSON, Value(..), (.=), object)
import Data.Text (Text)
import GHC.Generics (Generic)

data CompileRequest = CompileRequest
  { contract   :: Text
  , blockchain :: Text
  } deriving (Eq, Show, Generic)

newtype CompileResponse
  = CompileResponse (Either CompileError CompileSuccess)
  deriving (Eq, Show, Generic)

data CompileError
  = CompileError Text
  | UnknownBlockchain
  deriving (Eq, Show, Generic)

data CompileSuccess = CompileSuccess
  { bytecode :: Text
  , parties  :: Int
  } deriving (Eq, Show, Generic)

data PingResponse = PingResponse
  { running :: Bool
  } deriving (Eq, Show, Generic)

instance FromJSON CompileRequest
instance ToJSON CompileRequest

instance ToJSON CompileResponse where
  toJSON (CompileResponse (Left err)) = object [ "error" .= err ]
  toJSON (CompileResponse (Right yay)) = toJSON yay

instance ToJSON CompileSuccess

instance ToJSON CompileError where
  toJSON (CompileError err) = String err
  toJSON UnknownBlockchain = String "Unknown Blockchain"

instance ToJSON PingResponse
