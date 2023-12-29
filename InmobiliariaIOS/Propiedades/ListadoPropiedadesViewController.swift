//
//  PropiedadesViewController.swift
//  InmobiliariaIOS
//
//  Created by Porfirio Diaz on 21/12/23.
//

import UIKit
import SDWebImage

class ListadoPropiedadesViewController: UIViewController {
    
    @IBOutlet weak var tablaPropiedades: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
//MARK: Variables
    var propiedadManager = PropiedadManager()
    var propiedades: [Propiedad] = []
    var propiedadSeleccionada: Propiedad?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Registrar la nueva celda
        tablaPropiedades.register(UINib(nibName: "CeldaPropiedadTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        propiedadManager.delegado = self
        // implementamos el delegado de la tablaPropiedades
        tablaPropiedades.delegate = self
        tablaPropiedades.dataSource = self
        
        //Ejecutamos el método para buscar alguna propiedad en particular
        propiedadManager.obtenerListadoPropiedades()
    }

}

// MARK: Delegado Propiedad
extension ListadoPropiedadesViewController: PropiedadManagerDelegado{
    func manejarError(_ error: Error) {
        
    }
    
    func mostrarListaPropiedades(lista: [Propiedad]) {
        propiedades = lista
        
        DispatchQueue.main.async {
            self.tablaPropiedades.reloadData()
        }
    }
}
// MARK: Tabla
extension ListadoPropiedadesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propiedades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaPropiedades.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CeldaPropiedadTableViewCell
        let propiedad = propiedades[indexPath.row]
        
        celda.nombrePropiedad.text = propiedad.propiedad
        celda.estatusPropiedad.text = propiedad.estatus
        celda.tipoPropiedad.text = propiedad.tipo
        celda.precioPropiedad.text = propiedad.precio
        
        
        //Cargar imagen de manera asincrona
        if let urlString = propiedad.thumbnail as? String, let imagenURL = URL(string: urlString){
            celda.imagenPropiedad.sd_setImage(with: imagenURL, placeholderImage: UIImage(named: "placeholder"))
        }else{
            celda.imagenPropiedad.image = UIImage(named: "placeholder")
        }
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        propiedadSeleccionada = propiedades[indexPath.row]
        
        performSegue(withIdentifier: "detailSegue", sender: self)
        
        //Quitamos la selección de la celda
        tablaPropiedades.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            let detailSegue = segue.destination as! DetailViewController
            detailSegue.propiedadMostrar = propiedadSeleccionada
        }
    }
}
