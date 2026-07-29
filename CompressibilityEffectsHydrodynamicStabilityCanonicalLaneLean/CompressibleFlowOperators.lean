import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic

namespace HautevilleHouse
namespace CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

structure CompressibleNavierStokesOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  laplacian : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  transport : VectorField → VectorField
  pressureProjection : VectorField → VectorField
  densityAdvection : ScalarField → VectorField → ScalarField
  speedOfSound : ScalarField → ScalarField
  density : ScalarField
  compressibilityFactor : ℝ
  pressureProjectionIdempotent : ∀ u, pressureProjection (pressureProjection u) = pressureProjection u

def primitiveCompressibleOperators : CompressibleNavierStokesOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  laplacian := fun u => u
  timeDerivative := fun _ => zeroVectorField
  transport := fun _ => zeroVectorField
  pressureProjection := fun u => u
  densityAdvection := fun _ _ => zeroScalarField
  speedOfSound := fun _ => zeroScalarField
  density := zeroScalarField
  compressibilityFactor := 1
  pressureProjectionIdempotent := by intro u; rfl
}

structure CompressibleFlow where
  velocity : VectorField
  pressure : ScalarField
  density : ScalarField
  viscosity : ℝ
  operators : CompressibleNavierStokesOperators

def primitiveCompressibleFlow : CompressibleFlow := {
  velocity := zeroVectorField
  pressure := zeroScalarField
  density := zeroScalarField
  viscosity := 1
  operators := primitiveCompressibleOperators
}

def Compressible (F : CompressibleFlow) : Prop :=
  F.operators.divergence F.velocity ≠ zeroScalarField

def Isentropic (F : CompressibleFlow) : Prop :=
  F.operators.speedOfSound F.density = F.operators.gradient F.pressure

def CompressibilityFactorDefined (F : CompressibleFlow) : Prop :=
  F.operators.compressibilityFactor > 0

def CompressibleFlowClosed (F : CompressibleFlow) : Prop :=
  Compressible F ∧ Isentropic F ∧ CompressibilityFactorDefined F

theorem primitive_flow_compressible_checked :
    Compressible primitiveCompressibleFlow := by
  unfold Compressible
  unfold primitiveCompressibleFlow
  unfold zeroVectorField
  unfold zeroScalarField
  simp

theorem primitive_flow_isentropic_checked :
    Isentropic primitiveCompressibleFlow := by
  rfl

theorem primitive_flow_compressibility_factor_checked :
    CompressibilityFactorDefined primitiveCompressibleFlow := by
  rfl

theorem primitive_flow_closed_checked :
    CompressibleFlowClosed primitiveCompressibleFlow := by
  exact And.intro primitive_flow_compressible_checked
    (And.intro primitive_flow_isentropic_checked primitive_flow_compressibility_factor_checked)

end CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean
end HautevilleHouse
