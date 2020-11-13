module Drasil.PIDController.Concepts where

-- import Data.Drasil.IdeaDicts (controlEng)
import Language.Drasil

pidControllerSystem, controlEngineering :: CI
pidControllerSystem
  = commonIdeaWithDict "pidControllerApp" (pn "PID Controller") "PID" []

controlEngineering
  = commonIdeaWithDict "ctrlEng" (cn' "control engineering") "N/A" []

pidC, pidCL, summingPt, powerPlant :: ConceptChunk
pidCL
  = dcc "pidCtrlLoop" (nounPhraseSP "PID Control Loop")
      ("Closed loop control system with PID Controller, Summing Point and Power Plant")

pidC = dcc "pidController" (nounPhraseSP "PID Controller") ("PID Controller")

summingPt
  = dcc "summingPoint" (nounPhraseSP "Summing Point")
      ("Control block where the difference between the Set-Point and the Process Variable is computed.")

powerPlant
  = dcc "powerPlant" (nounPhraseSP "Power Plant")
      ("The system to be controlled.")

defs :: [ConceptChunk]
defs = [pidCL, pidC, summingPt, powerPlant]

concepts :: [IdeaDict]
concepts = map nw defs
