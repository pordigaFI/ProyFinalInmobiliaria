//
//  CeldaPropiedadTableViewCell.swift
//  InmobiliariaIOS
//
//  Created by Porfirio Diaz on 25/12/23.
//

import UIKit

class CeldaPropiedadTableViewCell: UITableViewCell {
    @IBOutlet weak var imagenPropiedad: UIImageView!
    @IBOutlet weak var nombrePropiedad: UILabel!
    @IBOutlet weak var estatusPropiedad: UILabel!
    @IBOutlet weak var tipoPropiedad: UILabel!
    @IBOutlet weak var precioPropiedad: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imagenPropiedad.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
