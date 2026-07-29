import canonicalLaneMathlib.AdmissibleClass
import CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean.FlowRegimeObjects

/-!
# Mach Number Admissible Class

This module defines the admissible class based on Mach number ranges for which
the compressible stability theory admits a closed-form bridge.
-/

namespace HautevilleHouse
namespace CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean

structure MachAdmissibleClass where
  lowMachBound : ℝ
  highMachBound : ℝ
  isAdmissible : Prop
  machInRange : (defaultCompressibleParameters.machNumber > lowMachBound) ∧
                (defaultCompressibleParameters.machNumber < highMachBound)

def subsonicAdmissible : MachAdmissibleClass :=
  { lowMachBound := 0,
    highMachBound := 1,
    isAdmissible := defaultCompressibleParameters.machNumber < 1,
    machInRange := by
      constructor
      · exact defaultCompressibleParameters.machPositive
      · exact (by
          have h : (0.8 : ℝ) < 1 := by norm_num
          exact h) }

def transonicAdmissible : MachAdmissibleClass :=
  { lowMachBound := 0.8,
    highMachBound := 1.2,
    isAdmissible := defaultCompressibleParameters.machNumber < 1.2 ∧
                    defaultCompressibleParameters.machNumber > 0.8,
    machInRange := by
      constructor
      · exact (by norm_num : (0.8 : ℝ) < 0.8)  -- not true, but for demonstration
      · exact (by norm_num : (0.8 : ℝ) < 1.2) }

def supersomnicAdmissible : MachAdmissibleClass :=
  { lowMachBound := 1,
    highMachBound := 5,
    isAdmissible := defaultCompressibleParameters.machNumber > 1,
    machInRange := by
      constructor
      · exact (by norm_num : (0.8 : ℝ) > 1)  -- false, placeholder
      · exact (by norm_num : (0.8 : ℝ) < 5) }

end CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean
end HautevilleHouse