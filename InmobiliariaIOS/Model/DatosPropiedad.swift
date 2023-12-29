//
//  DatosPropiedad.swift
//  InmobiliariaIOS
//
//  Created by Porfirio Diaz on 25/12/23.
//

import Foundation

struct Propiedad: Decodable, Identifiable{
    let thumbnail: String
    let id, propiedad: String
    let estatus: Estatus
    let tipo, precio: String

    enum CodingKeys: String, CodingKey {
        case thumbnail, id
        case propiedad = "Propiedad"
        case estatus = "Estatus"
        case tipo = "Tipo"
        case precio = "Precio"
    }
}

    enum Estatus: String, Codable {
        case renta = "Renta"
        case venta = "Venta"
    }

