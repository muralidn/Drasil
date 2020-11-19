module Drasil.PIDController.IntroSection where

import Data.Drasil.Citations (smithLai2005)

import Drasil.PIDController.Concepts
import Language.Drasil
import Utils.Drasil

introPara, introPurposeOfDoc, introscopeOfReq :: Sentence
introPara
  = foldlSent
      [S "Automatic process control with a controller (P/PI/PD/PID) is used "
         +:+ S "in a variety of applications such as thermostats, automobile "
         +:+
         S "cruise-control, etc. The gains of a controller in an application "
         +:+ S "must be tuned before the controller is ready for production.",
       S "Therefore a simulation of the " +:+ phrase pidC +:+ S " with a " +:+
         phrase firstOrderSystem
         +:+ S "is created in this project that can be "
         +:+ S "used to tune the gain constants"]

introscopeOfReq
  = foldlSent_
      [S "a", phrase pidCL, S " with three subsystems namely a ", phrase pidC,
       S ", a", phrase summingPt, S ", and a", phrase powerPlant]

introPurposeOfDoc
  = foldlSent
      [S "The purpose of this document is to capture all the necessary " +:+
         S "information including assumptions, data definitions, constraints, "
         +:+
         S "models, and requirements to facilitate an unambiguous development "
         +:+ S "of the PD controller software and test procedures"]

introUserChar1, introUserChar2 :: [Sentence]
introUserChar1
  = [S "control systems (control theory and controllers) at a fourth year undergraduate level"]
introUserChar2
  = [S "engineering mathematics at a second year undergraduate level"]

introDocOrg :: Sentence
introDocOrg
  = foldlSent
      [S "The sections in this document are based on " +:+
         makeCiteS smithLai2005]
