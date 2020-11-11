module Drasil.PIDController.Body where

import qualified Data.Drasil.Concepts.Documentation as Doc (srs)
import Database.Drasil
       (Block, ChunkDB, ReferenceDB, SystemInformation(SI), _authors, _concepts,
        _configFiles, _constants, _constraints, _datadefs, _defSequence,
        _definitions, _inputs, _kind, _outputs, _purpose, _quants, _sys,
        _sysinfodb, _usedinfodb, cdb, rdb, refdb)

import Drasil.DocLang (SRSDecl, mkDoc)

import Drasil.PIDController.Concepts

import Data.Drasil.People (naveen)

import Language.Drasil
import Language.Drasil.Printers (PrintingInformation(..), defaultConfiguration)
import Theory.Drasil (DataDefinition, GenDefn, InstanceModel, TheoryModel)
import Utils.Drasil

srs :: Document
srs = mkDoc mkSRS (for'' titleize phrase) si

printSetting :: PrintingInformation
printSetting = PI symbMap Equational defaultConfiguration

mkSRS :: SRSDecl
mkSRS = []

si :: SystemInformation
si
  = SI{_sys = pidController, _kind = Doc.srs, _authors = [naveen],
       _purpose = [], _quants = [] :: [QuantityDict],
       _concepts = [] :: [DefinedQuantityDict],
       _definitions = [] :: [QDefinition], _datadefs = [] :: [DataDefinition],
       _configFiles = [], _inputs = [] :: [QuantityDict],
       _outputs = [] :: [QuantityDict],
       _defSequence = [] :: [Block QDefinition],
       _constraints = [] :: [ConstrainedChunk],
       _constants = [] :: [QDefinition], _sysinfodb = symbMap,
       _usedinfodb = usedDB, refdb = refDB}

symbMap :: ChunkDB
symbMap
  = cdb ([] :: [QuantityDict]) [nw pidController] ([] :: [ConceptChunk])
      ([] :: [UnitDefn])
      ([] :: [DataDefinition])
      ([] :: [InstanceModel])
      ([] :: [GenDefn])
      ([] :: [TheoryModel])
      ([] :: [ConceptInstance])
      ([] :: [Section])
      ([] :: [LabelledContent])

usedDB :: ChunkDB
usedDB
  = cdb ([] :: [QuantityDict]) ([] :: [IdeaDict]) ([] :: [ConceptChunk])
      ([] :: [UnitDefn])
      ([] :: [DataDefinition])
      ([] :: [InstanceModel])
      ([] :: [GenDefn])
      ([] :: [TheoryModel])
      ([] :: [ConceptInstance])
      ([] :: [Section])
      ([] :: [LabelledContent])

refDB :: ReferenceDB
refDB = rdb [] []
