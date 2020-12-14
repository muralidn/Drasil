module Main (main) where

import Data.Drasil.ExternalLibraries.ODELibraries
       (apacheODEPckg, odeintPckg, osloPckg, scipyODEPckg)

import Drasil.PIDController.Body (pidODEInfo, printSetting, si, srs)

import Language.Drasil.Code
       (AuxFile(..), Choices(..), CodeSpec, Comments(..), ConstantRepr(..),
        ConstantStructure(..), ConstraintBehaviour(..), ImplementationType(..),
        InputModule(..), Lang(..), Modularity(..), Structure(..), Verbosity(..),
        Visibility(..), codeSpec, defaultChoices, Logging (..))

import Language.Drasil.Generate (gen, genCode)
import Language.Drasil.Printers (DocSpec(DocSpec), DocType(SRS, Website))

codeSpecs :: CodeSpec
codeSpecs = codeSpec si codeChoices []

codeChoices :: Choices
codeChoices
  = defaultChoices{lang = [Python, Cpp, CSharp], modularity = Modular Combined,
                   impType = Program, logFile = "log.txt", logging = [LogFunc, LogVar],
                   comments = [CommentFunc, CommentClass, CommentMod],
                   doxVerbosity = Verbose, dates = Hide,
                   onSfwrConstraint = Exception, onPhysConstraint = Exception,
                   inputStructure = Unbundled, constStructure = Store Bundled,
                   constRepr = Const,
                   auxFiles =
                     [SampleInput
                        "../../datafiles/PIDController/sampleInput.txt",
                      ReadME],
                   odeLib = [scipyODEPckg, osloPckg, apacheODEPckg, odeintPckg],
                   odes = [pidODEInfo]}

main :: IO ()
main
  = do gen (DocSpec SRS "PIDController_SRS") srs printSetting
       gen (DocSpec Website "PIDController_SRS") srs printSetting
       genCode codeChoices codeSpecs
