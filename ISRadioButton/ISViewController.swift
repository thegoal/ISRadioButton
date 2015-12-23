//
//  ViewController.swift
//  ISRadioButton
//
//  Created by Ishaq Shafiq on 10/12/2015.
//  Copyright © 2015 TheGoal. All rights reserved.
//

import UIKit

class ISViewController: UIViewController {

    @IBOutlet var lblViaCode:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addISButtonViaCode()
    }
    
    func addISButtonViaCode(){
        lblViaCode.text = "Added via code"
        
        let firstRadioButton:ISRadioButton = ISRadioButton(frame: CGRectMake(20, 360, 200, 25))
        firstRadioButton.titleLabel?.font = UIFont.systemFontOfSize(14.0)
        firstRadioButton.setTitle("Custom in Red", forState:.Normal)
        firstRadioButton.iconColor = UIColor.magentaColor()
        firstRadioButton.indicatorColor = UIColor.magentaColor()
        firstRadioButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        firstRadioButton.tag = 0
        firstRadioButton.icon = UIImage(named: "thumbs-up")
        firstRadioButton.iconSelected = UIImage(named: "thumbs-down")
        
        // Uncomment this to put icon on the right side
        //            radio.iconOnRight = true;

        firstRadioButton.multipleSelectionEnabled = true
        firstRadioButton.addTarget(self, action: "logSelectedButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(firstRadioButton)
        
        let otherTitless:NSArray = NSArray(objects: "Custom Button with icon" ,"Custom circuler Button" ,"Custom square Button")
        
        let otherButtons:NSMutableArray = NSMutableArray();
        
        for i in 1...2 {
            let radio:ISRadioButton = ISRadioButton(frame: CGRectMake(30,CGFloat(
                360+(30 * i)),200, 25))
            radio.titleLabel?.font = UIFont.systemFontOfSize(14.0)
            radio.setTitle(otherTitless.objectAtIndex(i-1) as? String, forState:.Normal)
            radio.setTitleColor(UIColor.blackColor(), forState:.Normal)
            radio.iconOnRight = false;
            
            if (i == 1) {
                radio.iconSquare = true
            } else {
                radio.iconSquare = false;
            }
            
            // Uncomment this to put icon on the right side
//            radio.iconOnRight = true;
            
            radio.multipleSelectionEnabled = true
            radio.iconColor = UIColor.blackColor()
            radio.indicatorColor = UIColor.blackColor()
            radio.addTarget(self, action: "logSelectedButton:", forControlEvents:.TouchUpInside)
            otherButtons.addObject(radio)
            self.view.addSubview(radio)
            
        }
        firstRadioButton.otherButtons = (otherButtons as AnyObject as! Array<ISRadioButton>)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func logSelectedButton(isRadioButton:ISRadioButton){
        if isRadioButton.multipleSelectionEnabled{
            for radioButton in isRadioButton.otherButtons! {
              print("%@ is selected.\n", radioButton.titleLabel!.text);
            }
        }else{
            print("%@ is selected.\n", isRadioButton.titleLabel!.text);
        }
    }
}

