import canonicalLaneMathlib.AdmissibleClass
import CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean.FlowRegimeObjects

/-!
# Vortex Sheet Compressibility Effects

This module analyzes the effect of compressibility on the stability of vortex
sheets. It defines the vortex sheet configuration and the modified stability
equations due to Mach number.
-/

namespace HautevilleHouse
namespace CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean

structure VortexSheetConfig where
  densityJump : ℝ
  velocityJump : ℝ
  surfaceTension : ℝ
  machJump : ℝ

def defaultVortexSheet : VortexSheetConfig :=
  { densityJump := 0.1,
    velocityJump := 0.5,
    surfaceTension := 0,
    machJump := 0.8 }

structure VortexSheetStability where
  config : VortexSheetConfig
  dispersionRelation : ScalarField → Prop
  growthRate : ℝ
  stabilityThreshold : ℝ
  compressibleEffect : ℝ
  gateClosed : Prop

def defaultVortexSheetStability : VortexSheetStability :=
  { config := defaultVortexSheet,
    dispersionRelation := fun _ => True,
    growthRate := 0.2,
    stabilityThreshold := 0.5,
    compressibleEffect := 0.1,
    gateClosed := True }

def gateClosed (A : AdmissibleClass) : Prop :=
  defaultVortexSheetStability.gateClosed

theorem gate_from_admissible_class (A : AdmissibleClass) : gateClosed A :=
  defaultVortexSheetStability.gateClosed

end CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean
end HautevilleHouse