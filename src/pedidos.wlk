
import remeras.*

class Comercio {
	
	var property sucursales = []
	
	method registarPedido(sucursal, pedido) {
		sucursal.agregarPedido(pedido)
	}
	
	method totalFacturado() = sucursales.sum { sucursal => sucursal.ventasSucursal()}
	
	method totalFacturadoSucursal(sucursal) {
		if (sucursales.contains(sucursal)) {
			sucursal.ventasSucursal()
		}
	}
	
	method pedidosPorModelo(modelo) = sucursales.sum { sucursal => sucursal.pedidosDeUnModelo(modelo) }
	
	//method pedidosTotales() = sucursales.map { sucursal => sucursal.pedidos() }
	
	method pedidoMasCaro() = sucursales.max { sucursal => sucursal.elPedidoMasCaro() }
	
	method tallesPedidos() = sucursales.map { sucursal => sucursal.tallesPedidos() }.asSet()
	
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
	
	method pedidosDeUnModelo(modelo) = pedidos.count { pedido => pedido.esDeModelo(modelo) }
	
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
	
	method esDeModelo(modelo) = modeloPedido == modelo
	
	method talleModeloPedido() = modeloPedido.talle()
	
}

