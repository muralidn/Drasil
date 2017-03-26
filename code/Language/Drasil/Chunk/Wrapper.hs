{-# LANGUAGE GADTs, Rank2Types #-}

module Language.Drasil.Chunk.Wrapper 
  ( nw, NWrapper
  ) where

import Control.Lens (Simple, Lens, set, (^.))
import Language.Drasil.Chunk
import Language.Drasil.Chunk.NamedIdea
import Prelude hiding (id)

{- NamedIdea Wrapper -}
data NWrapper where
  NW :: (NamedIdea c) => c -> NWrapper
  
instance Chunk NWrapper where
  id = nlens id
  
instance NamedIdea NWrapper where
  term = nlens term
  getA (NW a) = getA a

nw :: NamedIdea c => c -> NWrapper
nw = NW

nlens :: (forall c. (NamedIdea c) => 
  Simple Lens c a) -> Simple Lens NWrapper a
nlens l f (NW a) = fmap (\x -> NW (set l x a)) (f (a ^. l))

instance Eq NWrapper where
  a == b = (a ^. id) == (b ^. id)


