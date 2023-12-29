//
//  ViewController.swift
//  InmobiliariaIOS
//
//  Created by Porfirio Diaz on 21/12/23.
//

import UIKit

class BitacoraViewController: UIViewController {
    //Definimos nuestro contexto
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //Definimos donde se guardará la Bitacora
        var DetailBitacora : Bitacora?
        //Definimos nuestro DataManager
        var bitacoraManager : BitacoraDataManager?
        
        @IBOutlet weak var taskTitle: UITextField!
        @IBOutlet weak var taskDate: UIDatePicker!
        @IBOutlet weak var taskNotes: UITextView!
        
        
        override func viewDidLoad() {
            super.viewDidLoad()

            //Inicializamos nuestra BitacoraManager
            bitacoraManager = BitacoraDataManager(context: context)
            
            //Vamos a investigar si tenemos almacenada una visita en la bitacora o no
            if DetailBitacora != nil {
                //Si la tarea es diferente de nulo, indica que vamos a realizar una actualización
                taskTitle.text = toDoDetailTask?.title
                taskDate.date = (toDoDetailTask?.date)!
                taskNotes.text = toDoDetailTask?.note
            }else{
                //creamos una nueva visita
                toDoDetailTask = Bitacora(context: context)
                toDoDetailTask?.title = ""
                
            }
        }

        
        @IBAction func cancelbuttonPressed(_ sender: UIBarButtonItem) {
            let isModal = self.presentingViewController is UINavigationController
            
            if isModal {
                //Indica que utilizamos el camino donde esta showTaskSegue, o sea
                //partimos de To Do List View Controller y llegaremos a Bitacora Detail View Controller
                self.dismiss(animated: true)
            }
            else{
                //Indica que para llegar al Task Detail View Controller, primero pasamos por el Navigation Controller
                navigationController?.popViewController(animated: true)
            }
        }
        
       
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
            let destination = segue.destination as! ToDoListViewController
            
            toDoDetailTask?.title = taskTitle.text
            toDoDetailTask?.date = taskDate.date
            toDoDetailTask?.note = taskNotes.text
            
            //el siguiente paso es mandar la informacion al destino
            destination.currentTask =  toDoDetailTask
        }
        
        //Vamos a usar el procedimiento de Unwinsegue, para que se regrese
        
        override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            var perform = false
            
            if taskTitle.text != ""{
                perform = true
            }else{
                print("Title value is required!")
            }
            return perform
        }
}

