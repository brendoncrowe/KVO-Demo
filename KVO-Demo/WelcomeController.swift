//
//  ViewController.swift
//  KVO-Demo
//
//  Created by Brendon Crowe on 5/2/23.
//

import UIKit

class WelcomeController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    private var fontSizeObservation: NSKeyValueObservation?
    private var iconNameObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObservers()
    }
    
    private func configureObservers() {
        configureFontSizeObservation()
        configureIconNameObservation()
    }
    
    private func configureFontSizeObservation() {
        fontSizeObservation = Settings.shared.observe(\.fontSize, options: [.old, .new], changeHandler: { [weak self] (settings, change) in
            guard let newSize = change.newValue else { return }
            // update UI for font
            let fontSize = CGFloat(newSize)
            self?.welcomeLabel.font = UIFont.systemFont(ofSize: fontSize)
        })
    }
    
    private func configureIconNameObservation() {
        iconNameObservation = Settings.shared.observe(\.iconName, options: [.old, .new], changeHandler: { [weak self] (settings, change) in
            // update ui for image icon
            guard let iconName = change.newValue else { return }
            self?.iconImageView.image = UIImage(systemName: iconName)
        })
    }
    
    deinit { // gets called when the object is no longer in memory
        fontSizeObservation?.invalidate()
        iconNameObservation?.invalidate()
    }
}
