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
    @IBOutlet var scroll:UIScrollView!
    @IBOutlet var btnAttributed1:ISRadioButton!
    @IBOutlet var btnAttributed2:ISRadioButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scroll.contentSize =  CGSize(width: 320, height: 700)
        self.addISButtonViaCode()
    }
    
    func addISButtonViaCode(){
        lblViaCode.text = "Added via code"
        
        let firstRadioButton:ISRadioButton = ISRadioButton(frame: CGRect(x: 20, y: 465, width: 200, height: 25))
        firstRadioButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        firstRadioButton.setTitle("Custom Button with icon", for:UIControlState())
        firstRadioButton.iconColor = UIColor.magenta
        firstRadioButton.indicatorColor = UIColor.magenta
        firstRadioButton.setTitleColor(UIColor.black, for: UIControlState())
        firstRadioButton.tag = 0
        firstRadioButton.icon = UIImage(named: "thumbs-up")
        firstRadioButton.iconSelected = UIImage(named: "thumbs-down")
        
        // Uncomment this to put icon on the right side
        //            radio.iconOnRight = true;

        firstRadioButton.multipleSelectionEnabled = true
        firstRadioButton.addTarget(self, action: #selector(ISViewController.logSelectedButton(_:)), for: .touchUpInside)
        self.scroll.addSubview(firstRadioButton)
        
        let otherTitless:NSArray = NSArray(objects:"Custom square Button","Custom circuler Button" )
        
        let otherButtons:NSMutableArray = NSMutableArray();
        
        for i in 1...2 {
            let radio:ISRadioButton = ISRadioButton(frame: CGRect(x: 30,y: CGFloat(
                465+(30 * i)),width: 200, height: 25))
            radio.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
            radio.setTitle(otherTitless.object(at: i-1) as? String, for:UIControlState())
            radio.setTitleColor(UIColor.black, for:UIControlState())
            radio.iconOnRight = false;
            
            if (i == 1) {
                radio.iconSquare = true
            } else {
                radio.iconSquare = false;
            }
            
// Uncomment this to put icon on the right side
//            radio.iconOnRight = true;
            radio.multipleSelectionEnabled = true
            radio.iconColor = UIColor.black
            radio.indicatorColor = UIColor.black
            radio.addTarget(self, action: #selector(ISViewController.logSelectedButton(_:)), for:.touchUpInside)
            otherButtons.add(radio)
            self.scroll.addSubview(radio)
            
        }
        firstRadioButton.otherButtons = (otherButtons as AnyObject as! Array<ISRadioButton>)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func logSelectedButton(_ isRadioButton:ISRadioButton){
        
        if isRadioButton.tag == 1000 {
            
            if isRadioButton.isEqual(self.btnAttributed1) {
                
                let myString = NSMutableAttributedString(string:"New Text")
                
                myString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSRange(location:0, length: 3))
                myString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: NSRange(location:4, length: 4))
                self.btnAttributed1.setAttributedTitle(myString, for: .normal)
                
                let myString2 = NSMutableAttributedString(string:"Old Text")
                
                myString2.addAttribute(NSForegroundColorAttributeName, value: UIColor.green, range: NSRange(location:0, length: 3))
                myString2.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: NSRange(location:4, length: 4))
                self.btnAttributed2.setAttributedTitle(myString2, for: .normal)
 
            }else{
                
                let myString = NSMutableAttributedString(string:"New Text")
                
                myString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSRange(location:0, length: 3))
                myString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: NSRange(location:4, length: 4))
                self.btnAttributed2.setAttributedTitle(myString, for: .normal)
                
                let myString2 = NSMutableAttributedString(string:"Old Text")
                
                myString2.addAttribute(NSForegroundColorAttributeName, value: UIColor.green, range: NSRange(location:0, length: 3))
                myString2.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: NSRange(location:4, length: 4))
                self.btnAttributed1.setAttributedTitle(myString2, for: .normal)
            }
            
        }else{
            if isRadioButton.multipleSelectionEnabled{
                for radioButton in isRadioButton.otherButtons! {
                    print("%@ is selected.\n", radioButton.titleLabel!.text ?? "");
                }
            }else{
                print("%@ is selected.\n", isRadioButton.titleLabel!.text ?? "");
            }
        }
    }
}

