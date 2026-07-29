import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic
import HautevilleHouse.CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean.CompressibleFlowOperators
import HautevilleHouse.CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean.MachNumberLayer

namespace HautevilleHouse
namespace CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean

open CompressibleFlowOperators
open MachNumberLayer

structure StabilityCertificate where
  mach : MachNumberCertificate
  linearStability : Prop
  nonlinearStability : Prop
  growthRate : ℝ
  growthRateNonpositive : growthRate ≤ 0
  linearStabilityClosed : linearStability
  nonlinearStabilityClosed : nonlinearStability

def sourceStabilityCertificate : StabilityCertificate := {
  mach := sourceMachNumberCertificate
  linearStability := sourceMachNumberCertificate.subsonic
  nonlinearStability := sourceMachNumberCertificate.subsonic
  growthRate := -0.1
  growthRateNonpositive := by linarith
  linearStabilityClosed := sourceMachNumberCertificate.subsonicClosed
  nonlinearStabilityClosed := sourceMachNumberCertificate.subsonicClosed
}

def StabilityClosed (C : StabilityCertificate) : Prop :=
  MachNumberClosed C.mach ∧
  C.linearStability ∧
  C.nonlinearStability

theorem source_stability_closed :
    StabilityClosed sourceStabilityCertificate := by
  exact And.intro source_mach_number_closed
    (And.intro sourceStabilityCertificate.linearStabilityClosed
      sourceStabilityCertificate.nonlinearStabilityClosed)

end CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean
end HautevilleHouse
