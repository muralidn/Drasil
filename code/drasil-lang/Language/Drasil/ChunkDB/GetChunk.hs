-- | Utilities to get grab certain chunks (from Expr, Sentence, etc) by UID and
-- dereference the chunk it refers to.
module Language.Drasil.ChunkDB.GetChunk (vars, combine', vars', combine, ccss,
  getIdeaDict) where

import Data.List(nub)

import Language.Drasil.Expr (Expr)
import Language.Drasil.Sentence (Sentence)
import Language.Drasil.Expr.Extract(dep)
import Language.Drasil.Sentence.Extract (sdep, shortdep)

import Language.Drasil.Chunk.Quantity
import Language.Drasil.ChunkDB (symbLookup, symbolTable,
 defLookup, defTable, ChunkDB, termLookup, termTable)
import Language.Drasil.Chunk.Concept(ConceptChunk)
import Language.Drasil.Chunk.DefinedQuantity(DefinedQuantityDict, dqdQd)
import Language.Drasil.Chunk.NamedIdea(IdeaDict)

-- | Get a list of quantities (QuantityDict) from an equation in order to print
vars :: Expr -> ChunkDB -> [QuantityDict]
vars e m = map resolve $ dep e
  where resolve x = symbLookup x $ symbolTable m

concpt' :: Expr -> ChunkDB -> [ConceptChunk]
concpt' a m = map resolve $ dep a
  where resolve x = defLookup x $ defTable m

combine' :: Expr -> ChunkDB -> [DefinedQuantityDict]
combine' a m = zipWith dqdQd (vars a m) (concpt' a m)

ccss :: [Sentence] -> [Expr]-> ChunkDB -> [DefinedQuantityDict]
ccss s e c = nub $ concatMap (`combine` c) s ++ concatMap (`combine'` c) e

vars' :: Sentence -> ChunkDB -> [QuantityDict]
vars' a m = map resolve $ sdep a
  where resolve x = symbLookup x $ symbolTable m

concpt :: Sentence -> ChunkDB -> [ConceptChunk]
concpt a m = map resolve $ sdep a
  where resolve x = defLookup x $ defTable m

combine :: Sentence -> ChunkDB -> [DefinedQuantityDict]
combine a m = zipWith dqdQd (vars' a m) (concpt a m)

getIdeaDict :: Sentence -> ChunkDB -> [IdeaDict]
getIdeaDict a m = map resolve $ shortdep a
  where resolve x = termLookup x $ termTable m