module Drasil.PIDController.TModel where

import Data.Drasil.Quantities.Physics (time)
import Drasil.PIDController.Assumptions
import Drasil.PIDController.Concepts

import Drasil.PIDController.References

import Language.Drasil
import qualified Language.Drasil as DrasilLang

import Theory.Drasil (TheoryModel, tm)

import Utils.Drasil

theoreticalModels :: [TheoryModel]
theoreticalModels = [tmLaplace, tmInvLaplace, tmFOSystem]

tmLaplace :: TheoryModel
tmLaplace
  = tm (cw laplaceRC)
      [qw qdLaplaceTransform, qw qdFreqDomain, qw time, qw qdPosInf,
       qw qdFxnTDomain]
      ([] :: [ConceptChunk])
      []
      [laplaceRel]
      []
      [makeCite laplaceWiki]
      "laplaceTransform"
      [laplaceDesc]

laplaceRC :: RelationConcept
laplaceRC = makeRC "laplaceRC" (cn' "Laplace Transform") EmptyS laplaceRel

laplaceRel :: Relation
laplaceRel
  = sy qdLaplaceTransform $=
      defint (eqSymb time) (sy qdNegInf) (sy qdPosInf)
        ((sy qdFxnTDomain) *
           (DrasilLang.exp (negate ((sy qdFreqDomain) * (sy time)))))

laplaceDesc :: Sentence
laplaceDesc
  = foldlSent
      [S "Bilateral Laplace Transform.",
       S "The Laplace transforms are " +:+
         S "typically inferred from a pre-computed table of Laplace Transforms"
         +:+ S " ("
         +:+ makeCiteS laplaceWiki
         +:+ S ")"]

--------

tmInvLaplace :: TheoryModel
tmInvLaplace
  = tm (cw invlaplaceRC)
      [qw qdLaplaceTransform, qw qdFreqDomain, qw time, qw qdPosInf,
       qw qdFxnTDomain]
      ([] :: [ConceptChunk])
      []
      [invLaplaceRel]
      []
      [makeCite laplaceWiki]
      "invLaplaceTransform"
      [invLaplaceDesc]

invlaplaceRC :: RelationConcept
invlaplaceRC
  = makeRC "invLaplaceRC" (cn' "Inverse Laplace Transform") EmptyS invLaplaceRel

invLaplaceRel :: Relation
invLaplaceRel = sy qdFxnTDomain $= sy qdInvLaplaceTransform

invLaplaceDesc :: Sentence
invLaplaceDesc
  = foldlSent
      [S "Inverse Laplace Transform of F(S).",
       S "The Inverse Laplace transforms are " +:+
         S "typically inferred from a pre-computed table of Laplace Transforms"
         +:+ S " ("
         +:+ makeCiteS laplaceWiki
         +:+ S ")"]

--------

tmFOSystem :: TheoryModel
tmFOSystem
  = tm (cw tmFOSystemRC) [qw qdDCGain, qw qdTimeConst, qw qdFreqDomain]
      ([] :: [ConceptChunk])
      []
      [foSystemRel]
      []
      [makeCite electrical4U]
      "tmFOSystem"
      [foSystemDesc]

tmFOSystemRC :: RelationConcept
tmFOSystemRC
  = makeRC "tmFOSystemRC" (cn' "First Order System") EmptyS foSystemRel

foSystemRel :: Relation
foSystemRel = (sy qdDCGain) * (1 / ((sy qdTimeConst) * (sy qdFreqDomain) + 1))

foSystemDesc :: Sentence
foSystemDesc
  = foldlSent
      [S "The ", phrase ccTransferFxn, S " of a ", phrase firstOrderSystem,
       S "is characterized by this equation ( from", makeRef2S apwrPlantTxFnx,
       S ")"]

       --------
