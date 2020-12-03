module Drasil.PIDController.Concepts where

import Data.Drasil.Concepts.Documentation
       (assumption, goalStmt, physSyst, requirement, srs, typUnc)
import Data.Drasil.Constraints (gtZeroConstr)
import Data.Drasil.IdeaDicts

import Data.Drasil.SI_Units (second)
import Language.Drasil

acronyms :: [CI]
acronyms
  = [assumption, dataDefn, genDefn, goalStmt, inModel, physSyst, requirement,
     srs, thModel, typUnc]

pidControllerSystem, controlEngineering :: CI
pidControllerSystem
  = commonIdeaWithDict "pdControllerApp" (pn "PD Controller") "PD Controller" []

controlEngineering
  = commonIdeaWithDict "ctrlEng" (cn' "control engineering") "N/A" []

pidC, pidCL, summingPt, powerPlant, firstOrderSystem, errorValue,
      simulationTime, processVariable, setPoint, propGain, derGain, simulation,
      ccFrequencyDomain, ccLaplaceTransform, controlVariable, stepTime ::
      ConceptChunk
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

stepTime = dcc "stepTime" (nounPhraseSP "Step time") ("Simulation step time")

simulationTime
  = dcc "simulationTime" (nounPhraseSP "Simulation time")
      ("Total execution time of the PD simulation")

processVariable
  = dcc "processVariable" (nounPhraseSP "Process Variable")
      ("The output value from the power plant")

controlVariable
  = dcc "controlVariable" (nounPhraseSP "Control Variable")
      ("The Control Variable is the output of the PD controller")

setPoint
  = dcc "setPoint" (nounPhraseSP "Set-Point")
      ("The desired value that the control system must reach. This also knows as reference variable")

propGain
  = dcc "propGain" (nounPhraseSP "Proportional-Gain")
      ("Gain constant of the proportional controller")

derGain
  = dcc "derGain" (nounPhraseSP "Derivative-Gain")
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
     ccFrequencyDomain, ccLaplaceTransform, controlVariable, stepTime]

sym_s, sym_f_S, sym_f_t, sym_negInf, sym_posInf, sym_invLaplace, sym_Kd, sym_Kp,
       sym_YT, sym_YS, sym_YrT, sym_YrS, sym_ET, sym_ES, sym_PS, sym_DS, sym_HS,
       sym_CT, sym_CS, sym_TStep, sym_TSim :: Symbol

sym_negInf = Variable "-∞"
sym_posInf = Variable "∞"
sym_invLaplace = Variable "L⁻¹{F(s)}"
sym_f_S = sub (Variable "F") $ Label "s"
sym_s = Variable "s"
sym_f_t = sub (Variable "f") $ Label "t"
sym_Kd = sub (Variable "K") $ Label "d"
sym_Kp = sub (Variable "K") $ Label "p"
sym_YrT = sub (Variable "r") $ Label "t"
sym_YrS = sub (Variable "R") $ Label "s"
sym_YT = sub (Variable "y") $ Label "t"
sym_YS = sub (Variable "Y") $ Label "s"
sym_ET = sub (Variable "e") $ Label "t"
sym_ES = sub (Variable "E") $ Label "s"
sym_PS = sub (Variable "P") $ Label "s"
sym_DS = sub (Variable "D") $ Label "s"
sym_HS = sub (Variable "H") $ Label "s"
sym_CT = sub (Variable "c") $ Label "t"
sym_CS = sub (Variable "C") $ Label "s"
sym_TStep = sub (Variable "t") $ Label "step"
sym_TSim = sub (Variable "t") $ Label "sim"

symbols :: [QuantityDict]
symbols
  = [qdLaplaceTransform, qdFreqDomain, qdFxnTDomain, qdNegInf, qdPosInf,
     qdInvLaplaceTransform, qdPropGain, qdDerivGain, qdSetPointTD, qdSetPointFD,
     qdProcessVariableTD, qdProcessVariableFD, qdErrorSignalTD, qdErrorSignalFD,
     qdDerivativeControlFD, qdPropControlFD, qdTransferFunctionFD, qdCtrlVarTD,
     qdCtrlVarFD, qdStepTime, qdSimTime]

qdLaplaceTransform, qdFreqDomain, qdFxnTDomain, qdNegInf, qdPosInf,
                    qdInvLaplaceTransform, qdPropGain, qdDerivGain,
                    qdSetPointTD, qdSetPointFD, qdProcessVariableTD,
                    qdProcessVariableFD, qdErrorSignalTD, qdErrorSignalFD,
                    qdPropControlFD, qdDerivativeControlFD,
                    qdTransferFunctionFD, qdCtrlVarFD, qdCtrlVarTD, qdStepTime,
                    qdSimTime :: QuantityDict

inputs :: [QuantityDict]
inputs = [qdSetPointTD, qdDerivGain, qdPropGain, qdStepTime, qdSimTime]

outputs :: [QuantityDict]
outputs = [qdProcessVariableTD]

inputsUC :: [UncertQ]
inputsUC
  = [ipSetPtUnc, ipPropGainUnc, ipDerGainUnc, ipStepTimeUnc, ipSimTimeUnc]

inpConstrained :: [ConstrConcept]
inpConstrained
  = [ipPropGain, ipDerivGain, ipSetPt, ipStepTime, ipSimTime, opProcessVariable]

ipPropGain, ipDerivGain, ipSetPt, ipStepTime, ipSimTime, opProcessVariable ::
            ConstrConcept

ipSetPtUnc, ipPropGainUnc, ipDerGainUnc, ipStepTimeUnc, ipSimTimeUnc :: UncertQ

ipPropGain
  = constrained' (dqdNoUnit propGain sym_Kp Real) [gtZeroConstr] (dbl 100)
ipPropGainUnc = uq ipPropGain defaultUncrt
qdPropGain = qw ipPropGain

ipDerivGain
  = constrained' (dqdNoUnit derGain sym_Kd Real) [gtZeroConstr] (dbl 1)
ipDerGainUnc = uq ipDerivGain defaultUncrt
qdDerivGain = qw ipDerivGain

ipSetPt = constrained' (dqdNoUnit setPoint sym_YrT Real) [gtZeroConstr] (dbl 1)
ipSetPtUnc = uq ipSetPt defaultUncrt
qdSetPointTD = qw ipSetPt

ipStepTime
  = constrained' (dqd stepTime sym_TStep Real second)
      [physc $ Bounded (Inc, 0.01  ) (Inc, 1)]
      (dbl 0.01  )
ipStepTimeUnc = uq ipStepTime defaultUncrt
qdStepTime = qw ipStepTime

ipSimTime
  = constrained' (dqd simulationTime sym_TSim Real second)
      [physc $ Bounded (Inc, 1) (Inc, 60)]
      (dbl 10)
ipSimTimeUnc = uq ipSimTime defaultUncrt
qdSimTime = qw ipSimTime

opProcessVariable
  = constrained' (dqdNoUnit processVariable sym_YT (Vect Rational))
      [gtZeroConstr]
      (dbl 1)
qdProcessVariableTD = qw opProcessVariable

qdSetPointFD
  = vc "qdSetPointFD" (nounPhraseSent (S "Set Point in the frequency domain"))
      sym_YrS
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
      (nounPhraseSent (S "Derivative Control in frequency domain"))
      sym_DS
      Real

qdTransferFunctionFD
  = vc "qdTransferFunctionFD"
      (nounPhraseSent
         (S "Transfer function of the Power-Plant in frequency domain"))
      sym_HS
      Real

qdCtrlVarTD
  = vc "qdCtrlVarTD" (nounPhraseSent (S "Control-Variable in time domain"))
      sym_CT
      Real

qdCtrlVarFD
  = vc "qdCtrlVarFD" (nounPhraseSent (S "Control-Variable in frequency domain"))
      sym_CS
      Real

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
