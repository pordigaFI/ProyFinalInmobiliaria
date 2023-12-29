//
//  DatosPropiedad.swift
//  InmobiliariaIOS
//
//  Created by Porfirio Diaz on 25/12/23.
//

import Foundation

struct Propiedad: Codable, Identifiable{
    let thumbnail: String
    let id, propiedad: String
    let estatus: String
    let tipo, precio: String
    let calle, colonia, municipio, estado: String
    let m2Terreno, m2Construccion, descripcion: String
    let latitud, longitud: Double

    enum CodingKeys: String, CodingKey {
        case thumbnail, id
        case propiedad = "Propiedad"
        case estatus = "Estatus"
        case tipo = "Tipo"
        case precio = "Precio"
        case calle = "Calle"
        case colonia = "Colonia"
        case municipio = "Municipio"
        case estado = "Estado"
        case m2Terreno = "m2_Terreno"
        case m2Construccion = "m2_Construccion"
        case descripcion = "Descripcion"
        case latitud = "Latitud"
        case longitud = "Longitud"
        
    }
}
/*
    enum Estatus: String, Codable {
        case renta = "Renta"
        case venta = "Venta"
    }*/

// MARK: - Detalle propiedades
struct DetallePropiedades: Codable {
    let imagen: String
    let calle, colonia, municipio, estado: String
    let m2Terreno, m2Construccion, descripcion, latitud: String
    let longitud: String

    enum CodingKeys: String, CodingKey {
        case imagen
        case calle = "Calle"
        case colonia = "Colonia"
        case municipio = "Municipio"
        case estado = "Estado"
        case m2Terreno = "m2_Terreno"
        case m2Construccion = "m2_Construccion"
        case descripcion = "Descripcion"
        case latitud = "Latitud"
        case longitud = "Longitud"
    }
}

