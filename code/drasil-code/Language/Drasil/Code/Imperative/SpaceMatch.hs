module Language.Drasil.Code.Imperative.SpaceMatch (
  chooseSpace
) where

import Language.Drasil
import Language.Drasil.Choices (Choices(..))
import Language.Drasil.Code.Imperative.DrasilState (GenState, MatchedSpaces, 
  addToDesignLog, addLoggedSpace)
import Language.Drasil.Code.Lang (Lang(..))

import GOOL.Drasil (CodeType(..))

import Control.Monad.State (modify)
import Text.PrettyPrint.HughesPJ (Doc, text)

-- Concretizes the SpaceMatch in Choices to a MatchedSpace based on target language
chooseSpace :: Lang -> Choices -> MatchedSpaces
chooseSpace lng chs = \s -> selectType lng s (spaceMatch chs s)
        -- Floats unavailable in Python
  where selectType :: Lang -> Space -> [CodeType] -> GenState CodeType
        selectType Python s (Float:ts) = do
          modify (addLoggedSpace s Float . 
            addToDesignLog s Float (incompatibleType Python s Float))
          selectType Python s ts
        -- In all other cases, just select first choice
        selectType _ _ (t:_) = return t
        selectType l s [] = error $ "Chosen CodeType matches for Space " ++ 
          show s ++ " are not compatible with target language " ++ show l

-- Defines a design log message based on an incompatibility between the given 
-- Lang and attempted Space-CodeType match
incompatibleType :: Lang -> Space -> CodeType -> Doc
incompatibleType l s t = text $ "Language " ++ show l ++ " does not support "
  ++ "code type " ++ show t ++ ", chosen as the match for the " ++ show s ++ 
  " space. Trying next choice." 