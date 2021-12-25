//
//  ViewController.swift
//  HW2
//
//  Created by Ahmet Fatih YILMAZ on 25.12.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var baseScreenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // Removing all old observers
    deinit {
           NotificationCenter.default.removeObserver(self)
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Protocol-Delegate
        if segue.identifier == "toSecondVCwithProDel" {
            let destination = segue.destination as! SecondViewController
            //declare delegate pattern
            destination.delegate = self
            
            
            //Modifying buttons hidden state
            destination.isDelegateButtonHidden = false
            destination.isClosureButtonHidden = true
            destination.isNotificationButtonHidden = true
        }
        //Closure
        if segue.identifier == "toSecondVCwithClosure" {
            let destination = segue.destination as! SecondViewController
            destination.completion = { [weak self] word in
                self?.baseScreenLabel.text = word
            }
            
            //Modifying buttons hidden state
            destination.isDelegateButtonHidden = true
            destination.isClosureButtonHidden = false
            destination.isNotificationButtonHidden = true
        }
        //Notification
        if segue.identifier == "toSecondVCwithNotific" {
            let destination = segue.destination as! SecondViewController
          
            createObservers()
            //Modifying buttons hidden state
            destination.isDelegateButtonHidden = true
            destination.isClosureButtonHidden = true
            destination.isNotificationButtonHidden = false
        }
    }
    
    func createObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabel), name: Notification.Name(rawValue: "word"), object: nil)
    }
    
    @objc func updateLabel(notification: Notification) {
        baseScreenLabel.text = notification.userInfo?["word"] as? String
    }
    
    @IBAction func protocolDelegateButton(_ sender: Any) {
       // performSegue(withIdentifier: "toSecondVCwithProDel", sender: nil)
    }
    
    @IBAction func closureButton(_ sender: Any) {
       // performSegue(withIdentifier: "toSecondVCwithClosure", sender: nil)
    }
    
    @IBAction func notificationButton(_ sender: Any) {
      //  performSegue(withIdentifier: "toSecondVCwithNotific", sender: nil)
    }
    
}

extension ViewController: SendDataDelegate {
    func tfEditingDidEnd(word: String) {
        baseScreenLabel.text = word
    }
}


