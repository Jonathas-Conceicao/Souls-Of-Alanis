## On 21.05.18

### Base Classes
```
Attributes {
  vit
  for
  agi
  wis

  increment()
  calcPowers()
}

Powers {
  hp
  stamina
  carryLoad
  Defense
}

Attack {
  type {slash impact thrust}
  damage
}

Defense {
  slash
  impact
  thrust
}
```
### Mother Classes
```
Character has Node{
  name
  hitbox
  animatedSprite
}

Item {
  name
  sprite
}
```
#### Character
```
Foe {
  Attributes
  Powers
  ai
  Armor
  Ring

  attack()
  takeDamege()
}

Ally {
  quest
}

Player {
  Attributes
  Powers
  trails
  Weapon
  Armor
  Ring

  attack()
  takeDamege()
}
```
#### Item
```
Weapon {
  Attack
  weith
}

Armor {
  Defense
  weith
}

Ring {
  Powers
}

Bonus {
  Powers
  Durations
}

PowerUP {
  Powers
}

```

