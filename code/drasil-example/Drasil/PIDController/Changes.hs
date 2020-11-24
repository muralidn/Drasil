module Drasil.PIDController.Changes where

import Data.Drasil.Concepts.Documentation (likeChgDom)

import Drasil.PIDController.Assumptions
import Drasil.PIDController.Concepts
import Language.Drasil
import Utils.Drasil

likelyChgs :: [ConceptInstance]
likelyChgs = [likeChgSO]

likeChgSO :: ConceptInstance
likeChgSO = cic "likeChgIC" likeChgSODesc "Second Order Power Plant" likeChgDom

likeChgSODesc :: Sentence
likeChgSODesc
  = foldlSent
      [S "The", phrase powerPlant,
       S "maybe changed into a second order system ( from ",
       makeRef2S aPwrPlant, S ")"]
