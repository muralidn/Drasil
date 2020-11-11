module Main (main) where

import Drasil.PIDController.Body (printSetting, srs)

import Language.Drasil.Generate (gen)
import Language.Drasil.Printers (DocSpec(DocSpec), DocType(SRS, Website))

main :: IO ()
main
  = do gen (DocSpec SRS "PIDController_SRS") srs printSetting
       gen (DocSpec Website "PIDController_SRS") srs printSetting
