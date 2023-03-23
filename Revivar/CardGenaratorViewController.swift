//
//  ViewController.swift
//  Revivar
//
//  Created by Apple on 22/03/2023.
//

import UIKit

class CardGenaratorViewController: UIViewController {
    
    var delegate:CardGenaratorControllerDelegate?
    
    var selectedImage: UIImage?
    
    ///imageView1
    lazy var imageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = constants.corneRadius
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectImage(_:))))
        return imageView
    }()
    
    ///imageView2
    lazy var imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = constants.corneRadius
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectImage(_:))))
        return imageView
    }()
    
    ///imageView3
    lazy var imageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectImage(_:))))
        return imageView
    }()
    
    ///imageView4
    lazy var imageView4: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectImage(_:))))
        return imageView
    }()
    ///imageView5
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.placeholder = "Enter your name"
        textField.borderStyle = .roundedRect
        return textField
    }()
     ///  createCardButton
    lazy var createCardButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Card", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(createCard(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "Create A Card"
        view.addSubview(imageView1)
        view.addSubview(imageView2)
        view.addSubview(imageView3)
        view.addSubview(imageView4)
        view.addSubview(nameTextField)
        view.addSubview(createCardButton)
        NetworkDowload()
        
    }
    
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let margin: CGFloat = 20
        let buttonHeight: CGFloat = 50
        let textFieldHeight: CGFloat = 30
        let imageViewWidth = (view.bounds.width - margin * 3) / 2
        let imageViewHeight = imageViewWidth * 5/4
        
        imageView1.frame = CGRect(x: margin, y: margin + view.safeAreaInsets.top, width: imageViewWidth, height: imageViewHeight)
        
        imageView2.frame = CGRect(x: margin * 2 + imageViewWidth, y: margin + view.safeAreaInsets.top, width: imageViewWidth, height: imageViewHeight)
        
        imageView3.frame = CGRect(x: margin, y: margin * 2 + imageViewHeight + view.safeAreaInsets.top, width: imageViewWidth, height: imageViewHeight)
        
        imageView4.frame = CGRect(x: margin * 2 + imageViewWidth, y: margin * 2 + imageViewHeight + view.safeAreaInsets.top, width: imageViewWidth, height: imageViewHeight)
        
        nameTextField.frame = CGRect(x: margin, y: imageView4.frame.maxY + margin, width: view.bounds.width - margin * 2, height: textFieldHeight)
        
        createCardButton.frame = CGRect(x: margin, y: nameTextField.frame.maxY + margin, width: view.bounds.width - margin * 2, height: buttonHeight)
        
    }
    
    
    func getRandomImages() {
        imageView1.image = UIImage(named: "jermaine")
        imageView2.image = UIImage(named: "mouse")
        imageView3.image = UIImage(named: "photo")
        imageView4.image = UIImage(named: "Unknown")
        
    }
    
    @objc func selectImage(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else {
            return
        }
        // Set the selected image to the tapped image view
        selectedImage = imageView.image
        // Highlight the tapped image view
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemBlue.cgColor
        // Unhighlight the other image views
        for view in [imageView1, imageView2, imageView3, imageView4] {
            if view != imageView {
                view.layer.borderWidth = 0
            }
        }
        
    }
    
    ///Create card
    
    @objc func createCard(_ sender: UIButton) {
    
        guard selectedImage != nil , nameTextField.text != ""  else {
            alertCheck()
            return
        }
      
        
        guard let image = selectedImage, let name = nameTextField.text else {
            return
        }
        
        delegate?.didSelectProduct(name: name, imagename: image)
        if UserDefaults.standard.bool(forKey:"myBoolKey" ) == true  {
            SoundModel.shared.backgroundPlay(namesong: "win")
        }
        dismiss(animated: true,completion: nil)
    }
    
    func alertCheck() {
        let sheet = UIAlertController(title: "select image and enter your name", message: "make sure you enter yourn name and select an image before creating a picture card", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .default,handler:nil))
        present(sheet, animated: true)
    }
    
    ///Dowload Images
    func NetworkDowload(){
        let urls = [
                    URL(string: "https://source.unsplash.com/random/300x300")!,
                    URL(string: "https://source.unsplash.com/random/300x300")!,
                    URL(string: "https://source.unsplash.com/random/300x300")!,
                    URL(string: "https://source.unsplash.com/random/300x300")!
                ]
                
                for (index, url) in urls.enumerated() {
                    let imageView = [imageView1, imageView2, imageView3, imageView4][index]
                    
                    URLSession.shared.dataTask(with: url) { data, response, error in
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                imageView.image = image
                            }
                        } else {
                            print("Error downloading image: \(error?.localizedDescription ?? "unknown error")")
                            DispatchQueue.main.async {
                                self.getRandomImages()
                            }
                        }
                    }.resume()
                }
            }
        }

extension CardGenaratorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


