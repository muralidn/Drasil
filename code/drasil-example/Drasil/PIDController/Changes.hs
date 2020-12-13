module Drasil.PIDController.Changes where

import Data.Drasil.Concepts.Documentation (likeChgDom)

import Drasil.PIDController.Assumptions
import Drasil.PIDController.Concepts
import Language.Drasil
import Utils.Drasil

likelyChgs :: [ConceptInstance]
likelyChgs = [likeChgSO, likeChgPP]

likeChgSO :: ConceptInstance
likeChgSO = cic "likeChgIC" likeChgSODesc "Second Order Power Plant" likeChgDom

likeChgPP :: ConceptInstance
likeChgPP = cic "likeChgPP" likeChgPPDesc "DC Gain and Time Constant" likeChgDom

likeChgSODesc :: Sentence
likeChgSODesc
  = foldlSent
      [S "The", phrase powerPlant,
       S "maybe changed into a second order system ( from ",
       makeRef2S apwrPlantTxFnx, S ")"]

likeChgPPDesc :: Sentence
likeChgPPDesc
  = foldlSent
      [S "The", phrase ccDcGain, S "and", phrase ccTimeConst,
       S "maybe changed to be supplied by the User ( from ", makeRef2S aDCGain,
       S ")"]
