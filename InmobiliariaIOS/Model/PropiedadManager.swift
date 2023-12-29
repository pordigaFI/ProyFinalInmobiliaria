//
//  PropiedadManager.swift
//  InmobiliariaIOS
//
//  Created by Porfirio Diaz on 25/12/23.
//

import Foundation


protocol PropiedadManagerDelegado: AnyObject{
    
    func mostrarListaPropiedades(lista: [Propiedad])
    func manejarError(_ error: Error)
}

struct PropiedadManager{
    
    weak var delegado: PropiedadManagerDelegado?
    
func obtenerListadoPropiedades(){
    let baseUrl: String = "https://private-f0acf-casas.apiary-mock.com"
    let urlString = "\(baseUrl)/propiedades/propiedades_list"
    if let url = URL(string: urlString){
        let tarea = URLSession.shared.dataTask(with: url){data, response, error in

            //MARK: Manejo de errores
            
            if let error = error{
                delegado?.manejarError(error)
                //print("Error: \(error.localizedDescription)")
                return
            }
            //verificamos si se recibió correctamente la respuesta Http
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "HTTPErrorDomain", code: 0, userInfo: nil)
                delegado?.manejarError(error)
                //print("Error: No se recibio respuesta HTTP valida")
                return
            }
                //verificamos si la respuesta tiene el codigo de estado 200 (OK)
                guard httpResponse.statusCode == 200 else {
                print("Error: Codigo de estado no valida")
                return
            }
            
            //verificamos si se recibieron datos
            guard let responseData = data else {
                let error = NSError(domain: "DataErrorDomain", code: 0, userInfo: nil)
                delegado?.manejarError(error)
                //print("Error: No se recibieron datos")
                return
            }
            //Decodificamos los datos
            do{
                let decodeData = try
                    JSONDecoder().decode([Propiedad].self, from: responseData)
                    delegado?.mostrarListaPropiedades(lista: decodeData)
            }catch{
                    delegado?.manejarError(error)
                }
        }
        
        //iniciamos la tarea de la sesion para realizar la solicitud
        tarea.resume()
    }else{
        let error = NSError(domain: "URLErrorDomain", code: 0, userInfo: nil)
        delegado?.manejarError(error)
        //print("Error: URL no valida")
        }
    }
        
}
   

