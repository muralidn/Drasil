module Drasil.PIDController.Requirements where

import Data.Drasil.Concepts.Documentation (funcReqDom, nonFuncReqDom)

import Drasil.DocLang.SRS (datCon)

import Drasil.PIDController.Concepts
import Drasil.PIDController.IModel

import Language.Drasil
import Utils.Drasil

funcReqs :: [ConceptInstance]
funcReqs = [verifyInputs, calculateValues, outputValues]

verifyInputs, calculateValues, outputValues :: ConceptInstance
verifyInputs
  = cic "verifyInputs" verifyInputsDesc "Verify-Input-Values" funcReqDom
calculateValues
  = cic "calculateValues" calculateValuesDesc "Calculate-Values" funcReqDom
outputValues = cic "outputValues" outputValuesDesc "Output-Values" funcReqDom

verifyInputsDesc, calculateValuesDesc, outputValuesDesc :: Sentence

verifyInputsDesc
  = foldlSent
      [S "Ensure that the input values are within the" +:+
         S "limits specified in"
         +:+. makeRef2S (datCon ([] :: [Contents]) ([] :: [Section]))]

calculateValuesDesc
  = foldlSent
      [S "Calculate the" +:+ phrase processVariable +:+ S "( from" +:+
         makeRef2S imPD
         +:+ S " ) over "
         +:+ S "the simulation time"]

outputValuesDesc
  = foldlSent
      [S "Output the" +:+ phrase processVariable +:+ S "( from" +:+
         makeRef2S imPD
         +:+ S " ) over "
         +:+ S "the simulation time"]

-----------------------------------------------------------------------------

nonfuncReqs :: [ConceptInstance]
nonfuncReqs = [portability, security, maintainability, verifiability, quality]

portability :: ConceptInstance
portability
  = cic "portability"
      (foldlSent [S "The code shall be portable to multiple Operating Systems"])
      "Portable"
      nonFuncReqDom

security :: ConceptInstance
security
  = cic "security"
      (foldlSent
         [S "The code shall be immune to common security problems such as memory"
            +:+
            S "leaks, divide by zero errors, and the square root of negative numbers"])
      "Secure"
      nonFuncReqDom

maintainability :: ConceptInstance
maintainability
  = cic "maintainability"
      (foldlSent
         [S "The code shall be thoroughly documented with appropriate User Guides"])
      "Maintainable"
      nonFuncReqDom

verifiability :: ConceptInstance
verifiability
  = cic "verifiability"
      (foldlSent
         [S "The code shall be verifiable against a Verification and Validation plan"])
      "Verifiable"
      nonFuncReqDom

quality :: ConceptInstance
quality
  = cic "quality"
      (foldlSent
         [S "The code shall be written with high-quality standards. The code"
            +:+
            S "should adhere to good coding standards and should not contain"
            +:+ S "any dead, or unreachable statements."])
      "Quality"
      nonFuncReqDom

