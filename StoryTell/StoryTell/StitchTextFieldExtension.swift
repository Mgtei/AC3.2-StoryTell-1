//
//  StitchTextFieldExtension.swift
//  StoryTell
//
//  Created by Simone on 3/17/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit

extension StitchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        textField.backgroundColor = UIColor.lightGray
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.backgroundColor = Colors.cream
        let prompt = textField.text!
        let cell = StitchTableViewCell()
        let indexPath = cell.textField.tag
        if textField.text == "" {
            prompts.append(prompt)
        } else {
            prompts[indexPath] = textField.text!
        }
        print(prompts)
        return true

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
}
