import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic

/-!
# Compressible Flow Objects

This module provides a local analytic vocabulary for compressible hydrodynamic stability:
base state, fluctuations, Mach number, density fields, and the primitive compressible
Navier-Stokes operators.
-/

namespace HautevilleHouse
namespace CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

structure CompressibleFlowState where
  density : ScalarField
  velocity : VectorField
  pressure : ScalarField
  temperature : ScalarField

def uniformBaseState (ρ0 p0 T0 : ℝ) : CompressibleFlowState :=
  { density := fun _ _ => ρ0
    velocity := zeroVectorField
    pressure := fun _ _ => p0
    temperature := fun _ _ => T0 }

structure CompressibleOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  laplacian : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  convectiveDerivative : VectorField → VectorField → VectorField
  pressureProjection : VectorField → VectorField
  pressureProjectionIdempotent : ∀ u, pressureProjection (pressureProjection u) = pressureProjection u
  machNumber : ℝ
  specificHeatRatio : ℝ

def primitiveCompressibleOperators (M γ : ℝ) : CompressibleOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  laplacian := fun u => u
  timeDerivative := fun _ => zeroVectorField
  convectiveDerivative := fun _ _ => zeroVectorField
  pressureProjection := fun u => u
  pressureProjectionIdempotent := by intro u; rfl
  machNumber := M
  specificHeatRatio := γ
}

structure CompressibleFlow where
  baseState : CompressibleFlowState
  fluctuation : CompressibleFlowState
  operators : CompressibleOperators
  viscosity : ℝ
  thermalConductivity : ℝ

def primitiveCompressibleFlow (M γ : ℝ) : CompressibleFlow := {
  baseState := uniformBaseState 1 1 1
  fluctuation := { density := zeroScalarField, velocity := zeroVectorField, pressure := zeroScalarField, temperature := zeroScalarField }
  operators := primitiveCompressibleOperators M γ
  viscosity := 1
  thermalConductivity := 1
}

end HautevilleHouse.CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean
end HautevilleHouse
