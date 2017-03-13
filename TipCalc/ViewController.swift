//
//  ViewController.swift
//  TipCalc
//
//  Created by Nicole Dun on 3/8/17.
//  Copyright © 2017 Nicole Dun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipPercentLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var excellentService: Float!
    var satisfactoryService: Float!
    var terribleService: Float!
    var defaultService: Int!
    var defaults: UserDefaults!
    var tipPercentages: [Float]!
    var currencySymbol:String = ""

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadTipPercentages()
        defaultService = defaults.integer(forKey: SettingsViewController.DEFAULT_SERVICE_KEY)
        tipControl.selectedSegmentIndex = defaultService ?? 1
        tipPercentLabel.text = String(tipPercentages[tipControl.selectedSegmentIndex])
        let locale = Locale.current
        let symbol = locale.currencySymbol!
        currencySymbol = "\(symbol)"
        calculateTip(billField)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    func loadTipPercentages() {
        defaults = UserDefaults.init()
        let dt = defaults.integer(forKey: SettingsViewController.TERRIBLE_SERVICE_KEY)
        let de = defaults.integer(forKey: SettingsViewController.EXCELLENT_SERVICE_KEY)
        let ds = defaults.integer(forKey: SettingsViewController.SATISFACTORY_SERVICE_KEY)
        excellentService = defaults.float(forKey: SettingsViewController.EXCELLENT_SERVICE_KEY)/100.00
        satisfactoryService = defaults.float(forKey: SettingsViewController.SATISFACTORY_SERVICE_KEY)/100.00
        terribleService = defaults.float(forKey: SettingsViewController.TERRIBLE_SERVICE_KEY)/100.00
        print(String(format: "defaults %.2f - %.2f - %.2f"), dt, ds, de)
        print(String(format: "%.2f  %.2f  %.2f"), excellentService, satisfactoryService, terribleService)
        tipPercentages = [terribleService, satisfactoryService, excellentService]
        calculateTip(billField)
    }
   
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Float(billField.text!) ?? 0
        let tip = (bill * tipPercentages[tipControl.selectedSegmentIndex])
        let total = tip + bill
        let percent = tipPercentages[tipControl.selectedSegmentIndex] * 100
        
        tipLabel.text = String(format: "\(currencySymbol)%.2f", tip)
        totalLabel.text = String(format: "\(currencySymbol)%.2f", total)
        
        tipPercentLabel.text = String(format: "%3.0f %%", percent)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTipPercentages()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        print("view did disappear")
    }
}

