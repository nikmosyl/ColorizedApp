//
//  ViewController.swift
//  ColorizedApp
//
//  Created by nikita on 19.11.23.
//

import UIKit

final class SettingViewController: UIViewController {

    //MARK: - IB Outlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    //MARK: - Public properties
    var color: UIColor!
    
    weak var delegate: SettingViewControllerDelegate?
    
    //MARK: - Overide methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addToolBar(redTextField)
        addToolBar(greenTextField)
        addToolBar(blueTextField)
        
        colorView.layer.cornerRadius = 20
        colorView.backgroundColor = color
        
        let components = parseColorToRGB(color)
        
        redSlider.value = Float(components.red)
        greenSlider.value = Float(components.green)
        blueSlider.value = Float(components.blue)
        
        redValueLabel.text = String(format: "%.2f", redSlider.value)
        greenValueLabel.text = String(format: "%.2f", greenSlider.value)
        blueValueLabel.text = String(format: "%.2f", blueSlider.value)
        
        redTextField.text = String(format: "%.2f", redSlider.value)
        greenTextField.text = String(format: "%.2f", greenSlider.value)
        blueTextField.text = String(format: "%.2f", blueSlider.value)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    //MARK: - IB Actions
    @IBAction func doneButton() {
        delegate?.setColor(colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        let stringValue = String(format: "%.2f", sender.value)
        
        updateColorView()
        switch sender {
        case redSlider:
            redValueLabel.text = stringValue
            redTextField.text = stringValue
        case greenSlider:
            greenValueLabel.text = stringValue
            greenTextField.text = stringValue
        default:
            blueValueLabel.text = stringValue
            blueTextField.text = stringValue
        }
    }
}

//MARK: - Private methods
extension SettingViewController {
    private func updateColorView(){
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0
        )
    }
    
    private func parseColorToRGB(_ color: UIColor) -> (
        red: CGFloat,
        green: CGFloat,
        blue: CGFloat
    ) {
        let components = color.cgColor.components ?? [CGFloat(0.0)]
        
        if components.count > 3 {
            return (components[0], components[1], components[2])
        }
        return (components[0], components[0], components[0])
    }
    
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension SettingViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (0...1).contains(Float(textField.text ?? "") ?? -1) {
            return true
        } else {
            showAlert(
                title: "Incorrect input",
                message: "Enter a number in the range from 0 to 1 separated by a dot"
            )
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let value = Float(textField.text ?? "") ?? 0.0
        let formattedText = String(format: "%0.2f", value)
        
        switch textField {
        case redTextField:
            redSlider.setValue(value, animated: true)
            redValueLabel.text = formattedText
        case greenTextField:
            greenSlider.setValue(value, animated: true)
            greenValueLabel.text = formattedText
        default:
            blueSlider.setValue(value, animated: true)
            blueValueLabel.text = formattedText
        }
        updateColorView()
    }
    
    func addToolBar(_ textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.items = [
            UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: nil,
                action: nil
            ),
            UIBarButtonItem(
                barButtonSystemItem: .done,
                target: self,
                action: #selector(complete)
            )
        ]
        
        textField.inputAccessoryView = toolBar
        textField.delegate = self
    }
    
    @objc func complete() {
        view.endEditing(true)
    }
}
