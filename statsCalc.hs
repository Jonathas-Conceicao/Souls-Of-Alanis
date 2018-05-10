data Atributes = Att {
  vit :: Int,
  agi :: Int,
  for :: Int,
  int :: Int
  } deriving (Eq, Show)

data Combat = Comb {
  slash  :: Int,
  impact :: Int,
  thrust :: Int
  } deriving (Eq, Show)

data BaseStats = Stt {
  hp         :: Int,
  stamina    :: Int,
  equip_load :: Int,
  attack     :: Combat,
  defense    :: Combat
  } deriving (Eq, Show)

combat :: Atributes -> (Combat, Combat)
combat attributes = (atk, def)
  where
    atk = (Comb aSlash aImpact aThrust)
    def = (Comb dSlash dImpact dThrust)
    (aSlash , dSlash ) = slashAD  attributes
    (aImpact, dImpact) = impactAD attributes
    (aThrust, dThrust) = thrustAD  attributes

slashAD  :: Atributes -> (Int, Int)
slashAD  (Att vit agi for _) = (agi + agi, vit + agi + for)
impactAD :: Atributes -> (Int, Int)
impactAD (Att vit agi for _) = (for + for, vit + for + for)
thrustAD :: Atributes -> (Int, Int)
thrustAD (Att vit agi for _) = (agi + for, vit + agi + agi)
