
module Sword.Compiler
  ( produce
  ) where

import           Data.Bifunctor (first, bimap)
import           Data.Text (Text)
import qualified Data.Text as Text

import qualified EvmCompiler as EVMC
import qualified IntermediateCompiler as IMC
import qualified DaggerParser as BP
import qualified TypeChecker as TC

import Sword.Types (CompileError(..), CompileSuccess(..), CompileResponse(..))

produce :: Text -> CompileResponse
produce source = wrap $ do
  ast <- first show (BP.parseWrap (Text.unpack source))
  ast' <- TC.typeChecker ast
  pure (EVMC.assemble (IMC.intermediateCompile ast'))

wrap :: Either String String -> CompileResponse
wrap = CompileResponse . bimap
  (CompileError . Text.pack)
  (\b -> CompileSuccess (Text.pack b) 0)