module Drasil.SWHS.Labels where

import Language.Drasil

-- Assumptions
thermalEnergyOnlyL, lawConvectiveCoolingWtrPCML, waterAlwaysLiquidL, 
    noGaseousStatePCML, atmosphericPressureTankL :: Label
heatTransferCoeffL, contantWaterTempL, tempPcmConsL, densityWaterL, specificHeatL,
  newtoLawConvecL, tempOverTimeL, tempOverLengthL, chargeTankL, sameInitialL,
  pcmInitialSolidL, perfectInsulationL, noInternalHeatL, volumeChangeMeltL, volumeCoilL :: Label
thermalEnergyOnlyL          = mkLabelRAAssump' "Thermal-Energy-Only"
heatTransferCoeffL          = mkLabelRAAssump' "Heat-Transfer-Coeffs-Constant"
contantWaterTempL           = mkLabelRAAssump' "Constant-Water-Temp-Across-Tank"
tempPcmConsL                = mkLabelRAAssump' "Temp-PCM-Constant-Across-Volume"
densityWaterL               = mkLabelRAAssump' "Density-Water-PCM-Constant-over-Volume"
specificHeatL               = mkLabelRAAssump' "Specific-Heat-Energy-Constant-over-Volume"
newtoLawConvecL             = mkLabelRAAssump' "Newton-Law-Convective-Cooling-Coil-Water"
tempOverTimeL               = mkLabelRAAssump' "Temp-Heating-Coil-Constant-over-Time"
tempOverLengthL             = mkLabelRAAssump' "Temp-Heating-Coil-Constant-over-Length"
lawConvectiveCoolingWtrPCML = mkLabelRAAssump' "Law-Convective-Cooling-Water-PCM"
chargeTankL                 = mkLabelRAAssump' "Charging-Tank-No-Temp-Discharge"
sameInitialL                = mkLabelRAAssump' "Same-Initial-Temp-Water-PCM"
pcmInitialSolidL            = mkLabelRAAssump' "PCM-Initially-Solid"
waterAlwaysLiquidL          = mkLabelRAAssump' "Water-Always-Liquid"
perfectInsulationL          = mkLabelRAAssump' "Perfect-Insulation-Tank"
noInternalHeatL             = mkLabelRAAssump' "No-Internal-Heat-Generation-By-Water-PCM"
volumeChangeMeltL           = mkLabelRAAssump' "Volume-Change-Melting-PCM-Negligible"
noGaseousStatePCML          = mkLabelRAAssump' "No-Gaseous-State-PCM"
atmosphericPressureTankL    = mkLabelRAAssump' "Atmospheric-Pressure-Tank"
volumeCoilL                  = mkLabelRAAssump' "Volume-Coil-Negligible"

-- Data Definition
dd1HtFluxCL, dd2HtFluxPL, dd3HtFusionL, dd4MeltFracL :: Label
dd1HtFluxCL = mkLabelSame "ht_flux_C" (Def DD)
dd2HtFluxPL = mkLabelSame "ht_flux_P" (Def DD)
dd3HtFusionL = mkLabelSame "htFusion" (Def DD)
dd4MeltFracL = mkLabelSame "melt_frac" (Def DD)

-- General Definitions
nwtnCoolingL, rocTempSimpL :: Label
nwtnCoolingL = mkLabelSame "nwtnCooling" (Def General)
rocTempSimpL = mkLabelSame "rocTempSimp" (Def General)

-- Instance Models
eBalanceOnWtrL, eBalanceOnPCML, heatEInWtrL, heatEInPCML :: Label
eBalanceOnWtrL = mkLabelSame "eBalanceOnWtr" (Def Instance)
eBalanceOnPCML = mkLabelSame "eBalanceOnPCM" (Def Instance)
heatEInWtrL    = mkLabelSame "heatEInWtr"    (Def Instance)
heatEInPCML    = mkLabelSame "heatEInPCM"    (Def Instance)

-- Table
inputInitQuantsLbl :: Label
inputInitQuantsLbl = mkLabelSame "Input-Variable-Requirements" Tab
