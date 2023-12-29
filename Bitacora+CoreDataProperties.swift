//
//  Bitacora+CoreDataProperties.swift
//  InmobiliariaIOS
//
//  Created by Porfirio Diaz on 23/12/23.
//
//

import Foundation
import CoreData


extension Bitacora {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bitacora> {
        return NSFetchRequest<Bitacora>(entityName: "Bitacora")
    }

    @NSManaged public var fecha: Date?
    @NSManaged public var inicio: Date?
    @NSManaged public var fin: Date?
    @NSManaged public var asesor: String?
    @NSManaged public var propiedad: String?
    @NSManaged public var cliente: String?
    @NSManaged public var cel: String?
    @NSManaged public var mensaje: String?

}

extension Bitacora : Identifiable {

}
