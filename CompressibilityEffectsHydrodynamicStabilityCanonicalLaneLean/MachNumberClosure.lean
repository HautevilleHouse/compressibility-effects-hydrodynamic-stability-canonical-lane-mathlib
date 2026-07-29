import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean.LinearStabilityLayer

/-!
# Mach Number Closure Layer

This module defines the closure gate for compressibility effects: the Mach number
determines the admissible regime where compressibility can be treated as a perturbation.
-/

namespace HautevilleHouse
namespace CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean

def subsonicRegime (M : ℝ) : Prop := M < 1
def transonicRegime (M : ℝ) : Prop := M = 1
def supersonicRegime (M : ℝ) : Prop := M > 1

structure MachNumberCertificate where
  machNumber : ℝ
  linearStability : LinearStabilityCertificate
  subsonicClosure : Prop
  subsonicClosureProof : subsonicClosure

def sourceMachNumberCertificate (M γ : ℝ) (hMpos : M > 0) (hMlt1 : M < 1) : MachNumberCertificate := {
  machNumber := M
  linearStability := sourceLinearStabilityCertificate M γ
  subsonicClosure := subsonicRegime M
  subsonicClosureProof := hMlt1
}

def MachNumberClosure (C : MachNumberCertificate) : Prop :=
  LinearStabilityClosed C.linearStability ∧ C.subsonicClosure

theorem source_mach_number_closed (M γ : ℝ) (hMpos : M > 0) (hMlt1 : M < 1) :
    MachNumberClosure (sourceMachNumberCertificate M γ hMpos hMlt1) := by
  unfold MachNumberClosure sourceMachNumberCertificate
  apply And.intro
  · exact source_linear_stability_closed M γ hMpos hMlt1
  · exact hMlt1

end HautevilleHouse.CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean
end HautevilleHouse
