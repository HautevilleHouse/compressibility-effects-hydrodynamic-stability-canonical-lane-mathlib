import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic

/-!
# Flow Regime Objects for Compressibility Effects on Hydrodynamic Stability

This module defines the basic analytic objects needed to discuss compressible
hydrodynamic stability: base flows, perturbations, stability operators,
and compressibility parameters.
-/

namespace HautevilleHouse
namespace CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

structure CompressibleStabilityParameters where
  machNumber : ℝ
  reynoldsNumber : ℝ
  prandtlNumber : ℝ
  specificHeatRatio : ℝ
  viscosityExponent : ℝ
  machPositive : machNumber > 0
  reynoldsPositive : reynoldsNumber > 0

def defaultCompressibleParameters : CompressibleStabilityParameters :=
  { machNumber := 0.8,
    reynoldsNumber := 1000,
    prandtlNumber := 0.72,
    specificHeatRatio := 1.4,
    viscosityExponent := 0.76,
    machPositive := by norm_num,
    reynoldsPositive := by norm_num }

structure BaseFlow where
  velocity : VectorField
  density : ScalarField
  temperature : ScalarField
  pressure : ScalarField

def zeroBaseFlow : BaseFlow :=
  { velocity := fun _ _ _ => 0,
    density := fun _ _ => 0,
    temperature := fun _ _ => 0,
    pressure := fun _ _ => 0 }

structure Perturbation where
  velocity : VectorField
  density : ScalarField
  temperature : ScalarField
  pressure : ScalarField

def zeroPerturbation : Perturbation :=
  { velocity := fun _ _ _ => 0,
    density := fun _ _ => 0,
    temperature := fun _ _ => 0,
    pressure := fun _ _ => 0 }

structure StabilityOperator where
  linearizedNS : (Perturbation → Perturbation)  -- linearized Navier-Stokes
  compressibilityCorrection : (Perturbation → Perturbation)
  operatorClosed : Prop

def trivialOperator : StabilityOperator :=
  { linearizedNS := fun _ => zeroPerturbation,
    compressibilityCorrection := fun _ => zeroPerturbation,
    operatorClosed := True }

end CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean
end HautevilleHouse