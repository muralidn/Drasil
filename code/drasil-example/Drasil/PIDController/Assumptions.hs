module Drasil.PIDController.Assumptions where

import Data.Drasil.Concepts.Documentation (assumpDom)

import Drasil.PIDController.Concepts
import Language.Drasil
import Utils.Drasil

assumptions :: [ConceptInstance]
assumptions
  = [aPwrPlant, aDecoupled, aSP, aExtDisturb, aInitialValue, aParallelEq,
     aUnfilteredDerivative, apwrPlantTxFnx, aDCGain]

aPwrPlant, aDecoupled, aSP, aExtDisturb, aInitialValue, aParallelEq,
           aUnfilteredDerivative, apwrPlantTxFnx, aDCGain :: ConceptInstance

aPwrPlant = cic "pwrPlant" pwrPlantDesc "Power plant" assumpDom
aDecoupled = cic "decoupled" aDecoupledDesc "Decoupled equation" assumpDom
aSP = cic "setPoint" aSPDesc "Set-Point" assumpDom
aExtDisturb
  = cic "externalDistub" aExtDisturbDesc "External disturbance" assumpDom
aInitialValue = cic "initialValue" aInitialValueDesc "Initial Value" assumpDom
aParallelEq = cic "parallelEq" aParallelEqDesc "Parallel Equation" assumpDom
apwrPlantTxFnx
  = cic "pwrPlantTxFnx" apwrPlantTxFnxDesc "Transfer Function" assumpDom
aDCGain = cic "dcGainTimeConst" aDCGainDesc "Power Plant Parameters" assumpDom
aUnfilteredDerivative
  = cic "unfilteredDerivative" aUnfilteredDerivativeDesc "Unfiltered Derivative"
      assumpDom

pwrPlantDesc, aDecoupledDesc, aSPDesc, aExtDisturbDesc, aManualTuningDesc,
              aInitialValueDesc, aParallelEqDesc, apwrPlantTxFnxDesc,
              aDCGainDesc, aUnfilteredDerivativeDesc :: Sentence
pwrPlantDesc
  = foldlSent
      [S "The" +:+ phrase powerPlant +:+ S "and the Sensor are coupled" +:+
         S "as a single unit"]

apwrPlantTxFnxDesc
  = foldlSent
      [S "The combined" +:+ phrase powerPlant +:+ S "and Sensor ( from " +:+
         makeRef2S aPwrPlant
         +:+ S " ) are characterized by a First Order"
         +:+ S " System"]

aDecoupledDesc
  = foldlSent
      [S "The decoupled form of the" +:+ phrase pidC +:+
         S "equation used in this"
         +:+ phrase simulation]

aSPDesc
  = foldlSent
      [S "The" +:+ phrase setPoint +:+ S "is a constant throughout the" +:+
         phrase simulation]

aExtDisturbDesc
  = foldlSent
      [S "There are no external disturbances to the" +:+ phrase powerPlant +:+
         S "during the"
         +:+ phrase simulation]

aManualTuningDesc
  = foldlSent
      [S "This model will be used for  manual tuning of the" +:+ phrase pidC]

aInitialValueDesc
  = foldlSent
      [S "The initial value of the" +:+ phrase processVariable +:+
         S "is assumed to be zero"]

aParallelEqDesc
  = foldlSent
      [S "The Parallel form of the equation is used for the" +:+ phrase pidC]

aUnfilteredDerivativeDesc
  = foldlSent
      [S "A pure derivative function is used for this simulation;",
       S "there are no filters applied"]

aDCGainDesc
  = foldlSent
      [S "The DC Gain and Time Constant of the First Order System ( from",
       makeRef2S aPwrPlant, S "and", makeRef2S apwrPlantTxFnx, S ")",
       S "are assumed to be 1, and 2 seconds respectively"]
