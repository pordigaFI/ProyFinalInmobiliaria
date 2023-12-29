//
//  BitacoraDataManager.swift
//  InmobiliariaIOS
//
//  Created by Porfirio Diaz on 21/12/23.
//

import Foundation
import CoreData

class BitacoraDataManager{
    private var bitacoras : [Bitacora] = []
    private var context : NSManagedObjectContext
    
    init(context : NSManagedObjectContext){
        self.context = context
    }
    
    // se van a recuperar todas las tareas que tenga disponibles nuestro almacén y se guardarian en la variable Bitacora
    func fetch(){
        do{
            self.bitacoras = try self.context.fetch(Bitacora.fetchRequest())
        }
        catch let error{
            print("error", error)
        }
    }
    
    //Recuperamos un elemento en una posición específica de nuestro arreglo
    func getBitacora(at index : Int) -> Bitacora{
        return bitacoras[index]
    }
    
    //Este método nos va a decir cuantas visitas tenemos almacenadas
    func countBitacora() -> Int {
        return bitacoras.count
    }
}
