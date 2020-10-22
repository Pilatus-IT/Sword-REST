
module Main where

import Network.Wai.Handler.Warp (run)
import Sword.API (swordApp)

main :: IO ()
main = run 8000 swordApp