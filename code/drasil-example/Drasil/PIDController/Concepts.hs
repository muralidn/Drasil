module Drasil.PIDController.Concepts where

import Language.Drasil

pidControllerSystem, controlEngineering :: CI
pidControllerSystem
  = commonIdeaWithDict "pdControllerApp" (pn "PD Controller") "PD Controller" []

controlEngineering
  = commonIdeaWithDict "ctrlEng" (cn' "control engineering") "N/A" []

pidC, pidCL, summingPt, powerPlant, firstOrderSystem, errorValue,
      simulationTime, processVariable, setPoint, propGain, derGain, simulation,
      ccFrequencyDomain, ccLaplaceTransform :: ConceptChunk
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
     simulationTime, processVariable, setPoint, propGain, derGain,
     ccFrequencyDomain, ccLaplaceTransform]

sym_s, sym_f_S, sym_f_t, sym_negInf, sym_posInf, sym_invLaplace, sym_Kd, sym_Kp,
       sym_YT, sym_YS, sym_YrT, sym_YrS, sym_ET, sym_ES, sym_PS, sym_DS, sym_HS :: Symbol

sym_f_S = Variable "F(s)"
sym_s = Variable "s"
sym_f_t = Variable "f(t)"
sym_negInf = Variable "-∞"
sym_posInf = Variable "∞"
sym_invLaplace = Variable "L⁻¹{F(s)}"
sym_Kd = Variable "Kd"
sym_Kp = Variable "Kp"
sym_YrT = Variable "yʳ(t)"
sym_YrS = Variable "Yʳ(s)"
sym_YT = Variable "y(t)"
sym_YS = Variable "Y(s)"
sym_ET = Variable "e(t)"
sym_ES = Variable "E(s)"
sym_PS = Variable "P(s)"
sym_DS = Variable "D(s)"
sym_HS = Variable "H(s)"

symbols :: [QuantityDict]
symbols
  = [qdLaplaceTransform, qdFreqDomain, qdFxnTDomain, qdNegInf, qdPosInf,
     qdInvLaplaceTransform, qdPropGain, qdDerivGain, qdSetPointTD, qdSetPointFD,
     qdProcessVariableTD, qdProcessVariableFD, qdErrorSignalTD, qdErrorSignalFD,
     qdDerivativeControlFD, qdPropControlFD, qdTransferFunctionFD]

qdLaplaceTransform, qdFreqDomain, qdFxnTDomain, qdNegInf, qdPosInf,
                    qdInvLaplaceTransform, qdPropGain, qdDerivGain,
                    qdSetPointTD, qdSetPointFD, qdProcessVariableTD,
                    qdProcessVariableFD, qdErrorSignalTD, qdErrorSignalFD,
                    qdPropControlFD, qdDerivativeControlFD, qdTransferFunctionFD :: QuantityDict
qdLaplaceTransform
  = vc "qLaplaceTransform"
      (nounPhraseSent (S "Laplace Transform of a function f(t)"))
      sym_f_S
      Real
qdFreqDomain
  = vc "qFreqDomain" (nounPhraseSent (S "Complex frequency domain parameter"))
      sym_s
      Real
qdFxnTDomain
  = vc "qdFxnTDomain" (nounPhraseSent (S "Function in the time domain")) sym_f_t
      Real

qdNegInf
  = vc "qdNegInf" (nounPhraseSent (S "Negative Infinity")) sym_negInf Real

qdPosInf = vc "qdPosInf" (nounPhraseSent (S "Infinity")) sym_posInf Real

qdInvLaplaceTransform
  = vc "qInvLaplaceTransform"
      (nounPhraseSent (S "Inverse Laplace Transform of F(s)"))
      sym_invLaplace
      Real

qdPropGain
  = vc "qdPropGain" (nounPhraseSent (S "Proportional Gain")) sym_Kp Real

qdDerivGain
  = vc "qdDerivGain" (nounPhraseSent (S "Derivative Gain")) sym_Kd Real

qdSetPointTD
  = vc "qdSetPointTD" (nounPhraseSent (S "Set Point in the time domain"))
      sym_YrT
      Real

qdSetPointFD
  = vc "qdSetPointFD" (nounPhraseSent (S "Set Point in the frequency domain"))
      sym_YrS
      Real

qdProcessVariableTD
  = vc "qdProcessVariableTD"
      (nounPhraseSent (S "Process Variable in the time domain"))
      sym_YT
      Real

qdProcessVariableFD
  = vc "qdProcessVariableFD"
      (nounPhraseSent (S "Process Variable in the frequency domain"))
      sym_YS
      Real

qdErrorSignalTD
  = vc "qdErrorSignalTD" (nounPhraseSent (S "Error Signal in the time domain"))
      sym_ET
      Real

qdErrorSignalFD
  = vc "qdErrorSignalFD"
      (nounPhraseSent (S "Error Signal in the frequency domain"))
      sym_ES
      Real

qdPropControlFD
  = vc "qdPropControlFD"
      (nounPhraseSent (S "Proportional Control in frequency domain"))
      sym_PS
      Real

qdDerivativeControlFD
  = vc "qdDerivativeControlFD"
      (nounPhraseSent (S "Proportional Control in frequency domain"))
      sym_DS
      Real

qdTransferFunctionFD
  = vc "qdTransferFunctionFD"
      (nounPhraseSent (S "Transfer function of the Power-Plant in frequency domain"))
      sym_HS
      Real
