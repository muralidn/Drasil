module Drasil.PIDController.Concepts where

import Data.Drasil.Concepts.Documentation
       (assumption, goalStmt, physSyst, requirement, srs, typUnc)
import Data.Drasil.Constraints (gtZeroConstr)
import Data.Drasil.IdeaDicts
import Data.Drasil.SI_Units (second)
import Language.Drasil

import Theory.Drasil (mkQuantDef)

acronyms :: [CI]
acronyms
  = [assumption, dataDefn, genDefn, goalStmt, inModel, physSyst, requirement,
     srs, thModel, typUnc, pdControllerCI, proportionalCI, derivativeCI,
     integralCI, pidCI]

pidControllerSystem, pdControllerCI, proportionalCI, derivativeCI, integralCI,
                     pidCI :: CI

pidControllerSystem
  = commonIdeaWithDict "pdControllerApp" (pn "PD Controller") "PD Controller" []

pdControllerCI
  = commonIdeaWithDict "pdControllerCI" (pn "Proportional Derivative") "PD" []

proportionalCI = commonIdeaWithDict "proportionalCI" (pn "Proportional") "P" []

derivativeCI = commonIdeaWithDict "derivativeCI" (pn "Derivative") "D" []

integralCI = commonIdeaWithDict "integralCI" (pn "Integral") "I" []

pidCI
  = commonIdeaWithDict "pidCI" (pn "Proportional Integral Derivative") "PID" []

pidC, pidCL, summingPt, powerPlant, firstOrderSystem, processError,
      simulationTime, processVariable, setPoint, propGain, derGain, simulation,
      ccFrequencyDomain, ccLaplaceTransform, controlVariable, stepTime,
      ccAbsTolerance, ccRelTolerance :: ConceptChunk
pidCL
  = dcc "pdCtrlLoop" (nounPhraseSP "PD Control Loop")
      ("Closed loop control system with PD Controller, Summing Point and Power Plant")

pidC
  = dcc "pdController" (nounPhraseSP "PD Controller")
      ("Proportional-Derivative Controller")

summingPt
  = dcc "summingPoint" (nounPhraseSP "Summing Point")
      ("Control block where the difference between the Set-Point and the " ++
         "Process Variable is computed")

powerPlant
  = dcc "powerPlant" (nounPhraseSP "Power Plant")
      ("A first order system to be controlled")

firstOrderSystem
  = dcc "firstOrderSystem" (nounPhraseSP "First Order System")
      ("A system whose input-output relationship is denoted by a first order "
         ++ "differential equation")

processError
  = dcc "processError" (nounPhraseSP "Process Error")
      ("Input to the PID controller. Process Error is the difference between the "
         ++ "Set Point and the Process Variable")

stepTime = dcc "stepTime" (nounPhraseSP "Step Time") ("Simulation step time")

simulationTime
  = dcc "simulationTime" (nounPhraseSP "Simulation Time")
      ("Total execution time of the PD simulation")

processVariable
  = dcc "processVariable" (nounPhraseSP "Process Variable")
      ("The output value from the power plant")

controlVariable
  = dcc "controlVariable" (nounPhraseSP "Control Variable")
      ("The Control Variable is the output of the PD controller")

setPoint
  = dcc "setPoint" (nounPhraseSP "Set Point")
      ("The desired value that the control system must reach. This also knows "
         ++ "as reference variable")

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

ccAbsTolerance
  = dcc "absoluteTolerance" (nounPhraseSP "Absolute Tolerance")
      ("Absolute tolerance for the integrator.")

ccRelTolerance
  = dcc "relativeTolerance" (nounPhraseSP "Relative Tolerance")
      ("Relative tolerance for the integrator.")

concepts :: [IdeaDict]
concepts = map nw defs

defs :: [ConceptChunk]
defs
  = [pidCL, pidC, summingPt, powerPlant, firstOrderSystem, processError,
     simulationTime, processVariable, setPoint, propGain, derGain,
     ccFrequencyDomain, ccLaplaceTransform, controlVariable, stepTime,
     ccAbsTolerance, ccRelTolerance]

sym_s, sym_f_S, sym_f_t, sym_negInf, sym_posInf, sym_invLaplace, sym_Kd, sym_Kp,
       sym_YT, sym_YS, sym_YrT, sym_YrS, sym_ET, sym_ES, sym_PS, sym_DS, sym_HS,
       sym_CT, sym_CS, sym_TStep, sym_TSim, sym_AbsTol, sym_RelTol :: Symbol

sym_negInf = Variable "-∞"
sym_posInf = Variable "∞"
sym_f_S = sub (Variable "F") $ Label "s"
sym_invLaplace = Variable "L⁻¹[F(s)]"
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
sym_AbsTol = Variable "AbsTol"
sym_RelTol = Variable "RelTol"

symbols :: [QuantityDict]
symbols
  = [qdLaplaceTransform, qdFreqDomain, qdFxnTDomain, qdNegInf, qdPosInf,
     qdInvLaplaceTransform, qdPropGain, qdDerivGain, qdSetPointTD, qdSetPointFD,
     qdProcessVariableTD, qdProcessVariableFD, qdProcessErrorTD, qdProcessErrorFD,
     qdDerivativeControlFD, qdPropControlFD, qdTransferFunctionFD, qdCtrlVarTD,
     qdCtrlVarFD, qdStepTime, qdSimTime]

qdLaplaceTransform, qdFreqDomain, qdFxnTDomain, qdNegInf, qdPosInf,
                    qdInvLaplaceTransform, qdPropGain, qdDerivGain,
                    qdSetPointTD, qdSetPointFD, qdProcessVariableTD,
                    qdProcessVariableFD, qdProcessErrorTD, qdProcessErrorFD,
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
  = constrained' (dqdNoUnit propGain sym_Kp Real) [gtZeroConstr] (dbl 20)
ipPropGainUnc = uq ipPropGain defaultUncrt
qdPropGain = qw ipPropGain

ipDerivGain
  = constrained' (dqdNoUnit derGain sym_Kd Real) [physc $ UpFrom  (Inc, 0)] (dbl 1)
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

odeAbsTolConst, odeRelTolConst :: QDefinition

dqdAbsTol, dqdRelTol :: DefinedQuantityDict

pidConstants :: [QDefinition]
pidConstants = [odeAbsTolConst, odeRelTolConst]

pidDqdConstants :: [DefinedQuantityDict]
pidDqdConstants = [dqdAbsTol, dqdRelTol]

dqdAbsTol = dqdNoUnit ccAbsTolerance sym_AbsTol Real
dqdRelTol = dqdNoUnit ccRelTolerance sym_RelTol Real

odeAbsTolConst = mkQuantDef dqdAbsTol (Dbl 1.0e-10)
odeRelTolConst = mkQuantDef dqdRelTol (Dbl 1.0e-10)

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

qdProcessErrorTD
  = vc "qdProcessErrorTD" (nounPhraseSent (S "Process Error in the time domain"))
      sym_ET
      Real

qdProcessErrorFD
  = vc "qdProcessErrorFD"
      (nounPhraseSent (S "Process Error in the frequency domain"))
      sym_ES
      Real

qdPropControlFD
  = vc "qdPropControlFD"
      (nounPhraseSent (S "Proportional control in the frequency domain"))
      sym_PS
      Real

qdDerivativeControlFD
  = vc "qdDerivativeControlFD"
      (nounPhraseSent (S "Derivative control in the frequency domain"))
      sym_DS
      Real

qdTransferFunctionFD
  = vc "qdTransferFunctionFD"
      (nounPhraseSent (S "Transfer Function in the frequency domain"))
      sym_HS
      Real

qdCtrlVarTD
  = vc "qdCtrlVarTD" (nounPhraseSent (S "Control Variable in the time domain"))
      sym_CT
      Real

qdCtrlVarFD
  = vc "qdCtrlVarFD"
      (nounPhraseSent (S "Control Variable in the frequency domain"))
      sym_CS
      Real

qdLaplaceTransform
  = vc "qLaplaceTransform"
      (nounPhraseSent (S "Laplace Transform of a function"))
      sym_f_S
      Real
qdFreqDomain
  = vc "qFreqDomain" (nounPhraseSent (S "Complex frequency-domain parameter"))
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
      (nounPhraseSent (S "Inverse Laplace Transform of a function"))
      sym_invLaplace
      Real

