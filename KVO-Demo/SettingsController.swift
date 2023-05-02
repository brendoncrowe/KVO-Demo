//
//  SettingsController.swift
//  KVO-Demo
//
//  Created by Brendon Crowe on 5/2/23.
//

import UIKit

@objc class SettingsController: UIViewController {
    
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    private var fontSizeObservation: NSKeyValueObservation?
    var iconNames = ["sun.haze.fill", "moon", "globe", "icloud"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
        configureFontSizeObservation()
    }
    
    private func configurePickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    // This class can observe too in order to change its ui
    private func configureFontSizeObservation() {
        fontSizeObservation = Settings.shared.observe(\.fontSize, options: [.old, .new], changeHandler: { [weak self] (settings, change) in
            guard let newSize = change.newValue else { return }
            self?.fontSizeLabel.text = "font size: \(Int(newSize))"
        })
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let newSize = Int(sender.value) // cast Float to Int as our Settings fontSize is an Int
        Settings.shared.fontSize = newSize
        // after setting the fontSize on the Settings class
        // the WelcomeViewController will be updated via KVO
    }
}

extension SettingsController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        iconNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        iconNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let iconName = iconNames[row]
        Settings.shared.iconName = iconName
        // after setting the iconName on the Settings class the WelcomeViewController will be updated via KVO
    }
}
