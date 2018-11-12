
import remeras.*

class Comercio {
	
	var property sucursales = []
	
	method agregarSucursal(sucursal) {
		sucursales.add(sucursal)
	}
	
	method registarPedido(sucursal, pedido) {
		sucursal.agregarPedido(pedido)
	}
	
	method totalFacturado() = sucursales.sum { sucursal => sucursal.ventasSucursal()}
	
	method totalFacturadoSucursal(sucursal) { // TODO Este pasamanos entre comercio y sucursal es innecesario.
		if (sucursales.contains(sucursal)) {
			return sucursal.ventasSucursal()
		}
		else {
			return new Exception("El comercio no tiene una sucursal con ese nombre") // TODO ¿nombre?
		}
	}
	
	method pedidosPorColor(color) = sucursales.sum { sucursal => sucursal.pedidosDeUnColor(color) }
	
	method pedidoMasCaro() = sucursales.max { sucursal => sucursal.elPedidoMasCaro() }
	
	method tallesPedidos() = sucursales.map { sucursal => sucursal.tallesPedidos() }.asSet()

	// TODO rangoTalles no debería ser un parámetro, el enunciado define un rango explícitamente.	
	method tallesSinPedidos(rangoTalles) = rangoTalles.difference(self.tallesPedidos())
	
	method sucursalQueMasFacturo() = sucursales.max { sucursal => sucursal.ventasSucursal() }
	
	method sucursalTodosTallesVendidos(rangoTalles) =
		sucursales.any { sucursal => sucursal.vendioTodosTalles(rangoTalles) }
	
}

class Sucursal {
	
	var property pedidos = []
	const property cantMinima
	
	method agregarPedido(pedido) {
		pedidos.add(pedido)
	}
	
	method ventasSucursal() = pedidos.sum { pedido => pedido.precioPedido() }
	
	method pedidosDeUnColor(color) = pedidos.count { pedido => pedido.esDeColor(color) }
	
	method elPedidoMasCaro() = pedidos.max { pedido => pedido.precioPedido() }
	
	method tallesPedidos() = pedidos.map { pedido => pedido.talleModeloPedido() }
	
	method vendioTodosTalles(rangoTalles) = self.tallesPedidos().asSet() == rangoTalles
	
}


class Pedido {
	
	const property modeloPedido
	const property cantidadPedido
	const property sucursal
	
	method precioBase() = modeloPedido.precio() * cantidadPedido
	
	method porcentajeDescuento() {
		if (self.aplicaDescuento()){
			return modeloPedido.descuento()/100
		}
		else {
			return 0
		}
	}	
	
	method aplicaDescuento() = cantidadPedido > sucursal.cantMinima()
	
	method precioPedido() = self.precioBase() * (1 - self.porcentajeDescuento())
	
	method esDeColor(color) = modeloPedido.color() == color
	
	method talleModeloPedido() = modeloPedido.talle()
	
}

