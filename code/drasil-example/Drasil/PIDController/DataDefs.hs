module Drasil.PIDController.DataDefs where

import Drasil.PIDController.Assumptions

import Drasil.PIDController.Concepts

import Drasil.PIDController.References

import Drasil.PIDController.TModel
import Language.Drasil

import Theory.Drasil (DataDefinition, dd, mkQuantDef)
import Utils.Drasil

dataDefinitions :: [DataDefinition]
dataDefinitions = [ddErrSig, ddPropCtrl, ddDerivCtrl, ddPowerPlant, ddCtrlVar]

----------------------------------------------

ddErrSig :: DataDefinition
ddErrSig
  = dd ddErrSigDefn [makeCite johnson2008] Nothing "ddProcessError"
      [ddErrSigNote]

ddErrSigDefn :: QDefinition
ddErrSigDefn = mkQuantDef qdProcessErrorFD ddErrSigEqn

ddErrSigEqn :: Expr
ddErrSigEqn = (sy qdSetPointFD) - (sy qdProcessVariableFD)

ddErrSigNote :: Sentence
ddErrSigNote
  = foldlSent
      [S "Process Error is the difference between the Set-Point and " +:+
         S "Process Variable.",
       S "The equation is converted to frequency" +:+
         S "domain by applying the Laplace transform ( from"
         +:+ makeRef2S tmLaplace
         +:+ S ").",
       S "The Set-Point is assumed to be constant throughout the" +:+
         S "simulation ( from "
         +:+ makeRef2S aSP
         +:+ S ").",
       S "The initial value of the Process Variable if assumed" +:+
         S "to be zero ( from "
         +:+ makeRef2S aInitialValue
         +:+ S ")"]

----------------------------------------------

ddPropCtrl :: DataDefinition
ddPropCtrl
  = dd ddPropCtrlDefn [makeCite johnson2008] Nothing "ddPropCtrl"
      [ddPropCtrlNote]

ddPropCtrlDefn :: QDefinition
ddPropCtrlDefn = mkQuantDef qdPropControlFD ddPropCtrlEqn

ddPropCtrlEqn :: Expr
ddPropCtrlEqn = ($.) (sy qdPropGain) (sy qdProcessErrorFD)

ddPropCtrlNote :: Sentence
ddPropCtrlNote
  = foldlSent
      [S "Proportional controller is the product of the Proportional Gain" +:+
         S "and the Process Error ( from "
         +:+ makeRef2S ddErrSig
         +:+ S ")",
       S "The equation is converted to frequency" +:+
         S "domain by applying the Laplace transform ( from"
         +:+ makeRef2S tmLaplace
         +:+ S ")"]

----------------------------------------------

ddDerivCtrl :: DataDefinition
ddDerivCtrl
  = dd ddDerivCtrlDefn [makeCite johnson2008] Nothing "ddDerivCtrl"
      [ddDerivCtrlNote]

ddDerivCtrlDefn :: QDefinition
ddDerivCtrlDefn = mkQuantDef qdDerivativeControlFD ddDerivCtrlEqn

ddDerivCtrlEqn :: Expr
ddDerivCtrlEqn
  = ($.) (($.) (sy qdDerivGain) (sy qdProcessErrorFD)) (sy qdFreqDomain)

ddDerivCtrlNote :: Sentence
ddDerivCtrlNote
  = foldlSent
      [S "Derivative controller is the product of the Derivative Gain" +:+
         S "and the differential of the Process Error ( from "
         +:+ makeRef2S ddErrSig
         +:+ S ")",
       S "The equation is" +:+ S "converted to frequency" +:+
         S "domain by applying the Laplace"
         +:+ S "transform ( from"
         +:+ makeRef2S tmLaplace
         +:+ S ")"]

----------------------------------------------

ddPowerPlant :: DataDefinition
ddPowerPlant
  = dd ddPowerPlantDefn [makeCite pidWiki] Nothing "ddPowerPlant"
      [ddPowerPlantNote]

ddPowerPlantDefn :: QDefinition
ddPowerPlantDefn = mkQuantDef qdTransferFunctionFD ddPowerPlantEqn

ddPowerPlantEqn :: Expr
ddPowerPlantEqn = 1 / ((2 * (sy qdFreqDomain)) + 1)

ddPowerPlantNote :: Sentence
ddPowerPlantNote
  = foldlSent
      [S "The power plant is represented by a first order system ( from " +:+
         makeRef2S aPwrPlant
         +:+ S ")",
       S "The equation is" +:+ S "converted to frequency" +:+
         S "domain by applying the Laplace"
         +:+ S "transform ( from"
         +:+ makeRef2S tmLaplace
         +:+ S ")",
       S "Additionally there are no external disturbances to the power plant"
         +:+ S "( from "
         +:+ makeRef2S aExtDisturb
         +:+ S ")"]

----------------------------------------------

ddCtrlVar :: DataDefinition
ddCtrlVar
  = dd ddCtrlVarDefn [makeCite johnson2008] Nothing "ddCtrlVar" [ddCtrlNote]

ddCtrlVarDefn :: QDefinition
ddCtrlVarDefn = mkQuantDef qdCtrlVarFD ddCtrlEqn

ddCtrlEqn :: Expr
ddCtrlEqn
  = (($.) (sy qdPropGain) (sy qdProcessErrorFD)) +
      (($.) (($.) (sy qdDerivGain) (sy qdProcessErrorFD)) (sy qdFreqDomain))

ddCtrlNote :: Sentence
ddCtrlNote
  = foldlSent
      [S "The control variable is the output of the controller.",
       S "In this case," +:+ S "it is the sum of the Proportional ( from" +:+
         makeRef2S ddPropCtrl
         +:+ S ") and Derivative ( from "
         +:+ makeRef2S ddDerivCtrl
         +:+ S ") controllers",
       S "The parallel ( from" +:+ makeRef2S aParallelEq +:+
         S ") and de-coupled ( from"
         +:+ makeRef2S aDecoupled
         +:+ S ") form of the PD equation is"
         +:+ S "used in this document"]

