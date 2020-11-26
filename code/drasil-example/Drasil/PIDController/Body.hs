module Drasil.PIDController.Body where

import Data.Drasil.Concepts.Documentation (doccon, doccon', srsDomains)

import qualified Data.Drasil.Concepts.Documentation as Doc (srs)
import Data.Drasil.Concepts.Math (mathcon)

import Data.Drasil.Concepts.Software (program)

import Data.Drasil.ExternalLibraries.ODELibraries
       (apacheODESymbols, arrayVecDepVar, odeintSymbols, osloSymbols,
        scipyODESymbols)

import qualified Data.Drasil.IdeaDicts as IDict (dataDefn)

import Data.Drasil.People (naveen)
import Data.Drasil.Quantities.Physics (physicscon, time)
import Data.Drasil.SI_Units (second)
import Database.Drasil
       (Block, ChunkDB, ReferenceDB, SystemInformation(SI), _authors, _concepts,
        _configFiles, _constants, _constraints, _datadefs, _defSequence,
        _definitions, _inputs, _kind, _outputs, _purpose, _quants, _sys,
        _sysinfodb, _usedinfodb, cdb, rdb, refdb)

import Drasil.DocLang
       (AuxConstntSec(AuxConsProg), DerivationDisplay(..),
        DocSection(AuxConstntSec, Bibliography, GSDSec, IntroSec, LCsSec,
                   RefSec, ReqrmntSec, SSDSec, TraceabilitySec),
        Emphasis(Bold), Field(..), Fields, GSDSec(..), GSDSub(..),
        InclUnits(IncludeUnits), IntroSec(..), IntroSub(..), PDSub(..),
        ProblemDescription(PDProg), RefSec(..), RefTab(..), ReqrmntSec(..),
        ReqsSub(..), SCSSub(..), SRSDecl, SSDSec(..),
        SSDSub(SSDProblem, SSDSolChSpec), SolChSpec(SCSProg), TConvention(..),
        TSIntro(..), TraceabilitySec(TraceabilityProg), Verbosity(Verbose),
        intro, mkDoc, purpDoc, traceMatStandard, tsymb)

import qualified Drasil.DocLang.SRS as SRS (inModel)

import Drasil.PIDController.Assumptions (assumptions)

import Drasil.PIDController.Changes

import Drasil.PIDController.Concepts
import Drasil.PIDController.DataDefs (dataDefinitions)

import Drasil.PIDController.GenSysDesc
       (gsdSysContextFig, gsdSysContextList, gsdSysContextP1, gsdSysContextP2,
        gsduserCharacteristics)
import Drasil.PIDController.IModel

import Drasil.PIDController.IntroSection
       (introDocOrg, introPara, introPurposeOfDoc, introUserChar1,
        introUserChar2, introscopeOfReq)

import Drasil.PIDController.References (citations)

import Drasil.PIDController.Requirements

import Drasil.PIDController.SpSysDesc
       (goals, sysFigure, sysGoalInput, sysParts, sysProblemDesc)

import Drasil.PIDController.TModel (theoreticalModels)

import Drasil.SWHS.Unitals (absTol, relTol)
import Language.Drasil hiding (Symbol(..), Vector)

import Language.Drasil.Code
       (ODEInfo, ODEMethod(..), ODEOptions, listToArray, odeInfo, odeOptions,
        quantvar)
import Language.Drasil.Code (relToQD)
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
     SSDSec $
       SSDProg
         [SSDProblem $
            PDProg sysProblemDesc []
              [TermsAndDefs Nothing defs,
               PhySysDesc pidControllerSystem sysParts sysFigure [],
               Goals sysGoalInput],
          SSDSolChSpec $
            SCSProg
              [Assumptions, TMs [] (Label : stdFields),
               GDs [S "No general definitions for this project"] []
                 HideDerivation,
               DDs [] ([Label, Symbol, Units] ++ stdFields) ShowDerivation,
               IMs []
                 ([Label, Input, Output, InConstraints, OutConstraints] ++
                    stdFields)
                 ShowDerivation,
               Constraints EmptyS inputsUC]],

     ReqrmntSec $ ReqsProg [FReqsSub EmptyS [], NonFReqsSub], LCsSec,
     TraceabilitySec $ TraceabilityProg $ traceMatStandard si, Bibliography]

si :: SystemInformation
si
  = SI{_sys = pidControllerSystem, _kind = Doc.srs, _authors = [naveen],
       _purpose = [], _quants = symbolsAll,
       _concepts = [] :: [DefinedQuantityDict],
       _definitions = [] :: [QDefinition], _datadefs = dataDefinitions,
       _configFiles = [], _inputs = inputsAll, _outputs = outputs,
       _defSequence = [] :: [Block QDefinition],
       _constraints = map cnstrw inpConstrained,
       _constants = [] :: [QDefinition], _sysinfodb = symbMap,
       _usedinfodb = usedDB, refdb = refDB}

unconstrained :: [UncertainChunk]
unconstrained = [absTol, relTol]

inputsAll :: [QuantityDict]
inputsAll = inputs ++ map qw unconstrained

symbolsAll :: [QuantityDict]
symbolsAll
  = symbols ++
      scipyODESymbols ++
        osloSymbols ++
          apacheODESymbols ++
            odeintSymbols ++
              map qw [arrayVecDepVar pidODEInfo] ++ map qw unconstrained

symbMap :: ChunkDB
symbMap
  = cdb (map qw physicscon ++ symbolsAll)
      (nw pidControllerSystem :
         [nw program] ++
           map nw doccon ++
             map nw doccon' ++
               concepts ++
                 map nw mathcon ++
                   map nw [second] ++
                     map nw symbols ++ map nw physicscon ++ map nw acronyms)
      (map cw inpConstrained ++ srsDomains)
      (map unitWrapper [second])
      (dataDefinitions)
      (instanceModels)
      ([] :: [GenDefn])
      (theoreticalModels)
      (conceptInstances)
      ([] :: [Section])
      ([] :: [LabelledContent])

usedDB :: ChunkDB
usedDB
  = cdb ([] :: [QuantityDict]) (map nw acronyms ++ map nw symbolsAll)
      ([] :: [ConceptChunk])
      ([] :: [UnitDefn])
      ([] :: [DataDefinition])
      ([] :: [InstanceModel])
      ([] :: [GenDefn])
      ([] :: [TheoryModel])
      ([] :: [ConceptInstance])
      ([] :: [Section])
      ([] :: [LabelledContent])

refDB :: ReferenceDB
refDB = rdb citations conceptInstances

conceptInstances :: [ConceptInstance]
conceptInstances = assumptions ++ goals ++ funcReqs ++ nonfuncReqs ++ likelyChgs

stdFields :: Fields
stdFields
  = [DefiningEquation, Description Verbose IncludeUnits, Notes, Source, RefBy]

pidODEOptions :: ODEOptions
pidODEOptions = odeOptions RK45 (sy absTol) (sy relTol) (sy qdStepTime)

pidODEInfo :: ODEInfo
pidODEInfo
  = odeInfo (quantvar time) (quantvar opProcessVariable)
      [quantvar ipPropGain, quantvar ipDerivGain, quantvar ipSetPt]
      (dbl 0)
      (sy qdSimTime)
      (dbl 0)
      [(((sy qdSetPointTD) * (sy qdPropGain)) -
          (1 + sy qdPropGain) * (idx (sy opProcessVariable) (int 0)))
         / (2 + sy qdDerivGain)]
      pidODEOptions
