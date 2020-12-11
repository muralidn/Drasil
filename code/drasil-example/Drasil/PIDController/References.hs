module Drasil.PIDController.References where

import Language.Drasil
import Data.Drasil.Citations (smithLai2005)

citations :: BibRef
citations = [pidWiki, laplaceWiki, johnson2008, abbasi2015, smithLai2005]

pidWiki, johnson2008, abbasi2015, laplaceWiki :: Citation

laplaceWiki
  = cMisc
      [author [mononym "Wikipedia Contributors"], title "Laplace transform",
       howPublishedU "https://en.wikipedia.org/wiki/Laplace_transform",
       month Nov, year 2020]
      "laplaceWiki"

pidWiki
  = cMisc
      [author [mononym "Wikipedia Contributors"], title "PID controller",
       howPublishedU "https://en.wikipedia.org/wiki/PID_controller", month Oct,
       year 2020]
      "pidWiki"

pidCtrlEditor1, pidCtrlEditor2 :: Person
pidCtrlEditor1 = personWM "Michael" ["A"] "Johnson"
pidCtrlEditor2 = personWM "Mohammad" ["H"] "Moradi"

johnson2008
  = cBookA [pidCtrlEditor1, pidCtrlEditor2]
      "PID Control: New Identification and Design Methods, Chapter 1"
      "Springer Science and Business Media"
      2006
      []
      "johnson2008"

abbasi2015
  = cMisc
      [author [mononym "Nasser M. Abbasi"],
       title "A diﬀerential equation view of closed loop control systems"     ,
       howPublishedU
         "https://www.12000.org/my_notes/connecting_systems/report.htm",
       month Nov, year 2020]
      "abbasi2015"

