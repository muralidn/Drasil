module Drasil.PIDController.Body where

import Data.Drasil.Concepts.Documentation (doccon, doccon')

import qualified Data.Drasil.Concepts.Documentation as Doc (srs)

import Data.Drasil.Concepts.Software (program)

import qualified Data.Drasil.IdeaDicts as IDict (dataDefn)

import Data.Drasil.People (naveen)
import Database.Drasil
       (Block, ChunkDB, ReferenceDB, SystemInformation(SI), _authors, _concepts,
        _configFiles, _constants, _constraints, _datadefs, _defSequence,
        _definitions, _inputs, _kind, _outputs, _purpose, _quants, _sys,
        _sysinfodb, _usedinfodb, cdb, rdb, refdb)

import Drasil.DocLang
       (AuxConstntSec(AuxConsProg), DerivationDisplay(ShowDerivation),
        DocSection(AuxConstntSec, Bibliography, GSDSec, IntroSec, RefSec,
                   ReqrmntSec, SSDSec, TraceabilitySec),
        Emphasis(Bold), Field(..), Fields, GSDSec(..), GSDSub(..),
        InclUnits(IncludeUnits), IntroSec(..), IntroSub(..), PDSub(..),
        ProblemDescription(PDProg), RefSec(..), RefTab(..), ReqrmntSec(..),
        ReqsSub(..), SCSSub(..), SRSDecl, SSDSec(..),
        SSDSub(SSDProblem, SSDSolChSpec), SolChSpec(SCSProg), TConvention(..),
        TSIntro(..), TraceabilitySec(TraceabilityProg), Verbosity(Verbose),
        intro, mkDoc, purpDoc, traceMatStandard, tsymb)

import Drasil.DocLang (SRSDecl, mkDoc)

import qualified Drasil.DocLang.SRS as SRS (inModel)

import Drasil.PIDController.Concepts

import Drasil.PIDController.IntroSection
       (introDocOrg, introPara, introPurposeOfDoc, introUserChar1,
        introUserChar2, introscopeOfReq)

import Drasil.PIDController.GenSysDesc
       (gsdSysContextFig, gsdSysContextList, gsdSysContextP1, gsdSysContextP2,
        gsdSysResp, gsdTitle, gsdUsrResp, gsduserCharacteristics)

import Drasil.PIDController.SpSysDesc
       (sysProblemDesc, sysParts, sysFigure, sysGoalStatement
         
       )

import Language.Drasil
import Language.Drasil.Printers (PrintingInformation(..), defaultConfiguration)
import Theory.Drasil (DataDefinition, GenDefn, InstanceModel, TheoryModel)
import Utils.Drasil

srs :: Document
srs = mkDoc mkSRS (for'' titleize phrase) si

printSetting :: PrintingInformation
printSetting = PI symbMap Equational defaultConfiguration

mkSRS :: SRSDecl
mkSRS
  = [RefSec $ RefProg intro [TUnits, tsymb [TSPurpose, SymbOrder], TAandA],
     IntroSec $
       IntroProg introPara (phrase pidControllerSystem)
         [IPurpose [introPurposeOfDoc], IScope introscopeOfReq,
          IChar introUserChar1 introUserChar2 [],
          IOrgSec introDocOrg IDict.dataDefn (SRS.inModel [] []) (S "")],
     GSDSec $
       GSDProg
         [SysCntxt
            [gsdSysContextP1, LlC gsdSysContextFig, gsdSysContextP2,
             gsdSysContextList],
          UsrChars [gsduserCharacteristics], SystCons [] []],
         SSDSec
         $
         SSDProg
           [SSDProblem $
              PDProg sysProblemDesc []
                [TermsAndDefs Nothing defs,
                 PhySysDesc pidControllerSystem sysParts sysFigure [],
                 Goals sysGoalStatement]
           ]]

si :: SystemInformation
si
  = SI{_sys = pidControllerSystem, _kind = Doc.srs, _authors = [naveen],
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
  = cdb ([] :: [QuantityDict])
      (nw pidControllerSystem :
         [nw program] ++ map nw doccon ++ map nw doccon' ++ concepts)
      ([] :: [ConceptChunk])
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

