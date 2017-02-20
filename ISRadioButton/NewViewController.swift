//
//  NewViewController.swift
//  ISRadioButton
//
//  Created by Ishaq Shafiq on 19/02/2017.
//  Copyright © 2017 TheGoal. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    @IBOutlet var btn1:ISRadioButton!
    @IBOutlet var btn2:ISRadioButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btn1.isSelected = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        self.btn1.isSelected = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        self.btn1.isSelected = true
    }
    
    @IBAction func btnSelected(_ isRadioButton:ISRadioButton){
        self.btn2.isSelected = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
