//
//  DetailViewController.swift
//  InmobiliariaIOS
//
//  Created by Porfirio Diaz on 21/12/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: Variables
    //var idPropiedadMostrar: Propiedad?
    var propiedadMostrar: Propiedad?
    
//MARK: IBOulets
    @IBOutlet weak var imagenPropiedad: UIImageView!
    @IBOutlet weak var callePropiedad: UILabel!
    @IBOutlet weak var coloniaPropiedad: UILabel!
    @IBOutlet weak var municipioPropiedad: UILabel!
    @IBOutlet weak var estadoPropiedad: UILabel!
    @IBOutlet weak var terrenoPropiedad: UILabel!
    @IBOutlet weak var construccionPropiedad: UILabel!
    @IBOutlet weak var latitudPropiedad: UILabel!
    @IBOutlet weak var longitudPropiedad: UILabel!
    @IBOutlet weak var descripcionPropiedad: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagenPropiedad.loadFrom(URLAddress: propiedadMostrar?.thumbnail ?? "")
        callePropiedad.text = "Calle:  \(String(describing: propiedadMostrar?.calle ?? ""))"
        coloniaPropiedad.text = "Colonia:  \(String(describing: propiedadMostrar?.colonia ?? ""))"
        municipioPropiedad.text = "Municipio:  \(String(describing: propiedadMostrar?.municipio ?? ""))"
        estadoPropiedad.text = "Estado: \(String(describing: propiedadMostrar?.estado ?? ""))"
        terrenoPropiedad.text = "m2 Terreno:  \(String(describing: propiedadMostrar?.m2Terreno ?? ""))"
        construccionPropiedad.text = "m2 Construcción:  \(String(describing: propiedadMostrar?.m2Terreno ?? ""))"
        latitudPropiedad.text = "Latitud: \(propiedadMostrar!.latitud)"
        longitudPropiedad.text = "Longitud: \(propiedadMostrar!.longitud)"
        descripcionPropiedad.text = "\( propiedadMostrar?.descripcion ?? "")"
    }
    
    
    @IBAction func verUbicacionTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "LocalizationSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! LocalizationViewController
        
        destination.propiedad = propiedadMostrar
    }
    
    
    
}

extension UIImageView {
    func loadFrom(URLAddress: String){
        guard let url = URL(string: URLAddress) else {return}
        
        DispatchQueue.main.async {
            [weak self] in
            if let imageData = try? Data(contentsOf: url){
                if let loadedImage = UIImage(data: imageData){
                    self?.image = loadedImage
                }
            }
        }
    }
    
}
