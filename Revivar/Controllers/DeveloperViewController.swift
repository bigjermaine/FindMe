//
//  DeveloperViewController.swift
//  Revivar
//
//  Created by Apple on 23/03/2023.
//

import UIKit

class DeveloperViewController: UIViewController {

    
    private let Namelabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = "Daniel Jermaine stay hungry and stay foolish(SteveJobs)"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Developer"
        view.backgroundColor = .systemBackground
        view.addSubview(Namelabel)
      
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let margin: CGFloat = 20
    
        Namelabel.frame = CGRect(x: margin, y:20, width: view.bounds.width - 50, height:view.bounds.height)
    }
    

   
}
