//
//  SettingsViewController.swift
//  Revivar
//
//  Created by Apple on 23/03/2023.
//

import UIKit
import AVFoundation

struct SettingdCellaModel {
    let title:String
    let handler: (()-> Void)
    
    
}

class SettingsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var deta = [[SettingdCellaModel]]()
    var developer = ["Developer"]
    var soundNames = ["Sound"]
    var audioPlayers = [AVAudioPlayer]()
    
    private let tableview:UITableView = {
        
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableview
        
    }()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view
        title = "Settings"
        view.backgroundColor = .systemBackground
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
        configureCell()
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
        
        func configureCell() {
            let  sections1 = [SettingdCellaModel(title: "Sound", handler:  { [weak self] in
                self})]
            
            let  sections2 = [SettingdCellaModel(title: "Developer ", handler: { [weak self] in
                self?.developerNav()
            })]
            
            
            deta.append(contentsOf: [sections1,sections2])
        }
        
        
        func developerNav() {
            let  vc =  DeveloperViewController()
            DispatchQueue.main.async {
                let navc = UINavigationController(rootViewController: vc)
                navc.title = "Developer"
                navc.navigationBar.prefersLargeTitles = true
                self.present( navc, animated: true)
            }
        }
    
   
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  deta[section].count
      }
    func numberOfSections(in tableView: UITableView) -> Int {
        deta.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let index = [indexPath.section][indexPath.row]
        switch index{
        case 0:
            let cell = tableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = deta[indexPath.section][indexPath.row].title
            let toggleButton = UISwitch()
            toggleButton.addTarget(self, action: #selector(toggleSound(_:)), for: .valueChanged)
            toggleButton.tag = indexPath.row
            toggleButton.isOn = UserDefaults.standard.bool(forKey: "toggleState")
            cell.accessoryView = toggleButton
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = deta[indexPath.section][indexPath.row].title
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
           default:
            fatalError()
           }
        
    }
    
    
      
      @objc func toggleSound(_ sender: UISwitch) {
          let soundIndex = sender.tag
          
          if sender.isOn {
              SoundModel.shared.setBoolValue(true)
              SoundModel.shared.backgroundPlay(namesong: "Moonshine")
              UserDefaults.standard.set(sender.isOn, forKey: "toggleState")
           } else {
               SoundModel.shared.stopPlayback()
               SoundModel.shared.setBoolValue(false)
               UserDefaults.standard.set(sender.isOn, forKey: "toggleState")
             
          }
      }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        deta[indexPath.section][indexPath.row].handler()
    }
  
  }


