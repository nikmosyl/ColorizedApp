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
    
    //MARK: - Public properties
    var color: UIColor!
    
    weak var delegate: SettingViewControllerDelegate?
    
    //MARK: - Overide methods
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 20
        colorView.backgroundColor = color
        
        let components = parseColorToRGB(color)
        
        redSlider.value = Float(components.red)
        greenSlider.value = Float(components.green)
        blueSlider.value = Float(components.blue)
        
        redValueLabel.text = String(format: "%.2f", redSlider.value)
        greenValueLabel.text = String(format: "%.2f", greenSlider.value)
        blueValueLabel.text = String(format: "%.2f", blueSlider.value)
    }
    
    //MARK: - IB Actions
    @IBAction func doneButton() {
        delegate?.setColor(colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        updateColorView()
        switch sender {
        case redSlider:
            redValueLabel.text = String(format: "%.2f", sender.value)
        case greenSlider:
            greenValueLabel.text = String(format: "%.2f", sender.value)
        default:
            blueValueLabel.text = String(format: "%.2f", sender.value)
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
            return (
                components[0],
                components[1],
                components[2]
            )
        }
        return (
            components[0],
            components[0],
            components[0]
        )
    }
}
