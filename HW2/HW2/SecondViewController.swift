//
//  SecondViewController.swift
//  HW2
//
//  Created by Ahmet Fatih YILMAZ on 25.12.2021.
//

import UIKit

protocol SendDataDelegate {
    func tfEditingDidEnd(word:String)
}

class SecondViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!

        //delegate pattern
        var delegate : SendDataDelegate?
        
        
        //closure pattern
        var completion : ((String?) -> Void)?
            
        
        @IBOutlet weak var delegateButton: UIButton!
        
        @IBOutlet weak var closureButton: UIButton!
        
        @IBOutlet weak var notificationButton: UIButton!
        
        
        var isDelegateButtonHidden:Bool?
        var isClosureButtonHidden:Bool?
        var isNotificationButtonHidden:Bool?
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            //Reorganize and modify buttons state
            if let state = (isDelegateButtonHidden){
                delegateButton.isHidden = state
            }
            if let state = (isClosureButtonHidden){
                closureButton.isHidden = state
            }
            if let state = (isNotificationButtonHidden){
                notificationButton.isHidden = state
            }
        }
        
        
        //Delegate Pattern Part
        @IBAction func delegateButton(_ sender: Any) {
            if let word = textField.text, textField.text != "" {
                let combineWord = "Delegate word: \(word)"
                delegate?.tfEditingDidEnd(word: combineWord)
                navigationController?.popToRootViewController(animated: true)}
        }
        
        
        @IBAction func textFieldEditingDidEnd(_ sender: UITextField) {
       
        }
        
        //Closure Pattern Part
        @IBAction func closureDoneButton(_ sender: Any) {
            if let word = textField.text, textField.text != "" {
                let combineWord = "Closure word: \(word)"
                completion?(combineWord)
                navigationController?.popToRootViewController(animated: true)
            }
           
        }
        
        //Notification Pattern part
        @IBAction func notificationButton(_ sender: Any) {
            if let word = textField.text, textField.text != "" {
                let combineWord = "Notification word: \(word)"
                NotificationCenter.default.post(name: Notification.Name(rawValue: "word"), object: nil, userInfo: ["word": combineWord])
                navigationController?.popToRootViewController(animated: true)
            }
        }
        
        
    }

