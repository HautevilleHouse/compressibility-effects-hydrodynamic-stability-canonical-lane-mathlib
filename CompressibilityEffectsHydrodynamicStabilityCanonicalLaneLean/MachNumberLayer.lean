import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic
import HautevilleHouse.CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean.CompressibleFlowOperators

namespace HautevilleHouse
namespace CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean

open CompressibleFlowOperators

structure MachNumberCertificate where
  flow : CompressibleFlow
  machNumber : ℝ
  subsonic : Prop
  transonic : Prop
  supersonic : Prop
  machNumberPositive : machNumber > 0
  subsonicClosed : subsonic
  transonicClosed : transonic
  supersonicClosed : supersonic

def sourceMachNumberCertificate : MachNumberCertificate := {
  flow := primitiveCompressibleFlow
  machNumber := 0.8
  subsonic := 0.8 < 1
  transonic := 0.8 = 1
  supersonic := 0.8 > 1
  machNumberPositive := by norm_num
  subsonicClosed := by norm_num
  transonicClosed := by norm_num
  supersonicClosed := by norm_num
}

def MachNumberClosed (C : MachNumberCertificate) : Prop :=
  CompressibleFlowClosed C.flow ∧
  C.subsonic ∧
  C.transonic ∧
  C.supersonic

theorem source_mach_number_closed :
    MachNumberClosed sourceMachNumberCertificate := by
  exact And.intro primitive_flow_closed_checked
    (And.intro sourceMachNumberCertificate.subsonicClosed
      (And.intro sourceMachNumberCertificate.transonicClosed
        sourceMachNumberCertificate.supersonicClosed))

end CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean
end HautevilleHouse
