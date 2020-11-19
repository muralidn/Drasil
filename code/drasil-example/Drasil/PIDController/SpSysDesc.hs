module Drasil.PIDController.SpSysDesc where

import Data.Drasil.Concepts.Documentation (physicalSystem)

import Drasil.PIDController.Concepts
import Language.Drasil
import Utils.Drasil

sysProblemDesc :: Sentence
sysProblemDesc
  = foldlSent_
      [S "This program intends to provide a model of a" +:+ phrase pidC +:+
         S " that can be used for the tuning of the gain constants before"
         +:+ S " the deployment of the controller"]

sysParts :: [Sentence]
sysParts
  = map foldlSent
      [[S "The", phrase summingPt], [S "The", phrase pidC],
       [S "The", phrase powerPlant]]

sysFigure :: LabelledContent
sysFigure
  = llcc (makeFigRef "pidSysDiagram") $
      figWithWidth (atStartNP $ the physicalSystem)
        ("../../../datafiles/PIDController/Fig_PDController.png")
        60

sysGoalStatement :: [Sentence]
sysGoalStatement
  = [phrase setPoint, phrase simulationTime, phrase propGain,
     phrase derGain]
