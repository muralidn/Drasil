module Drasil.PIDController.GenDefs where

import Drasil.PIDController.Assumptions

import Drasil.PIDController.Concepts

import Drasil.PIDController.References

import Drasil.PIDController.TModel
import Language.Drasil

import Theory.Drasil (GenDefn, gd)
import Utils.Drasil

genDefns :: [GenDefn]
genDefns = [gdPowerPlant]

----------------------------------------------

gdPowerPlant :: GenDefn
gdPowerPlant
  = gd gdPowerPlantRC (Nothing :: Maybe UnitDefn) Nothing
      [makeCite pidWiki, makeCite electrical4U]
      "gdPowerPlant"
      [gdPowerPlantNote]

gdPowerPlantRC :: RelationConcept
gdPowerPlantRC
  = makeRC "gdPowerPlantRC"
      (nounPhraseSP "Transfer function of the Power Plant.")
      EmptyS
      gdPowerPlantEqn

gdPowerPlantEqn :: Expr
gdPowerPlantEqn = 1 / ((2 * (sy qdFreqDomain)) + 1)

gdPowerPlantNote :: Sentence
gdPowerPlantNote
  = foldlSent
      [S "The " +:+ phrase ccTransferFxn +:+ S "of the" +:+
         phrase firstOrderSystem
         +:+ S "is reduced to this equation by substituting the"
         +:+ phrase ccDcGain
         +:+ S "("
         +:+ P sym_KDC
         +:+ S ")"
         +:+ S "to 1, and the"
         +:+ phrase ccTimeConst
         +:+ S "("
         +:+ P sym_TConst
         +:+ S ")"
         +:+ S "to 2 seconds ( from "
         +:+ makeRef2S tmFOSystem
         +:+ S "and"
         +:+ makeRef2S aDCGain
         +:+ S ").",
       S "The equation is" +:+ S "converted to frequency" +:+
         S "domain by applying the Laplace"
         +:+ S "transform ( from"
         +:+ makeRef2S tmLaplace
         +:+ S ").",
       S "Additionally, there are no external disturbances to the power plant"
         +:+ S "( from "
         +:+ makeRef2S aExtDisturb
         +:+ S ")"]
