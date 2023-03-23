//
//  ThankYouViewController.swift
//  Revivar
//
//  Created by Apple on 22/03/2023.
//

import UIKit

class ThankYouViewController: UIViewController,CardGenaratorControllerDelegate{
    
    
    lazy var imageView1: UIImageView = {
           let imageView = UIImageView()
           imageView.contentMode = .scaleAspectFill
           imageView.clipsToBounds = true
           imageView.isUserInteractionEnabled = true
           imageView.layer.cornerRadius = constants.corneRadius
     imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:          #selector(selectImage(_:))))
        
           return imageView
       }()
    
    private let Namelabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let ThankYoulabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let Instructionlabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
      
        return label
    }()
    
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
        title = "Welcome"
        view.backgroundColor = .systemBackground
        view.addSubview(imageView1)
        view.addSubview(createCardButton)
        imageView1.addSubview(ThankYoulabel)
        imageView1.addSubview(Namelabel)
        view.addSubview(Instructionlabel)
        //SoundModel.shared.backgroundPlay()
        NavigationBarButton()
        
       
    }
    @objc func createCard(_ sender: UIButton) {
        let  vc =  CardGenaratorViewController()
         vc.delegate  = self
        DispatchQueue.main.async {
           let navc = UINavigationController(rootViewController: vc)
            navc.title = "Create A Photo Card"
            navc.navigationBar.prefersLargeTitles = true
           self.present( navc, animated: true)
        }
   
       }
        
    @objc func selectImage(_ sender: UITapGestureRecognizer) {
        
        // Save the image to the user's gallery
            let renderer = UIGraphicsImageRenderer(size: imageView1.bounds.size)
            let image = renderer.image { ctx in
                imageView1.drawHierarchy(in: imageView1.bounds, afterScreenUpdates: true)
            }
            
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // Handle error
            print("Error saving image to photo library: \(error.localizedDescription)")
        } else {
            // Image saved successfully
            let sheet = UIAlertController(title: "PictureSaved", message: "Picture has been saved to gallery", preferredStyle: .actionSheet)
            sheet.addAction(UIAlertAction(title: "ok", style: .default,handler:nil))
            present(sheet, animated: true)
            
            print("Image saved to photo library")
            if UserDefaults.standard.bool(forKey:"myBoolKey" ) == true  {
                SoundModel.shared.backgroundPlay(namesong: "jermaine1")
            }
          
        }
    }

    func NavigationBarButton() {
        
         navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
    }
    @objc private func didTapSettings() {
        let signVC = SettingsViewController()
        signVC.navigationItem.largeTitleDisplayMode = .always
        let NavVc =  UINavigationController(rootViewController: signVC)
        NavVc.navigationBar.prefersLargeTitles  = true
        self.present(NavVc, animated: true)
        
    }
    
    func didSelectProduct(name: String, imagename: UIImage) {
     
        imageView1.image = imagename
        Namelabel.text = name
        ThankYoulabel.text = "Thankyou"
        createCardButton.setTitle("Create Another Card", for: .normal)
        view.backgroundColor = .black
        Instructionlabel.text = "Tap The Photo To Saved In Gallery"
       
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let margin: CGFloat = 20
        let imageViewWidth = (view.bounds.width - margin * 3) / 2
        let imageViewHeight = imageViewWidth * 5/4
        let buttonHeight: CGFloat = 50
        
        imageView1.frame = CGRect(x: margin, y: margin + view.safeAreaInsets.top, width: imageViewWidth, height: imageViewHeight)
        
        Namelabel.frame = CGRect(x: imageView1.width/4, y:  imageView1.top - 150, width: imageViewWidth-20, height: imageViewHeight/4)
        
        ThankYoulabel.frame = CGRect(x:  imageView1.width/4, y: imageView1.top + 10, width: imageViewWidth-20, height: imageViewHeight/4)
        
        createCardButton.frame = CGRect(x: margin, y:imageView1.frame.maxY + margin, width: view.bounds.width - margin * 2, height: buttonHeight)
      
        Instructionlabel.frame = CGRect(x: margin, y:createCardButton.frame.maxY + 20 + margin, width: view.bounds.width - margin * 2, height: buttonHeight)
    
    }

}
