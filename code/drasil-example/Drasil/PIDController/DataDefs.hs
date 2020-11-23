module Drasil.PIDController.DataDefs (dataDefinitions) where

import Drasil.PIDController.Assumptions

import Drasil.PIDController.Concepts

import Drasil.PIDController.References

import Drasil.PIDController.TModel
import Language.Drasil

import Theory.Drasil (DataDefinition, dd, mkQuantDef, ddNoRefs)
import Utils.Drasil

dataDefinitions :: [DataDefinition]
dataDefinitions = [ddErrSig, ddPropCtrl, ddDerivCtrl, ddPowerPlant]

----------------------------------------------

ddErrSig :: DataDefinition
ddErrSig
  = dd ddErrSigDefn [makeCite johnson2008] Nothing "ddErrorSignal"
      [ddErrSigNote]

ddErrSigDefn :: QDefinition
ddErrSigDefn = mkQuantDef qdErrorSignalFD ddErrSigEqn

ddErrSigEqn :: Expr
ddErrSigEqn = (sy qdSetPointFD) - (sy qdProcessVariableFD)

ddErrSigNote :: Sentence
ddErrSigNote
  = foldlSent
      [S "Error Signal is the difference between the Set-Point and " +:+
         S "Process Variable",
       S "The equation is converted to frequency" +:+
         S "domain by applying the Laplace transform ( from"
         +:+ makeRef2S tmLaplace
         +:+ S ")",
       S "The Set-Point is assumed to be constant throughout the" +:+
         S "simulation ( from "
         +:+ makeRef2S aSP
         +:+ S ")", S "The initial value of the Process Variable if assumed" +:+
         S "to be zero ( from " +:+ makeRef2S aInitialValue +:+ S ")"]

----------------------------------------------

ddPropCtrl :: DataDefinition
ddPropCtrl
  = dd ddPropCtrlDefn [makeCite johnson2008] Nothing "ddPropCtrl"
      [ddPropCtrlNote]

ddPropCtrlDefn :: QDefinition
ddPropCtrlDefn = mkQuantDef qdPropControlFD ddPropCtrlEqn

ddPropCtrlEqn :: Expr
ddPropCtrlEqn = ($.) (sy qdPropGain) (sy qdErrorSignalFD)

ddPropCtrlNote :: Sentence
ddPropCtrlNote
  = foldlSent
      [S "Proportional controller is the product of the Proportional Gain" +:+
         S "and the Error Signal ( from "
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
  = ($.) (($.) (sy qdDerivGain) (sy qdErrorSignalFD)) (sy qdFreqDomain)

ddDerivCtrlNote :: Sentence
ddDerivCtrlNote
  = foldlSent
      [S "Derivative controller is the product of the Derivative Gain" +:+
         S "and the differential of the Error Signal ( from "
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
  = ddNoRefs ddPowerPlantDefn Nothing "ddPowerPlant"
      [ddPowerPlantNote]

ddPowerPlantDefn :: QDefinition
ddPowerPlantDefn = mkQuantDef qdTransferFunctionFD ddPowerPlantEqn

ddPowerPlantEqn :: Expr
ddPowerPlantEqn
  = 1 / ((($.) 2 (sy qdFreqDomain)) + 1)

ddPowerPlantNote :: Sentence
ddPowerPlantNote
  = foldlSent
      [S "The power plant is represented by a first order system ( from "
         +:+ makeRef2S aPwrPlant +:+ S ")",
       S "The equation is" +:+ S "converted to frequency" +:+
         S "domain by applying the Laplace"
         +:+ S "transform ( from" +:+ makeRef2S tmLaplace +:+ S ")", 
         S "Additionally there are no external disturbances to the power plant" +:+
         S "( from " +:+ makeRef2S aExtDisturb +:+ S ")"]