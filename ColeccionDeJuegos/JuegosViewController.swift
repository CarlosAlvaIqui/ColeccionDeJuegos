//
//  JuegosViewController.swift
//  ColeccionDeJuegos
//
//  Created by MAC11 on 25/04/19.
//  Copyright © 2019 Carlos Alvarez. All rights reserved.
//

import UIKit

class JuegosViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var juego:Juego? = nil
    
    
    @IBOutlet weak var JuegoImageView: UIImageView!
    
    @IBOutlet weak var tituloTextField: UITextField!
    
    @IBOutlet weak var eliminarBoton: UIButton!
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        if juego != nil {
            JuegoImageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            agregarActualizarBoton.setTitle("Actualizars", for: .normal)
        }else {
            eliminarBoton.isHidden = true
        }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func agregarTapper(_ sender: Any) {
        if juego != nil{
            juego!.titulo! = tituloTextField.text!
            juego!.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50)
        }else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context: context)
            juego.titulo = tituloTextField.text
            juego.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada = info[.originalImage] as? UIImage
        JuegoImageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    var imagePicker = UIImagePickerController()
 
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
