module Drasil.PIDController.Assumptions where

import Data.Drasil.Concepts.Documentation (assumpDom)

import Drasil.PIDController.Concepts
import Language.Drasil
import Utils.Drasil

assumptions :: [ConceptInstance]
assumptions
  = [aPwrPlant, aDecoupled, aSP, aExtDisturb, aInitialValue, aParallelEq]

aPwrPlant, aDecoupled, aSP, aExtDisturb, aInitialValue, aParallelEq ::
           ConceptInstance

aPwrPlant = cic "pwrPlant" pwrPlantDesc "Power plant" assumpDom
aDecoupled = cic "decoupled" aDecoupledDesc "Decoupled equation" assumpDom
aSP = cic "setPoint" aSPDesc "Set-Point" assumpDom
aExtDisturb
  = cic "externalDistub" aExtDisturbDesc "External disturbance" assumpDom
aInitialValue = cic "initialValue" aInitialValueDesc "Initial value" assumpDom
aParallelEq = cic "parallelEq" aParallelEqDesc "Parallel equation" assumpDom

pwrPlantDesc, aDecoupledDesc, aSPDesc, aExtDisturbDesc, aManualTuningDesc,
              aInitialValueDesc, aParallelEqDesc :: Sentence
pwrPlantDesc
  = foldlSent
      [S "The" +:+ phrase powerPlant +:+ S "and the sensor are coupled" +:+
         S " a single unit with transfer function, 1/(2s + 1)"]

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

