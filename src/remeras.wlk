
class RemeraLisa {
	
	const property talle
	const property color		// color es un objeto del tipo "Color"
	
	method precioPorTalle() {
		if (talle.between(32,40)) {
			return 80
		}
		else if (talle.between(41,48)) {
			return 100
		}
		else {
			throw new Exception("No vende el talle requerido")
		}
	}
	
	method adicionalColor() {
		if (color.esBasico()) {
			return 1
		}
		else {
			return 1.1
		}
	}
	
	method precio() {
		return self.precioPorTalle() * self.adicionalColor()	
	}
	
}

class RemeraBordada inherits RemeraLisa {
	
	const property coloresBordado
	
	method adicionalBordado() = (coloresBordado * 10).max(20)
	
	override method precio() = super() + self.adicionalBordado()
	
}

class RemeraSublimada inherits RemeraLisa {
	
	const property sublimado		// sublimado es un objeto del tipo "sublimado"
	
	method adicionalSublimado() = sublimado.superficie() * 0.5 + sublimado.copyright()
	
	override method precio() = super() + self.adicionalSublimado()
	
}

class Sublimado {
	
	const property copyright		// costo por derecho de autor
	const property ancho
	const property alto
	
	method superficie() = alto * ancho
	
}

// clase para definir los colores como objetos
class Color {
	const property esBasico
}