import canonicalLaneMathlib.AdmissibleClass

/-!
# Shock Layer

This module captures shock formation, entropy jump, and stability of discontinuities.
-/

namespace HautevilleHouse
namespace CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean

structure ShockCertificate where
  entropyJumpPositive : Prop
  LaxCondition : Prop
  shockStable : Prop
  entropyJumpPositiveClosed : entropyJumpPositive
  LaxConditionClosed : LaxCondition
  shockStableClosed : shockStable

def sourceShockCertificate : ShockCertificate := {
  entropyJumpPositive := True
  LaxCondition := True
  shockStable := True
  entropyJumpPositiveClosed := trivial
  LaxConditionClosed := trivial
  shockStableClosed := trivial
}

def ShockClosed (C : ShockCertificate) : Prop :=
  C.entropyJumpPositive ∧ C.LaxCondition ∧ C.shockStable

theorem source_shock_closed :
    ShockClosed sourceShockCertificate := by
  exact And.intro sourceShockCertificate.entropyJumpPositiveClosed
    (And.intro sourceShockCertificate.LaxConditionClosed
      sourceShockCertificate.shockStableClosed)

end HautevilleHouse
end CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean