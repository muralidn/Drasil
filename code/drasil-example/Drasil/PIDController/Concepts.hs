module Drasil.PIDController.Concepts where

import Language.Drasil

pidControllerSystem, controlEngineering :: CI
pidControllerSystem
  = commonIdeaWithDict "pdControllerApp" (pn "PD Controller") "PD Controller" []

controlEngineering
  = commonIdeaWithDict "ctrlEng" (cn' "control engineering") "N/A" []

pidC, pidCL, summingPt, powerPlant :: ConceptChunk
pidCL
  = dcc "pdCtrlLoop" (nounPhraseSP "PD Control Loop")
      ("Closed loop control system with PD Controller, Summing Point and Power Plant")

pidC
  = dcc "pdController" (nounPhraseSP "PD Controller")
      ("Proportional-Derivative Controller")

summingPt
  = dcc "summingPoint" (nounPhraseSP "Summing Point")
      ("Control block where the difference between the Set-Point and the Process Variable is computed")

powerPlant
  = dcc "powerPlant" (nounPhraseSP "Power Plant")
      ("A first order system to be controlled")

firstOrderSystem
  = dcc "firstOrderSystem" (nounPhraseSP "First Order System")
      ("A system whose input-output relationship is denoted by a first order differential equation")

errorValue
  = dcc "errorValue" (nounPhraseSP "Error Value")
      ("Input to the PID controller. Error Value is the difference between the Set Point and the Process Variable")

simulationTime
  = dcc "simulatiomTime" (nounPhraseSP "Simulation time")
      ("Total execution time of the PD simulation")

processVariable
  = dcc "processVariable" (nounPhraseSP "Process Variable")
      ("The output value from the power plant")

setPoint
  = dcc "setPoint" (nounPhraseSP "Set-Point")
      ("The desired value that the control system must reach. This also knows as reference variable")

propGain
  = dcc "propGain" (nounPhraseSP "Proportional Gain")
      ("Gain constant of the proportional controller")

derGain
  = dcc "derGain" (nounPhraseSP "Derivative Gain")
      ("Gain constant of the derivative controller")

simulation
  = dcc "simulation" (nounPhraseSP "simulation")
      ("Simulation of the PD controller")


ccFrequencyDomain
  = dcc "frequencyDomain" (nounPhraseSP "Frequency Domain")
      ("The analysis of mathematical functions with respect to frequency, instead "
         ++ "of time")

ccLaplaceTransform
  = dcc "laplaceTransform" (nounPhraseSP "Laplace transform")
      ("an integral transform that converts a function of a real variable t " ++
         "(often time) to a function of a complex variable s (complex frequency)")


concepts :: [IdeaDict]
concepts = map nw defs

defs :: [ConceptChunk]
defs
  = [pidCL, pidC, summingPt, powerPlant, firstOrderSystem, errorValue,
     simulationTime, processVariable, setPoint, propGain, derGain, ccFrequencyDomain,
     ccLaplaceTransform]

s, f_S :: Symbol
f_S = Variable "F(s)"
s = Variable "s"


symbols :: [QuantityDict]
symbols = [qdLaplaceTransform, qdFreqDomain]

qdLaplaceTransform, qdFreqDomain :: QuantityDict
qdLaplaceTransform = vc "qLaplaceTransform" (nounPhraseSent (S "Transform")) f_S Real
qdFreqDomain = vc "qFreqDomain" (nounPhraseSent (S "qFD")) s Real


