module Utils.Drasil.Sentence (andIts, andThe, capSent, isExpctdToHv, isThe, ofGiv,
  ofGiv', ofThe, ofThe', sOf, sOr, sVersus, sAnd, sAre, sIn, sIs, toThe) where

import Language.Drasil

import Data.Char (toUpper)

sentHelper :: String -> Sentence -> Sentence -> Sentence
sentHelper inStr a b = a +:+ S inStr +:+ b

andIts, andThe, isExpctdToHv, isThe, ofGiv, ofGiv', ofThe, ofThe', sOf, sOr,
  sVersus, sAnd, sAre, sIn, sIs, toThe :: Sentence -> Sentence -> Sentence

andIts  = sentHelper "and its"
andThe  = sentHelper "and the"
isThe   = sentHelper "is the"
sAnd    = sentHelper "and"
sAre    = sentHelper "are"
sIn     = sentHelper "in"
sIs     = sentHelper "is"
sOf     = sentHelper "of"
sOr     = sentHelper "or"
sVersus = sentHelper "versus"
toThe   = sentHelper "to the"

isExpctdToHv a b = S "The" +:+ sentHelper "is expected to have" a b
ofGiv        a b = S "the" +:+ sentHelper "of a given"          a b
ofGiv'       a b = S "The" +:+ sentHelper "of a given"          a b
ofThe        a b = S "the" +:+ sentHelper "of the"              a b
ofThe'       a b = S "The" +:+ sentHelper "of the"              a b

capSent :: Sentence -> Sentence
capSent (S (s:ss)) = S (toUpper s : ss)
--capSent (phrase x) = atStart x
--capSent (plural x) = atStart' x
capSent (a :+: b)  = (capSent a) :+: b
capSent x          = x
