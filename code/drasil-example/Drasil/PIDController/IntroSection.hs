module Drasil.PIDController.IntroSection where

import Drasil.PIDController.Concepts
import Language.Drasil
import Utils.Drasil

introPara, purposeOfDoc, scopeOfReq :: Sentence
introPara
  = foldlSent
      [S "A" +:+ plural pidCL +:+
         S "is used in a wide range of applications such as thermostats, "
         +:+ S "automobile cruise-control, etc.",
       S "The gains of a " +:+ phrase pidC +:+
         S " in an application must be tuned before the controller is ready for production.",
       S "Therefore, a software model is necessary for the simulation of " +:+
         phrase pidC]

scopeOfReq
  = foldlSent_
      [S "a", phrase pidCL, S " with three subsystems namely a ", phrase pidC,
       S ", a", phrase summingPt, S ", and a", phrase powerPlant,
       S ". All the analysis in this application are in the time domain"]

purposeOfDoc
  = foldlSent
      [S "The purpose of this document is to capture all the necessary " +:+
         S "information including assumptions, data definitions, constraints, "
         +:+
         S "models, and requirements to facilitate an unambiguous development "
         +:+ S "of the PID controller software and test procedures"]

