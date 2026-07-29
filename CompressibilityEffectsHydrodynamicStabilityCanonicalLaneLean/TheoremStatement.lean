import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean

structure TheoremStatement where
  sourceKey : String
  theoremName : String
  theoremObject : String
  classicalBoundary : String
  manifoldConstrainedStatement : String
  certificateLane : String
  carriedRemainder : String

deriving Repr, DecidableEq

def sourceRepository : String := "compressibility-effects-hydrodynamic-stability-canonical-lane"
def sourceDescription : String := "Compressibility Effects on Hydrodynamic Stability"

end CompressibilityEffectsHydrodynamicStabilityCanonicalLaneLean
end HautevilleHouse