//
//  ViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Yusuf Emin Günay on 10.03.2026.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseStorage

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var sifreTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func girisYapTiklandi(_ sender: Any) {
        // 1. Kutuyu açıyoruz (Unwrap) ve değerlerin varlığından emin oluyoruz
        guard let email = emailTextField.text, !email.isEmpty,
              let sifre = sifreTextField.text, !sifre.isEmpty else {
            
            self.hataMesaji(titleInput: "Hata!", messageInput: "Email ve Şifrenizi giriniz")
            return
        }
        
        // 2. Artık 'email' ve 'sifre' kesinlikle String tipinde, hata almayacaksın.
        Auth.auth().signIn(withEmail: email, password: sifre) { authDataResult, error in
            if error != nil {
                self.hataMesaji(titleInput: "Hata!", messageInput: error?.localizedDescription ?? "Hata aldınız tekrar deneyin")
            } else {
                self.performSegue(withIdentifier: "toFeedVC", sender: nil)
            }
        }
    }
    
    @IBAction func kayitOlTiklandi(_ sender: Any) {
        // 1. Textfield'lardaki veriyi kontrol edip kutudan çıkartıyoruz (Unwrapping)
        guard let email = emailTextField.text, !email.isEmpty,
              let sifre = sifreTextField.text, !sifre.isEmpty else {
            
            // Eğer alanlardan biri boşsa bu blok çalışır
            self.hataMesaji(titleInput: "Hata!", messageInput: "Email ve Şifre alanlarını boş bırakmayınız.")
            return
        }
        
        // 2. Artık 'email' ve 'sifre' güvenli birer String, hata vermeden Firebase'e gönderilir
        Auth.auth().createUser(withEmail: email, password: sifre) { authDataResult, error in
            if let error = error {
                // Bir hata oluştuysa (örneğin email formatı yanlışsa veya şifre çok kısaysa)
                self.hataMesaji(titleInput: "Hata!", messageInput: error.localizedDescription)
            } else {
                // Kayıt başarılıysa kullanıcıyı bir sonraki ekrana gönderiyoruz
                self.performSegue(withIdentifier: "toFeedVC", sender: nil)
            }
        }
    }
    
    func hataMesaji(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

