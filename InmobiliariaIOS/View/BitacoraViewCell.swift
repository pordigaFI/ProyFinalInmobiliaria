//
//  BitacoraViewCell.swift
//  InmobiliariaIOS
//
//  Created by Porfirio Diaz on 21/12/23.
//

import UIKit

class BitacoraViewCell: UITableViewCell {
   
    @IBOutlet weak var bitacoraPropiedad: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
