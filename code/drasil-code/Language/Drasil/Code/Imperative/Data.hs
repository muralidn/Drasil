module Language.Drasil.Code.Imperative.Data (Pair(..), pairList,
  Terminator (..), ScopeTag(..), FuncData(..), fd, ModData(..), md, 
  MethodData(..), mthd, ParamData(..), pd, updateParamDoc, StateVarData(..), 
  svd, TypeData(..), td, ValData(..), vd, updateValDoc
) where

import Language.Drasil.Code.Code (CodeType)

import Prelude hiding ((<>))
import Text.PrettyPrint.HughesPJ (Doc)

class Pair p where
  pfst :: p x y a -> x a
  psnd :: p x y b -> y b
  pair :: x a -> y a -> p x y a

pairList :: (Pair p) => [x a] -> [y a] -> [p x y a]
pairList [] _ = []
pairList _ [] = []
pairList (x:xs) (y:ys) = pair x y : pairList xs ys
 
data Terminator = Semi | Empty

data ScopeTag = Pub | Priv deriving Eq

data FuncData = FD {funcType :: TypeData, funcDoc :: Doc}

fd :: TypeData -> Doc -> FuncData
fd = FD

data ModData = MD {name :: String, isMainMod :: Bool, modDoc :: Doc}

md :: String -> Bool -> Doc -> ModData
md = MD

data MethodData = MthD {isMainMthd :: Bool, mthdParams :: [ParamData], 
  mthdDoc :: Doc}

mthd :: Bool -> [ParamData] -> Doc -> MethodData
mthd = MthD 

data ParamData = PD {paramName :: String, paramType :: TypeData, 
  paramDoc :: Doc} deriving Eq

pd :: String -> TypeData -> Doc -> ParamData
pd = PD 

updateParamDoc :: (Doc -> Doc) -> ParamData -> ParamData
updateParamDoc f v = pd (paramName v) (paramType v) ((f . paramDoc) v)

data StateVarData = SVD {getStVarScp :: ScopeTag, stVarDoc :: Doc, 
  destructSts :: (Doc, Terminator)}

svd :: ScopeTag -> Doc -> (Doc, Terminator) -> StateVarData
svd = SVD

data TypeData = TD {cType :: CodeType, typeDoc :: Doc} deriving Eq

td :: CodeType -> Doc -> TypeData
td = TD

-- Maybe String is the String representation of the value
data ValData = VD {valName :: Maybe String, valType :: TypeData, valDoc :: Doc}
  deriving Eq

vd :: Maybe String -> TypeData -> Doc -> ValData
vd = VD

updateValDoc :: (Doc -> Doc) -> ValData -> ValData
updateValDoc f v = vd (valName v) (valType v) ((f . valDoc) v)