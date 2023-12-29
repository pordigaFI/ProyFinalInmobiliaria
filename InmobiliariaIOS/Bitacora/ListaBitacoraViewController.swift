//
//  ListaBitacoraViewController.swift
//  InmobiliariaIOS
//
//  Created by Porfirio Diaz on 21/12/23.
//

import UIKit
import CoreData

class ListaBitacoraViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var currentBitacora : Bitacora?
    var bitacoraManager : BitacoraDataManager?
    
    
    @IBOutlet weak var ListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bitacoraManager = BitacoraDataManager(context: context)
        bitacoraManager?.fetch()  //recuperamos la nueva información
        ListTableView.reloadData()
        // Do any additional setup after loading the view.
        ListTableView.dataSource = self
        ListTableView.delegate = self
    }

    
    //MARK: persistence methods
//Conectamos desde el StoryBoard, la etiqueta (SAVE) con exit y tenemos que ver en connection inspector la relación
    @IBAction func UnWindFromDetailBitacora (segue: UIStoryboardSegue){
        //Vamos a indicar de donde viene la información para recuperarla
        let source = segue.source as! BitacoraViewController
        currentBitacora = source.DetailBitacora
        
        do{
            try context.save()  //aqui se recupera la informacion para que persista
        }catch let error{
            print("Error: ", error)
        }
        //Nos traemos la informacion
        bitacoraManager?.fetch()
        self.ListTableView.reloadData()
    }

}

extension ListaBitacoraViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (bitacoraManager?.countBitacora())!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bitacoraCell = tableView.dequeueReusableCell(withIdentifier: "BitacoraCell", for: indexPath) as! BitacoraViewCell
        bitacoraCell.bitacoraPropiedad.text = bitacoraManager?.getBitacora(at: indexPath.row).propiedad
        return bitacoraCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //perform segue when user touchs a cell
        performSegue(withIdentifier: "showBitacoraSegue", sender: self)
        //Vamos a enviar la info
        
    }
    //preparamos la informacion para enviarla
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBitacoraSegue"{
            let destination = segue.destination as! BitacoraViewController
            destination.DetailBitacora = bitacoraManager?.getBitacora(at: ListTableView.indexPathForSelectedRow!.row)
        }
    }
}
