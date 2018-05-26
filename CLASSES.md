## Classes of the for the RPG Model

A ~sort of~ documentation for the classes for the RPG model implemented using the GDScript

### Base Classes
```
Attributes {
	var vitality
	var strength
	var agility
	var wisdom

	var update = 0 // Usado para lvl up em círculo

	var power // Instancia da classe Power

	func _init(v = 1, s = 1, a = 1, w = 1) // Construtor

	func increment(n=1)        // Metodo para lvl up em circulo
	func updatePower()         // Metodo usado para atualizar os valores da instancia de poder da classe
	func genAttack(attackType) // Retorna uma nova instancia de Attack baseada nos atributos do personagem
	func takeDamage(damage)    // Causa _damage_ de dano ao HP
	func influence(v, s, a, w) // Usado internamente para multiplicação dos atributos pelo valor apropriado
}

Powers {
	var hp        // HP total
	var stamina   // Stamina total
	var carryLoad // Capacidade de carga total
	var xp_gain   // Multiplicador de experiência
	
	var cur_hp        // HP atual
	var cur_stamina   // Stamina atual
	var cur_carryLoad // Capacidade de carga atual

	var defense // Instancia da classe Defense

	func _init() // Construtor

	func takeDamage(damage) // Causa _damage_ ao HP atual (cur_hp)
}

Attack {
	enum AttackType {Slash, Impact, Thrust} // Possíveis tipos de ataque

	var type   // Tipo do ataque
	var damage // Dano do ataque

	func _init(type = Slash, damage = 0) // Construtor

	func add(attack) // Soma o dano do ataque atual ao dano de outro ataque do mesmo tipo
	func sum(attack) // Retorna um novo ataque que é a soma deste com um outro
}

Defense {
	var slash  // Defensa contra ataques do tipo Slash
	var impact // Defensa contra ataques do tipo Impact
	var thrust // Defensa contra ataques do tipo Thrust

	func _init(s = 0, i = 0, t = 0) // Construtor

	func add(defense) // Soma as defesas atuais à defesa de outra Defense
	func sum(defense) // Retorna uma nova instancia de Defense que é a soma deste com uma outra

	func calcCombat(attack) // Calcula o dano que o ataque causa contra essa defesa
}

Trails { // Not implemented yet
}
```
### Characters
```
Foe {
	var attributes // Atributos da criatura
	var armor      // Armadura que a criatura usa (pode ser null)
	var ring       // Anel que a criatura usa (pode ser null)
	var attackType // Tipo de ataque da criatura

	func _init(at = Attack.Slash) // Construtor

	func setArmor(armor) // Coloca uma nova armadura na criatura e da um queue_free na armadura antiga (se houver)
	func setRing(ring)   // Coloca um novo anel na criatura e da um queue_free no anel antigo (se houver)
	func getDefense()    // Gera uma nova instância de Defense somando a defesa de atributos, armadura e anel

	func genAttack()        // Gera uma nova instância de Attack baseado nos atributos e attackType do Foe
	func takeAttack(attack) // Calcula o dano do _attack_ recebido, desconta do HP atual e restorna o valor do dano
}

Ally { // Not Implemented yet
}

Player {
	var attributes // Atributos da criatura
	var armor      // Armadura que a criatura usa (pode ser null)
	var ring       // Anel que a criatura usa (pode ser null)
	var weapon     // Isntancia da classe Weapon (nunca pode ficar null)
	var trails    // Instancia da classe Trails (nunca pode ficar null)

	func _init() // Construtor

	func setArmor(armor)   // Coloca uma nova armadura no personagem e da um queue_free na armadura antiga (se houver)
	func setRing(ring)     // Coloca um novo anel na personagem e da um queue_free no anel antigo (se houver)
	func setWeapon(weapon) // Coloca uma nova arma na personagem e da um queue_free no anel antigo (se houver)
	func getDefense()      // Gera uma nova instância de Defense somando a defesa de atributos, armadura e anel

	func genAttack()        // Gera uma nova instância de Attack baseado nos atributos e na arma
	func takeAttack(attack) // Calcula o dano do _attack_ recebido, desconta do HP atual e restorna o valor do dano
}
```
#### Item
```
Weapon {
	var weight     // Peso
	var damage     // Dano base
	var damageType // Tipo de dano

	func _init(w = 0, t = Attack.Slash, d = 1) // Construtor

	func getAttackType() // Returna o tipo do ataque
	func genAttack()     // Returna uma nova instância de Attack para aquela arma
}

Armor {
	var weight  // Pese

	var defense // Instancia da classe Defense

	func _init(w = 0, s = 0, i = 0, t = 0) // Construtor, recebe peso e valores de defesa para cada tipo
}

Ring {
	var power // Instancia da classe Power

	func _init(hp = 0, st = 0, cl = 0, xp = 0, s = 0, i = 0, t = 0) // Construtor, recebe os bonus que o anel deve conceder
}

Bonus { // Not implemented yet
	Powers
	Durations
}

PowerUP { // Not implemented yet
	Powers
}

```

