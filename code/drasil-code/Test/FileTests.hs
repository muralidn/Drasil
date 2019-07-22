module Test.FileTests (fileTests) where

import Language.Drasil.Code (PackageSym(..), RenderSym(..), PermanenceSym(..),
  BodySym(..), BlockSym(..), StateTypeSym(..), StatementSym(..), 
  ControlStatementSym(..), VariableSym(..), ValueSym(..), Selector(..),
  MethodSym(..), ModuleSym(..))
import Prelude hiding (return,print,log,exp,sin,cos,tan)

fileTests :: (PackageSym repr) => repr (Package repr)
fileTests = packMods "FileTests" [fileDoc (buildModule "FileTests" [] [fileTestMethod] [])]

fileTestMethod :: (RenderSym repr) => repr (Method repr)
fileTestMethod = mainMethod "FileTests" (body [writeStory, block [readStory], 
  goodBye])

writeStory :: (RenderSym repr) => repr (Block repr)
writeStory = block [
  varDecDef (var "e" int) (litInt 5),
  varDec $ var "f" float,
  var "f" float &= cast float (valueOf $ var "e" int),
  varDec $ var "fileToWrite" outfile,

  openFileW (var "fileToWrite" outfile) (litString "testText.txt"),
  printFile (valueOf $ var "fileToWrite" outfile) (litInt 0),
  printFileLn (valueOf $ var "fileToWrite" outfile) (litFloat 0.89),
  printFileStr (valueOf $ var "fileToWrite" outfile) "ello",
  printFileStrLn (valueOf $ var "fileToWrite" outfile) "bye",
  printFileStrLn (valueOf $ var "fileToWrite" outfile) "!!",
  closeFile (valueOf $ var "fileToWrite" outfile),

  varDec $ var "fileToRead" infile,
  openFileR (var "fileToRead" infile) (litString "testText.txt"),
  varDec $ var "fileLine" string,
  getFileInputLine (valueOf $ var "fileToRead" infile) (var "fileLine" string),
  discardFileLine (valueOf $ var "fileToRead" infile),
  listDec 0 (var "fileContents" (listType dynamic_ string))]

readStory :: (RenderSym repr) => repr (Statement repr)
readStory = getFileInputAll (valueOf $ var "fileToRead" infile) 
  (var "fileContents" (listType dynamic_ string))

goodBye :: (RenderSym repr) => repr (Block repr)
goodBye = block [
  printLn (valueOf $ var "fileContents" (listType dynamic_ string)), 
  closeFile (valueOf $ var "fileToRead" infile)]