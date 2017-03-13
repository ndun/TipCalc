//
//  SettingsViewController.swift
//  TipCalc
//
//  Created by Nicole Dun on 3/10/17.
//  Copyright © 2017 Nicole Dun. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    static let EXCELLENT_SERVICE_KEY = "tip_excellent_service"
    static let SATISFACTORY_SERVICE_KEY = "tip_satisfactory_service"
    static let TERRIBLE_SERVICE_KEY = "tip_terrible_service"
    static let DEFAULT_SERVICE_KEY = "default_tip_percentage"
    
    @IBOutlet weak var excellentPercentSlider: UISlider!
    @IBOutlet weak var excellentPercentLabel: UILabel!
    
    @IBOutlet weak var satisfactPercentSlider: UISlider!
    @IBOutlet weak var satisfactPercentLabel: UILabel!
    
    @IBOutlet weak var terriblePercentSlider: UISlider!
    @IBOutlet weak var terriblePercentLabel: UILabel!
    
    @IBOutlet weak var tipDefaultControl: UISegmentedControl!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDefaults()
        

    }
    
    func loadDefaults() {
        let defaults = UserDefaults.init()
        let defaultService = defaults.integer(forKey: SettingsViewController.DEFAULT_SERVICE_KEY)
        excellentPercentSlider.value = Float(defaults.integer(forKey: SettingsViewController.EXCELLENT_SERVICE_KEY))
        satisfactPercentSlider.value = Float(defaults.integer(forKey: SettingsViewController.SATISFACTORY_SERVICE_KEY))
        terriblePercentSlider.value = Float(defaults.integer(forKey: SettingsViewController.TERRIBLE_SERVICE_KEY))
        tipDefaultControl.selectedSegmentIndex = defaultService

        updateLabel(excellentPercentSlider)
    }

    @IBAction func updateLabel(_ sender: Any) {
        excellentPercentLabel.text = String(format: "%2.0d%%", Int(excellentPercentSlider.value))
        satisfactPercentLabel.text = String(format: "%2.0d%%", Int(satisfactPercentSlider.value))
        terriblePercentLabel.text = String(format: "%2.0d%%", Int(terriblePercentSlider.value))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveSettings(_ sender: Any) {
        let defaults = UserDefaults.init()
        defaults.set(Int(excellentPercentSlider.value), forKey: SettingsViewController.EXCELLENT_SERVICE_KEY)
        defaults.set(Int(satisfactPercentSlider.value), forKey: SettingsViewController.SATISFACTORY_SERVICE_KEY)
        defaults.set(Int(terriblePercentSlider.value), forKey: SettingsViewController.TERRIBLE_SERVICE_KEY)
        defaults.set(tipDefaultControl.selectedSegmentIndex, forKey: SettingsViewController.DEFAULT_SERVICE_KEY)
        defaults.synchronize()
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

}
