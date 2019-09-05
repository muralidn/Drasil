module Main (main) where

-- import Language.Drasil.Code (Choices(..), CodeSpec, codeSpec, Comments(..), 
--   ConstraintBehaviour(..), ImplementationType(..), Lang(..), Logging(..), 
--   Structure(..), ConstantStructure(..), ConstantRepr(..), InputModule(..), 
--   AuxFile(..), Visibility(..))
import Language.Drasil.Generate (gen)
import Language.Drasil.Printers (DocType(SRS, Website), DocSpec(DocSpec))

import Drasil.HGHC.Body (srs, printSetting) --thisSI

-- thisCode :: CodeSpec
-- thisCode = codeSpec thisSI choices []

{- When we want to actually generate code from this again, uncomment
thisChoices :: Choices
thisChoices = Choices {
  lang             = [Python, Cpp, CSharp, Java],
  impType          = Program,
  logFile          = "log.txt",
  logging          = LogNone,
  comments         = [], 
  dates            = Hide,
  onSfwrConstraint = Warning,
  onPhysConstraint = Warning,
  inputStructure   = Bundled,
  constStructure   = Inline,
  constRepr        = Const,
  inputModule      = Combined,
  auxFiles         = [SampleInput] 
} -}
  
main :: IO ()            
main = do
  gen (DocSpec Website "HGHC_SRS") srs printSetting
  gen (DocSpec SRS "HGHC_SRS")     srs printSetting
  -- When ready to generate code, uncomment this file
  --genCode thisChoices thisCode
