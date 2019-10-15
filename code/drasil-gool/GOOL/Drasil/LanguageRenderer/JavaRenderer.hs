{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE PostfixOperators #-}

-- | The logic to render Java code is contained in this module
module GOOL.Drasil.LanguageRenderer.JavaRenderer (
  -- * Java Code Configuration -- defines syntax of all Java code
  JavaCode(..)
) where

import Utils.Drasil (indent)

import GOOL.Drasil.CodeType (CodeType(..), isObject)
import GOOL.Drasil.Symantics (Label, ProgramSym(..), RenderSym(..), 
  InternalFile(..), KeywordSym(..), PermanenceSym(..), InternalPerm(..), 
  BodySym(..), BlockSym(..), InternalBlock(..), ControlBlockSym(..), 
  TypeSym(..), InternalType(..), UnaryOpSym(..), BinaryOpSym(..), 
  VariableSym(..), InternalVariable(..), ValueSym(..), NumericExpression(..), 
  BooleanExpression(..), ValueExpression(..), InternalValue(..), Selector(..), 
  FunctionSym(..), SelectorFunction(..), InternalFunction(..), 
  InternalStatement(..), StatementSym(..), ControlStatementSym(..), 
  ScopeSym(..), InternalScope(..), MethodTypeSym(..), ParameterSym(..), 
  MethodSym(..), InternalMethod(..), StateVarSym(..), InternalStateVar(..), 
  ClassSym(..), InternalClass(..), ModuleSym(..), InternalMod(..), 
  BlockCommentSym(..))
import GOOL.Drasil.LanguageRenderer (packageDocD, classDocD, multiStateDocD, 
  bodyDocD, oneLinerD, printListDoc, outDoc, prFn, prStrFn, prLnFn, 
  printFileDocD, boolTypeDocD, intTypeDocD, charTypeDocD, typeDocD, 
  enumTypeDocD, listTypeDocD, listInnerTypeD, iteratorError, voidDocD, 
  destructorError, paramDocD, paramListDocD, mkParam, runStrategyD, listSliceD, 
  checkStateD, notifyObserversD, listDecDocD, mkSt, stringListVals', 
  stringListLists', printStD, stateD, loopStateD, emptyStateD, assignD, 
  assignToListIndexD, multiAssignError, decrementD, incrementD, decrement1D, 
  increment1D, discardInputD, discardFileInputD, openFileRD, openFileWD, 
  openFileAD, closeFileD, discardFileLineD, breakD, continueD, returnD, 
  multiReturnError, valStateD, freeError, throwD, initStateD, changeStateD, 
  initObserverListD, addObserverD, ifNoElseD, switchD, switchAsIfD, ifExistsD, 
  forRangeD, tryCatchD, unOpPrec, notOpDocD, negateOpDocD, unExpr, unExpr', 
  powerPrec, equalOpDocD, notEqualOpDocD, greaterOpDocD, greaterEqualOpDocD, 
  lessOpDocD, lessEqualOpDocD, plusOpDocD, minusOpDocD, multOpDocD, 
  divideOpDocD, moduloOpDocD, andOpDocD, orOpDocD, binExpr, binExpr', 
  typeBinExpr, mkVal, litTrueD, litFalseD, litCharD, litFloatD, litIntD, 
  litStringD, classVarD, classVarDocD, inlineIfD, newObjDocD, varD, staticVarD, 
  extVarD, selfD, enumVarD, classVarD, objVarD, listVarD, listOfD, valueOfD, 
  argD, enumElementD, argsListD, objAccessD, objMethodCallD, 
  objMethodCallNoParamsD, selfAccessD, listIndexExistsD, indexOfD, funcAppD, 
  extFuncAppD, newObjD, notNullD, castDocD, castObjDocD, funcD, getD, setD, 
  listSizeD, listAddD, listAppendD, iterBeginD, iterEndD, listAccessD, listSetD,
  getFuncD, setFuncD, listSizeFuncD, listAddFuncD, listAppendFuncD, 
  iterBeginError, iterEndError, listAccessFuncD', staticDocD, dynamicDocD, 
  bindingError, privateDocD, publicDocD, dot, new, elseIfLabel, forLabel, 
  blockCmtStart, blockCmtEnd, docCmtStart, doubleSlash, blockCmtDoc, docCmtDoc, 
  commentedItem, addCommentsDocD, commentedModD, docFuncRepr, valueList,
  appendToBody, surroundBody, intValue, filterOutObjs)
import qualified GOOL.Drasil.LanguageRenderer.LanguagePolymorphic as G (block, 
  varDec, varDecDef, listDec, listDecDef, objDecNew, objDecNewNoParams, 
  construct, comment, ifCond, for, forEach, while, method, getMethod, setMethod,
  privMethod, pubMethod, constructor, docMain, function, mainFunction, docFunc, 
  intFunc, stateVar, stateVarDef, constVar, privMVar, pubMVar, pubGVar, 
  buildClass, enum, privClass, pubClass, docClass, commentedClass, buildModule',
  fileDoc, docMod)
import GOOL.Drasil.Data (Other, Boolean, Terminator(..), FileType(..), 
  FileData(..), fileD, TypedFunc(..), funcDoc, ModData(..), md, MethodData(..), 
  mthd, updateMthdDoc, OpData(..), ParamData(..), ProgData(..), progD, 
  TypeData(..), td, ltd, TypedType(..), cType, typeString, typeDoc, 
  updateTypedType, TypedValue(..), valDoc, toOtherVal, TypedVar(..), otherVar, 
  varBind, varName, varType, varDoc, toOtherVar, typeToFunc, typeToVal, 
  typeToVar, funcToType, valToType, varToType)
import GOOL.Drasil.Helpers (angles, emptyIfNull, liftA4, liftA5, liftList, 
  lift1List, getNestDegree, checkParams)

import Prelude hiding (break,print,sin,cos,tan,floor,(<>))
import qualified Prelude as P (const)
import Control.Applicative (Applicative, liftA2, liftA3)
import Text.PrettyPrint.HughesPJ (Doc, text, (<>), (<+>), parens, empty, space, 
  equals, semi, vcat, lbrace, rbrace, render, colon, comma, render)

jExt :: String
jExt = "java"

newtype JavaCode a = JC {unJC :: a}

instance Functor JavaCode where
  fmap f (JC x) = JC (f x)

instance Applicative JavaCode where
  pure = JC
  (JC f) <*> (JC x) = JC (f x)

instance Monad JavaCode where
  return = JC
  JC x >>= f = f x

instance ProgramSym JavaCode where
  type Program JavaCode = ProgData
  prog n ms = liftList (progD n) (map (liftA2 (packageDocD n) endStatement) ms)

instance RenderSym JavaCode where
  type RenderFile JavaCode = FileData 
  fileDoc code = G.fileDoc Combined jExt (top code) bottom code

  docMod = G.docMod

  commentedMod = liftA2 commentedModD

instance InternalFile JavaCode where
  top _ = liftA3 jtop endStatement (include "") (list static_)
  bottom = return empty
  
  getFilePath = filePath . unJC
  fileFromData ft fp = fmap (fileD ft fp)

instance KeywordSym JavaCode where
  type Keyword JavaCode = Doc
  endStatement = return semi
  endStatementLoop = return empty

  include _ = return $ text "import"
  inherit n = return $ text "extends" <+> text n

  list _ = return $ text "ArrayList"

  blockStart = return lbrace
  blockEnd = return rbrace

  ifBodyStart = blockStart
  elseIf = return elseIfLabel
  
  iterForEachLabel = return forLabel
  iterInLabel = return colon

  commentStart = return doubleSlash
  blockCommentStart = return blockCmtStart
  blockCommentEnd = return blockCmtEnd
  docCommentStart = return docCmtStart
  docCommentEnd = blockCommentEnd

  keyDoc = unJC

instance PermanenceSym JavaCode where
  type Permanence JavaCode = Doc
  static_ = return staticDocD
  dynamic_ = return dynamicDocD

instance InternalPerm JavaCode where
  permDoc = unJC
  binding = error $ bindingError jName

instance BodySym JavaCode where
  type Body JavaCode = Doc
  body = liftList bodyDocD
  bodyStatements = block
  oneLiner = oneLinerD

  addComments s = liftA2 (addCommentsDocD s) commentStart

  bodyDoc = unJC

instance BlockSym JavaCode where
  type Block JavaCode = Doc
  block = G.block endStatement

instance InternalBlock JavaCode where
  blockDoc = unJC
  docBlock = return

instance TypeSym JavaCode where
  type Type JavaCode = TypedType
  bool = return boolTypeDocD
  int = return intTypeDocD
  float = return jFloatTypeDocD
  char = return charTypeDocD
  string = return jStringTypeDoc
  infile = return jInfileTypeDoc
  outfile = return jOutfileTypeDoc
  listType p st = liftA2 jListType st (list p)
  listInnerType = fmap listInnerTypeD
  obj t = return $ typeDocD t
  enumType t = return $ enumTypeDocD t
  iterator _ = error $ iteratorError jName
  void = return voidDocD

  getType = cType . unJC
  getTypeString = typeString . unJC
  getTypeDoc = typeDoc . unJC
  
instance InternalType JavaCode where
  getTypedType = unJC
  updateType t tf sf df = liftA4 updateTypedType t (return tf) (return sf) 
    (return df)

instance ControlBlockSym JavaCode where
  runStrategy = runStrategyD

  listSlice = listSliceD

instance UnaryOpSym JavaCode where
  type UnaryOp JavaCode = OpData
  notOp = return notOpDocD
  negateOp = return negateOpDocD
  sqrtOp = return $ unOpPrec "Math.sqrt"
  absOp = return $ unOpPrec "Math.abs"
  logOp = return $ unOpPrec "Math.log10"
  lnOp = return $ unOpPrec "Math.log"
  expOp = return $ unOpPrec "Math.exp"
  sinOp = return $ unOpPrec "Math.sin"
  cosOp = return $ unOpPrec "Math.cos"
  tanOp = return $ unOpPrec "Math.tan"
  asinOp = return $ unOpPrec "Math.asin"
  acosOp = return $ unOpPrec "Math.acos"
  atanOp = return $ unOpPrec "Math.atan"
  floorOp = return $ unOpPrec "Math.floor"
  ceilOp = return $ unOpPrec "Math.ceil"

instance BinaryOpSym JavaCode where
  type BinaryOp JavaCode = OpData
  equalOp = return equalOpDocD
  notEqualOp = return notEqualOpDocD
  greaterOp = return greaterOpDocD
  greaterEqualOp = return greaterEqualOpDocD
  lessOp = return lessOpDocD
  lessEqualOp = return lessEqualOpDocD
  plusOp = return plusOpDocD
  minusOp = return minusOpDocD
  multOp = return multOpDocD
  divideOp = return divideOpDocD
  powerOp = return $ powerPrec "Math.pow"
  moduloOp = return moduloOpDocD
  andOp = return andOpDocD
  orOp = return orOpDocD

instance VariableSym JavaCode where
  type Variable JavaCode = TypedVar
  var = varD
  staticVar = staticVarD
  const = var
  extVar = extVarD
  self = selfD
  enumVar = enumVarD
  classVar = classVarD classVarDocD
  objVar = objVarD
  objVarSelf _ = var
  listVar = listVarD
  listOf = listOfD
  iterVar = var

  ($->) = objVar

  variableBind = varBind . unJC
  variableName = varName . unJC
  variableType = fmap varToType
  variableDoc = varDoc . unJC
  toOtherVariable = fmap toOtherVar
  
instance InternalVariable JavaCode where
  varFromData b n t d = liftA2 (typeToVar b n) t (return d)

instance ValueSym JavaCode where
  type Value JavaCode = TypedValue
  litTrue = litTrueD
  litFalse = litFalseD
  litChar = litCharD
  litFloat = litFloatD
  litInt = litIntD
  litString = litStringD

  ($:) = enumElement

  valueOf = valueOfD
  arg n = argD (litInt n) argsList
  enumElement = enumElementD

  argsList = argsListD "args"

  valueType = fmap valToType
  valueDoc = valDoc . unJC
  getTypedVal = unJC
  toOtherValue = fmap toOtherVal

instance NumericExpression JavaCode where
  (#~) = liftA2 unExpr' negateOp
  (#/^) = liftA2 unExpr sqrtOp
  (#|) = liftA2 unExpr absOp
  (#+) = liftA3 binExpr plusOp
  (#-) = liftA3 binExpr minusOp
  (#*) = liftA3 binExpr multOp
  (#/) = liftA3 binExpr divideOp
  (#%) = liftA3 binExpr moduloOp
  (#^) = liftA3 binExpr' powerOp

  log = liftA2 unExpr logOp
  ln = liftA2 unExpr lnOp
  exp = liftA2 unExpr expOp
  sin = liftA2 unExpr sinOp
  cos = liftA2 unExpr cosOp
  tan = liftA2 unExpr tanOp
  csc v = litFloat 1.0 #/ sin v
  sec v = litFloat 1.0 #/ cos v
  cot v = litFloat 1.0 #/ tan v
  arcsin = liftA2 unExpr asinOp
  arccos = liftA2 unExpr acosOp
  arctan = liftA2 unExpr atanOp
  floor = liftA2 unExpr floorOp
  ceil = liftA2 unExpr ceilOp

instance BooleanExpression JavaCode where
  (?!) = liftA2 unExpr notOp
  (?&&) = liftA4 typeBinExpr andOp bool
  (?||) = liftA4 typeBinExpr orOp bool

  (?<) = liftA4 typeBinExpr lessOp bool
  (?<=) = liftA4 typeBinExpr lessEqualOp bool
  (?>) = liftA4 typeBinExpr greaterOp bool
  (?>=) = liftA4 typeBinExpr greaterEqualOp bool
  (?==) = jEquality
  (?!=) = liftA4 typeBinExpr notEqualOp bool
  
instance ValueExpression JavaCode where
  inlineIf = liftA3 inlineIfD
  funcApp = funcAppD
  selfFuncApp = funcApp
  extFuncApp = extFuncAppD
  newObj = newObjD newObjDocD
  extNewObj _ = newObj

  exists = notNull
  notNull = notNullD

instance InternalValue JavaCode where
  inputFunc = liftA2 mkVal (obj "Scanner") (return $ parens (
    text "new Scanner(System.in)"))
  printFunc = liftA2 mkVal void (return $ text "System.out.print")
  printLnFunc = liftA2 mkVal void (return $ text "System.out.println")
  printFileFunc f = liftA2 mkVal void (fmap (printFileDocD "print") f)
  printFileLnFunc f = liftA2 mkVal void (fmap (printFileDocD "println") f)
  
  cast = jCast
  
  valFromData p t d = liftA2 (typeToVal p) t (return d)

instance Selector JavaCode where
  objAccess = objAccessD
  ($.) = objAccess

  objMethodCall = objMethodCallD
  objMethodCallNoParams = objMethodCallNoParamsD

  selfAccess = selfAccessD

  listIndexExists = listIndexExistsD
  argExists i = listSize argsList ?> litInt (fromIntegral i)
  
  indexOf = indexOfD "indexOf"

instance FunctionSym JavaCode where
  type Function JavaCode = TypedFunc
  func = funcD

  get = getD
  set = setD

  listSize = listSizeD
  listAdd = listAddD
  listAppend = listAppendD

  iterBegin = iterBeginD
  iterEnd = iterEndD

instance SelectorFunction JavaCode where
  listAccess = listAccessD
  listSet = listSetD
  at = listAccess

instance InternalFunction JavaCode where
  getFunc = getFuncD
  setFunc = setFuncD

  listSizeFunc = listSizeFuncD
  listAddFunc _ = listAddFuncD "add"
  listAppendFunc = listAppendFuncD "add"

  iterBeginFunc _ = error $ iterBeginError jName
  iterEndFunc _ = error $ iterEndError jName
  
  listAccessFunc = listAccessFuncD' "get"
  listSetFunc v i toVal = func "set" (valueType v) [intValue i, fmap toOtherVal toVal]

  functionType = fmap funcToType
  functionDoc = funcDoc . unJC

  funcFromData t d = liftA2 typeToFunc t (return d)

instance InternalStatement JavaCode where
  printSt _ p v _ = printStD p v

  state = stateD
  loopState = loopStateD

  emptyState = emptyStateD
  statementDoc = fst . unJC
  statementTerm = snd . unJC
  
  stateFromData d t = return (d, t)

instance StatementSym JavaCode where
  -- Terminator determines how statements end
  type Statement JavaCode = (Doc, Terminator)
  assign = assignD Semi
  assignToListIndex = assignToListIndexD
  multiAssign _ _ = error $ multiAssignError jName
  (&=) = assign
  (&-=) = decrementD
  (&+=) = incrementD
  (&++) = increment1D
  (&~-) = decrement1D

  varDec = G.varDec static_ dynamic_
  varDecDef = G.varDecDef
  listDec n v = G.listDec (listDecDocD v) (litInt n) v
  listDecDef v = G.listDecDef (jListDecDef v) v
  objDecDef = varDecDef
  objDecNew = G.objDecNew
  extObjDecNew _ = objDecNew
  objDecNewNoParams = G.objDecNewNoParams
  extObjDecNewNoParams _ = objDecNewNoParams
  constDecDef v def = mkSt <$> liftA2 jConstDecDef v def

  print v = jOut False printFunc v Nothing
  printLn v = jOut True printLnFunc v Nothing
  printStr s = jOut False printFunc (litString s) Nothing
  printStrLn s = jOut True printLnFunc (litString s) Nothing

  printFile f v = jOut False (printFileFunc f) v (Just f)
  printFileLn f v = jOut True (printFileLnFunc f) v (Just f)
  printFileStr f s = jOut False (printFileFunc f) (litString s) (Just f)
  printFileStrLn f s = jOut True (printFileLnFunc f) (litString s) (Just f)

  getInput v = v &= liftA2 jInput (variableType v) inputFunc
  discardInput = discardInputD jDiscardInput
  getFileInput f v = v &= liftA2 jInput (variableType v) f
  discardFileInput = discardFileInputD jDiscardInput

  openFileR = openFileRD jOpenFileR
  openFileW = openFileWD jOpenFileWorA
  openFileA = openFileAD jOpenFileWorA
  closeFile = closeFileD "close"

  getFileInputLine f v = v &= f $. func "nextLine" string []
  discardFileLine = discardFileLineD "nextLine"
  stringSplit d vnew s = mkSt <$> liftA2 jStringSplit vnew 
    (funcApp "Arrays.asList" (listType static_ string) 
    [toOtherValue $ s $. func "split" (listType static_ string) [litString [d]]])

  stringListVals = stringListVals'
  stringListLists = stringListLists'

  break = breakD Semi  -- I could have a JumpSym class with functions for "return $ text "break" and then reference those functions here?
  continue = continueD Semi

  returnState = returnD Semi
  multiReturn _ = error $ multiReturnError jName

  valState = valStateD Semi

  comment = G.comment commentStart

  free _ = error $ freeError jName -- could set variable to null? Might be misleading.

  throw = throwD jThrowDoc Semi

  initState = initStateD
  changeState = changeStateD

  initObserverList = initObserverListD
  addObserver = addObserverD

  inOutCall = jInOutCall funcApp
  extInOutCall m = jInOutCall (extFuncApp m)

  multi = lift1List multiStateDocD endStatement

instance ControlStatementSym JavaCode where
  ifCond = G.ifCond ifBodyStart elseIf blockEnd
  ifNoElse = ifNoElseD
  switch  = switchD
  switchAsIf = switchAsIfD

  ifExists = ifExistsD

  for = G.for blockStart blockEnd
  forRange = forRangeD 
  forEach = G.forEach blockStart blockEnd iterForEachLabel iterInLabel
  while = G.while blockStart blockEnd

  tryCatch = tryCatchD jTryCatch
  
  checkState = checkStateD
  notifyObservers = notifyObserversD

  getFileInputAll f v = while (f $. func "hasNextLine" bool [])
    (oneLiner $ valState $ listAppend (valueOf v) (f $. func "nextLine" string []))

instance ScopeSym JavaCode where
  type Scope JavaCode = Doc
  private = return privateDocD
  public = return publicDocD

instance InternalScope JavaCode where
  scopeDoc = unJC

instance MethodTypeSym JavaCode where
  type MethodType JavaCode = TypedType
  mType t = t
  construct = return . G.construct

instance ParameterSym JavaCode where
  type Parameter JavaCode = ParamData
  param = fmap (mkParam paramDocD)
  pointerParam = param

  parameterName = variableName . fmap (otherVar . paramVar)

instance MethodSym JavaCode where
  type Method JavaCode = MethodData
  method = G.method
  getMethod = G.getMethod
  setMethod = G.setMethod
  privMethod = G.privMethod
  pubMethod = G.pubMethod
  constructor n = G.constructor n n
  destructor _ _ = error $ destructorError jName

  docMain = G.docMain

  function = G.function
  mainFunction = G.mainFunction string "main"

  docFunc = G.docFunc

  inOutFunc n s p ins [] [] b = function n s p void (map param ins) b
  inOutFunc n s p ins [v] [] b = function n s p (variableType v) 
    (map param ins) (liftA3 surroundBody (varDec v) b (returnState $ 
    valueOf v))
  inOutFunc n s p ins [] [v] b = function n s p (if null (filterOutObjs [v]) 
    then void else variableType v) (map param $ v : ins) 
    (if null (filterOutObjs [v]) then b else liftA2 appendToBody b 
    (returnState $ valueOf v))
  inOutFunc n s p ins outs both b = function n s p (returnTp rets)
    (map param $ both ++ ins) (liftA3 surroundBody decls b (returnSt rets))
    where returnTp [x] = variableType x
          returnTp _ = jArrayType
          returnSt [x] = returnState $ valueOf x
          returnSt _ = multi (varDecDef outputs (valueOf (var 
            ("new Object[" ++ show (length rets) ++ "]") jArrayType))
            : assignArray 0 (map valueOf rets)
            ++ [returnState (valueOf outputs)])
          assignArray :: Int -> [JavaCode (Value JavaCode Other)] -> 
            [JavaCode (Statement JavaCode)]
          assignArray _ [] = []
          assignArray c (v:vs) = (var ("outputs[" ++ show c ++ "]") 
            (fmap valToType v) &= v) : assignArray (c+1) vs
          decls = multi $ map varDec outs
          rets = filterOutObjs both ++ outs
          outputs = var "outputs" jArrayType
    
  docInOutFunc n s p desc is [] [] b = docFuncRepr desc (map fst is) [] 
    (inOutFunc n s p (map snd is) [] [] b)
  docInOutFunc n s p desc is [o] [] b = docFuncRepr desc (map fst is) [fst o] 
    (inOutFunc n s p (map snd is) [snd o] [] b)
  docInOutFunc n s p desc is [] [both] b = docFuncRepr desc (map fst (both : 
    is)) [fst both | not ((isObject . getType . variableType . snd) both)]
    (inOutFunc n s p (map snd is) [] [snd both] b)
  docInOutFunc n s p desc is os bs b = docFuncRepr desc (map fst $ bs ++ is) 
    (bRets ++ map fst os) (inOutFunc n s p (map snd is) (map snd os) 
    (map snd bs) b)
    where bRets = bRets' (map fst (filter (not . isObject . getType . 
            variableType . snd) bs))
          bRets' [x] = [x]
          bRets' xs = "array containing the following values:" : xs
    
  parameters m = map return $ (mthdParams . unJC) m

instance InternalMethod JavaCode where
  intMethod m n _ s p t ps b = liftA2 (mthd m) (checkParams n <$> sequence ps)
    (liftA5 (jMethod n) s p t (liftList paramListDocD ps) b)
  intFunc = G.intFunc
  commentedFunc cmt = liftA2 updateMthdDoc (fmap commentedItem cmt)
  
  isMainMethod = isMainMthd . unJC
  methodDoc = mthdDoc . unJC

instance StateVarSym JavaCode where
  type StateVar JavaCode = Doc
  stateVar _ = G.stateVar
  stateVarDef _ _ = G.stateVarDef
  constVar _ _ = G.constVar (permDoc (static_ :: JavaCode (Permanence JavaCode)))
  privMVar = G.privMVar
  pubMVar = G.pubMVar
  pubGVar = G.pubGVar

instance InternalStateVar JavaCode where
  stateVarDoc = unJC
  stateVarFromData = return

instance ClassSym JavaCode where
  type Class JavaCode = Doc
  buildClass = G.buildClass classDocD inherit
  enum = G.enum
  privClass = G.privClass
  pubClass = G.pubClass

  docClass = G.docClass

  commentedClass = G.commentedClass

instance InternalClass JavaCode where
  classDoc = unJC
  classFromData = return

instance ModuleSym JavaCode where
  type Module JavaCode = ModData
  buildModule n _ = G.buildModule' n 

  moduleName m = name (unJC m)
  
instance InternalMod JavaCode where
  isMainModule = isMainMod . unJC
  moduleDoc = modDoc . unJC
  modFromData n m d = return $ md n m d

instance BlockCommentSym JavaCode where
  type BlockComment JavaCode = Doc
  blockComment lns = liftA2 (blockCmtDoc lns) blockCommentStart blockCommentEnd
  docComment lns = liftA2 (docCmtDoc lns) docCommentStart docCommentEnd 

  blockCommentDoc = unJC

jName :: String
jName = "Java"

jtop :: Doc -> Doc -> Doc -> Doc
jtop end inc lst = vcat [
  inc <+> text "java.util.Arrays" <> end,
  inc <+> text "java.util.BitSet" <> end, --TODO: only include these if they are used in the code?
  inc <+> text "java.util.Scanner" <> end,
  inc <+> text "java.io.PrintWriter" <> end,
  inc <+> text "java.io.FileWriter" <> end,
  inc <+> text "java.io.File" <> end,
  inc <+> text ("java.util." ++ render lst) <> end]

jFloatTypeDocD :: TypedType Other
jFloatTypeDocD = td Float "double" (text "double")

jStringTypeDoc :: TypedType Other
jStringTypeDoc = td String "String" (text "String")

jInfileTypeDoc :: TypedType Other
jInfileTypeDoc = td File "Scanner" (text "Scanner")

jOutfileTypeDoc :: TypedType Other
jOutfileTypeDoc = td File "PrintWriter" (text "PrintWriter")

jListType :: TypedType a -> Doc -> TypedType [a]
jListType t@(OT (TD Integer _ _)) lst = ltd t (P.const (render lst ++ 
  "<Integer>")) (P.const (lst <> angles (text "Integer")))
jListType t@(OT (TD Float _ _)) lst = ltd t (P.const (render lst ++ 
  "<Double>")) (P.const (lst <> angles (text "Double")))
jListType t lst = listTypeDocD t lst

jArrayType :: JavaCode (Type JavaCode Other)
jArrayType = return $ td (List $ Object "Object") "Object" (text "Object[]")

jEquality :: JavaCode (Value JavaCode a) -> JavaCode (Value JavaCode a) 
  -> JavaCode (Value JavaCode Boolean)
jEquality v1 v2 = jEquality' (getType $ valueType v2)
  where jEquality' String = objAccess v1 (func "equals" bool [fmap toOtherVal v2])
        jEquality' _ = liftA4 typeBinExpr equalOp bool v1 v2

jCast :: JavaCode (Type JavaCode a) -> JavaCode (Value JavaCode b) -> 
  JavaCode (Value JavaCode a)
jCast t v = jCast' (unJC t) (getType $ valueType v)
  where jCast' (OT (TD Float _ _)) String = funcApp "Double.parseDouble" 
          float [fmap toOtherVal v]
        jCast' (OT (TD Integer _ _)) (Enum _) = v $. func "ordinal" int []
        jCast' _ _ = liftA2 mkVal t $ liftA2 castObjDocD (fmap castDocD t) v

jListDecDef :: (RenderSym repr) => repr (Variable repr [a]) -> 
  [repr (Value repr a)] -> Doc
jListDecDef v vs = space <> equals <+> new <+> getTypeDoc (variableType v) <+> 
  parens listElements
  where listElements = emptyIfNull vs $ text "Arrays.asList" <> parens 
          (valueList vs)

jConstDecDef :: TypedVar a -> TypedValue a -> Doc
jConstDecDef v def = text "final" <+> tpDoc (varType v) <+> varDoc v <+> 
  equals <+> valDoc def

jThrowDoc :: (RenderSym repr) => repr (Value repr Other) -> Doc
jThrowDoc errMsg = text "throw new" <+> text "Exception" <> parens (valueDoc 
  errMsg)

jTryCatch :: (RenderSym repr) => repr (Body repr) -> repr (Body repr) -> Doc
jTryCatch tb cb = vcat [
  text "try" <+> lbrace,
  indent $ bodyDoc tb,
  rbrace <+> text "catch" <+> parens (text "Exception" <+> text "exc") <+> 
    lbrace,
  indent $ bodyDoc cb,
  rbrace]

jOut :: Bool -> JavaCode (Value JavaCode Other) -> 
  JavaCode (Value JavaCode a) -> Maybe (JavaCode (Value JavaCode Other)) -> 
  JavaCode (Statement JavaCode)
jOut newLn printFn v f = jOut' (getTypedVal v)
  where jOut' lv@(LV _) = printListDoc (getNestDegree 1 (cType $ valToType lv)) 
          (return lv) (prFn f) (prStrFn f) (prLnFn newLn f)
        jOut' _ = outDoc newLn printFn v f

jDiscardInput :: (RenderSym repr) => repr (Value repr Other) -> Doc
jDiscardInput inFn = valueDoc inFn <> dot <> text "next()"

jInput :: TypedType a -> TypedValue Other -> TypedValue a
jInput t inFn = mkVal t $ jInput' (cType t) 
  where jInput' Integer = text "Integer.parseInt" <> parens (valDoc inFn <> 
          dot <> text "nextLine()")
        jInput' Float = text "Double.parseDouble" <> parens (valDoc inFn <> 
          dot <> text "nextLine()")
        jInput' Boolean = valDoc inFn <> dot <> text "nextBoolean()"
        jInput' String = valDoc inFn <> dot <> text "nextLine()"
        jInput' Char = valDoc inFn <> dot <> text "next().charAt(0)"
        jInput' _ = error "Attempt to read value of unreadable type"

jOpenFileR :: (RenderSym repr) => repr (Value repr Other) -> 
  repr (Type repr Other) -> repr (Value repr Other)
jOpenFileR n t = valFromData Nothing t $ new <+> text "Scanner" <> parens 
  (new <+> text "File" <> parens (valueDoc n))

jOpenFileWorA :: (RenderSym repr) => repr (Value repr Other) -> 
  repr (Type repr Other) -> repr (Value repr Boolean) -> repr (Value repr Other)
jOpenFileWorA n t wa = valFromData Nothing t $ new <+> text "PrintWriter" <> 
  parens (new <+> text "FileWriter" <> parens (new <+> text "File" <> 
  parens (valueDoc n) <> comma <+> valueDoc wa))

jStringSplit :: TypedVar [Other] -> TypedValue [Other] -> Doc
jStringSplit vnew s = varDoc vnew <+> equals <+> new <+> tpDoc (varType vnew)
  <> parens (valDoc s)

jMethod :: Label -> Doc -> Doc -> TypedType a -> Doc -> Doc -> Doc
jMethod n s p t ps b = vcat [
  s <+> p <+> typeDoc t <+> text n <> parens ps <+> text "throws Exception" <+> 
    lbrace,
  indent b,
  rbrace]

jAssignFromArray :: Int -> [JavaCode (Variable JavaCode Other)] -> 
  [JavaCode (Statement JavaCode)]
jAssignFromArray _ [] = []
jAssignFromArray c (v:vs) = (v &= cast (variableType v)
  (valueOf (var ("outputs[" ++ show c ++ "]") (variableType v))))
  : jAssignFromArray (c+1) vs

jInOutCall :: (Label -> JavaCode (Type JavaCode Other) -> 
  [JavaCode (Value JavaCode Other)] -> JavaCode (Value JavaCode Other)) -> Label -> 
  [JavaCode (Value JavaCode Other)] -> [JavaCode (Variable JavaCode Other)] -> 
  [JavaCode (Variable JavaCode Other)] -> JavaCode (Statement JavaCode)
jInOutCall f n ins [] [] = valState $ f n void ins
jInOutCall f n ins [out] [] = assign out $ f n (variableType out) ins
jInOutCall f n ins [] [out] = if null (filterOutObjs [out])
  then valState $ f n void (valueOf out : ins) 
  else assign out $ f n (variableType out) (valueOf out : ins)
jInOutCall f n ins outs both = fCall rets
  where rets = filterOutObjs both ++ outs
        fCall [x] = assign x $ f n (variableType x) (map valueOf both ++ ins)
        fCall xs = multi $ varDecDef (var "outputs" jArrayType) 
          (f n jArrayType (map valueOf both ++ ins)) : jAssignFromArray 0 xs
