module Drasil.PIDController.TModel where

import Data.Drasil.Quantities.Physics (time)
import Drasil.PIDController.Concepts

import Drasil.PIDController.References

import Language.Drasil
import qualified Language.Drasil as DrasilLang

import Theory.Drasil (TheoryModel, tm)

import Utils.Drasil

theoreticalModels :: [TheoryModel]
theoreticalModels = [tmLaplace, tmInvLaplace]

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
laplaceRC = makeRC "laplaceRC" (cn' "laplace transform") EmptyS laplaceRel

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
         S "usually inferred from the Laplace Transform table in "
         +:+ S " section 4 of the "
         +:+ makeCiteS laplaceWiki]

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
  = makeRC "invLaplaceRC" (cn' "inverse laplace transform") EmptyS invLaplaceRel

invLaplaceRel :: Relation
invLaplaceRel = sy qdFxnTDomain $= sy qdInvLaplaceTransform

invLaplaceDesc :: Sentence
invLaplaceDesc
  = foldlSent
      [S "Inverse Laplace Transform of F(S).",
       S "The Inverse Laplace transforms are " +:+
         S "usually inferred from the Laplace Transform table in "
         +:+ S " section 4 of the "
         +:+ makeCiteS laplaceWiki]
