module Drasil.PIDController.Concepts where

-- import Data.Drasil.IdeaDicts (controlEng)
import Language.Drasil

pidController :: CI
pidController
  = commonIdeaWithDict "pidController" (pn "PIDController") "PID"
      [] -- TODO: Not figure out the purpose of this dict.
