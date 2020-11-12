module Drasil.PIDController.IntroSection where

import Drasil.PIDController.Concepts
import Language.Drasil
import Utils.Drasil

introPara, puposeOfDoc, scopeOfReq :: Sentence
introPara
  = foldlSent
      [S "A" +:+ plural pidCL +:+
         S "is used in a wide range of applications such as thermostats, automobile cruise-control, etc.",
       S "The gains of a " +:+ phrase pidC +:+
         S " in an application must be tuned before the controller is ready for production.",
       S "Therefore, a software model is necessary for the simulation of " +:+
         phrase pidC]

puposeOfDoc
  = foldlSent
      [S "limited to a", phrase pidCL, S " with three subsystems namely a ",
       phrase pidC, S ", a", phrase summingPt, S ", and a", phrase powerPlant,
       S ". All the analysis in this application are in the time domain"]


scopeOfReq
  = foldlSent
      [S "limited to a", phrase pidCL, S " with three subsystems namely a ",
       phrase pidC, S ", a", phrase summingPt, S ", and a", phrase powerPlant,
       S ". All the analysis in this application are in the time domain"]