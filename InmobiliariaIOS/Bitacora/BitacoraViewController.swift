//
//  ViewController.swift
//  InmobiliariaIOS
//
//  Created by Porfirio Diaz on 21/12/23.
//

import UIKit
import MessageUI

class BitacoraViewController: UIViewController, MFMessageComposeViewControllerDelegate{
    
    
    //Definimos nuestro contexto
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //Definimos donde se guardará la Bitacora
        var DetailBitacora : Bitacora?
        //Definimos nuestro DataManager
        var bitacoraManager : BitacoraDataManager?
        
    @IBOutlet weak var BitacoraFecha: UIDatePicker!
    @IBOutlet weak var BitacoraHoraInicio: UIDatePicker!
    @IBOutlet weak var BitacoraHoraFin: UIDatePicker!
    @IBOutlet weak var BitacoraAsesor: UITextField!
    @IBOutlet weak var BitacoraPropiedad: UITextField!
    @IBOutlet weak var BitacoraCliente: UITextField!
    @IBOutlet weak var BitacoraCel: UITextField!
    @IBOutlet weak var BitacoraMensaje: UITextView!
    
        override func viewDidLoad() {
            super.viewDidLoad()

            //Inicializamos nuestra BitacoraManager
            bitacoraManager = BitacoraDataManager(context: context)
            
            //Vamos a investigar si tenemos almacenada una visita en la bitacora o no
            if DetailBitacora != nil {
                //Si la tarea es diferente de nulo, indica que vamos a realizar una actualización
                BitacoraFecha.date = (DetailBitacora?.fecha)!
                BitacoraHoraInicio.date = (DetailBitacora?.inicio)!
                BitacoraHoraFin.date = (DetailBitacora?.fin)!
                BitacoraAsesor.text = DetailBitacora?.asesor
                BitacoraPropiedad.text = DetailBitacora?.propiedad
                BitacoraCliente.text = DetailBitacora?.cliente
                BitacoraCel.text = DetailBitacora?.cel
                BitacoraMensaje.text = DetailBitacora?.mensaje
                
            }else{
                //creamos una nueva visita
                DetailBitacora = Bitacora(context: context)
                DetailBitacora?.propiedad = ""
                
            }
        }

    @IBAction func cancelbuttonPressed(_ sender: Any) {
            let isModal = self.presentingViewController is UINavigationController
            
            if isModal {
                //Indica que utilizamos el camino donde esta showBitacoraSegue, o sea
                //partimos de  List Bitacora View Controller y llegaremos a Bitacora View Controller
                self.dismiss(animated: true)
            }
            else{
                //Indica que para llegar a Bitacora View Controller, primero pasamos por el Navigation Controller
                navigationController?.popViewController(animated: true)
            }
        }
        
       
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
            let destination = segue.destination as! ListaBitacoraViewController
            
            DetailBitacora?.fecha = BitacoraFecha.date
            DetailBitacora?.inicio = BitacoraHoraInicio.date
            DetailBitacora?.fin = BitacoraHoraFin.date
            DetailBitacora?.asesor = BitacoraAsesor.text
            DetailBitacora?.propiedad = BitacoraPropiedad.text
            DetailBitacora?.cliente = BitacoraCliente.text
            DetailBitacora?.cel = BitacoraCel.text
            DetailBitacora?.mensaje = BitacoraMensaje.text
            
            //el siguiente paso es mandar la informacion al destino
            destination.currentBitacora =  DetailBitacora
        }
        
        //Vamos a usar el procedimiento de Unwinsegue, para que se regrese
        
        override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            var perform = false
            //Solo vamos a validar que el campo BitacoraPropiedad tenga algo
            if BitacoraPropiedad.text != ""{
                perform = true
            }else{
                print("No se cuenta con información de la propiedad!")
            }
            return perform
        }
    
    @IBAction func SmsButton(_ sender: UIButton) {
        enviarMensajeSMS()
    }
    
    
}

extension BitacoraViewController{
    func enviarMensajeSMS(){
        guard let mensaje = BitacoraMensaje.text,
              let telefono = BitacoraCel.text else{
            print("No hay mensaje que enviar")
            return
        }
        if MFMessageComposeViewController.canSendText(){
            let messageController = MFMessageComposeViewController()
            messageController.body = mensaje
            messageController.recipients = [telefono]
            messageController.messageComposeDelegate = self
            
            present(messageController,animated: true, completion: nil)
        }else{
            print("No se puede enviar mensajes SMS desde este dispositivo")
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult){
        switch result{
        case .cancelled:
            print("El usuario canceló el envio del mensaje")
        case .sent:
            print("Mensaje enviado exitosamente")
        case .failed:
            print("No se pudo enviar el mensaje")
        @unknown default:
            fatalError()
        }
    }

}

