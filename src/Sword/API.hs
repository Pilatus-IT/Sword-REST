{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverloadedStrings #-}

module Sword.API where

import Servant
import Sword.Types
import Sword.Compiler (produce)

type SwordAPI =
       "compile" :> ReqBody '[JSON] CompileRequest :> Post '[JSON] CompileResponse
  :<|> "ping" :> Get '[JSON] PingResponse

swordAPI :: Proxy SwordAPI
swordAPI = Proxy

swordApp :: Application
swordApp = serve swordAPI swordServer

swordServer :: Server SwordAPI
swordServer = compile :<|> ping

compile :: CompileRequest -> Handler CompileResponse
compile CompileRequest{..}
  | blockchain == "EVM" = pure (produce contract)
  | otherwise = pure (CompileResponse (Left UnknownBlockchain))

ping :: Handler PingResponse
ping = pure (PingResponse True)