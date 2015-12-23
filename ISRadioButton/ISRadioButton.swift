//
//  ISRadioButton.swift
//  DaynamicForm
//
//  Created by Ishaq Shafiq on 09/12/2015.
//  Copyright © 2015 TheGoal. All rights reserved.
//

import UIKit

@IBDesignable
class  ISRadioButton: UIButton {
    
    var indexPath:NSIndexPath!
    
//      Container for holding other buttons in same group.
    
    @IBOutlet var otherButtons: Array<ISRadioButton>?
    
//      Size of icon, default is 15.0.
    
    @IBInspectable var iconSize:CGFloat = 15.0
    
//    Size of selection indicator, default is iconSize * 0.5.

    @IBInspectable var indicatorSize:CGFloat = 15.0 * 0.5
    
//      Color of icon, default is black
    
    @IBInspectable var iconColor:UIColor =  UIColor.blackColor()
    
//      Stroke width of icon, default is iconSize / 9.
    
    @IBInspectable var iconStrokeWidth:CGFloat = 1.6
    
//      Color of selection indicator, default is black
    
    @IBInspectable var indicatorColor:UIColor = UIColor.blackColor()
    
//      Margin width between icon and title, default is 10. 0.

    @IBInspectable var marginWidth:CGFloat = 10.0

//      Whether icon on the right side, default is NO.

    @IBInspectable var iconOnRight:Bool = false
    
//      Whether use square icon, default is NO.
    
    @IBInspectable var iconSquare:Bool = false
    
//      Image for radio button icon (optional).
    
    @IBInspectable var icon:UIImage!
    
//      Image for radio button icon when selected (optional).
    
    @IBInspectable var iconSelected:UIImage!
   
//      Whether enable multiple selection, default is NO.

     @IBInspectable var multipleSelectionEnabled:Bool = false
    
    var isChaining:Bool = false
    
    private var setOtherButtons:NSArray {
        
        get{
           return otherButtons!
        }
        set (newValue) {
            if !isChaining {
                otherButtons = newValue as? Array<ISRadioButton>
                isChaining = true
                for radioButton in otherButtons!{
                    let others:NSMutableArray = NSMutableArray(array:otherButtons!)
                    others.addObject(self)
                    others.removeObject(radioButton)
                    radioButton.setOtherButtons = others
                }
                isChaining = false
            }
        }
    }

   @IBInspectable var setIcon:UIImage {

        // Avoid to use getter it can be nill
        
        get{
            return icon
        }
        
        set (newValue){
            icon = newValue
            self.setImage(icon, forState: .Normal)
        }
    }
    
    @IBInspectable var setIconSelected:UIImage {
        
        // Avoid to use getter it can be nill
        
        get{
            return iconSelected
        }
        
        set (newValue){
            iconSelected = newValue
            self.setImage(iconSelected, forState: .Selected)
            self.setImage(iconSelected, forState: .Highlighted)
        }
    }
    
    var setMultipleSelectionEnabled:Bool {
        
        get{
            return multipleSelectionEnabled
        }
        set (newValue) {
            if !isChaining {
                isChaining = true
                multipleSelectionEnabled = newValue
                
                if self.otherButtons != nil {
                    for radioButton in self.otherButtons!{
                        radioButton.multipleSelectionEnabled = newValue
                    }
                }
                isChaining = false
            }
        }
    }
    
// MARK: -- Helpers
    
    func drawButton (){
        if (icon == nil ||  self.icon.accessibilityIdentifier == "Generated Icon"){
            self.setIcon = self.drawIconWithSelection(false)
        }else{
            self.setIcon = icon
        }
        if (iconSelected == nil ||  self.iconSelected.accessibilityIdentifier == "Generated Icon"){
            self.setIconSelected = self.drawIconWithSelection(true)
        }else{
            self.setIconSelected = iconSelected
        }
        
        if self.otherButtons != nil {
            self.setOtherButtons = self.otherButtons!
        }
        
        if multipleSelectionEnabled {
            self.setMultipleSelectionEnabled = multipleSelectionEnabled
        }
        
        if self.iconOnRight {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, self.frame.size.width - self.icon.size.width + marginWidth, 0, 0);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, marginWidth + self.icon.size.width);
            self.contentHorizontalAlignment = .Right
        } else {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, marginWidth, 0, 0);
            self.titleLabel?.textAlignment = .Left
            self.contentHorizontalAlignment = .Left
        }
        self.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func drawIconWithSelection (selected:Bool) -> UIImage{
        let rect:CGRect = CGRectMake(0, 0, iconSize, iconSize)

        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0);
        let context  = UIGraphicsGetCurrentContext()
//        UIGraphicsPushContext(context!)
        // draw icon
        
        var iconPath:UIBezierPath!
        let iconRect:CGRect = CGRectMake(iconStrokeWidth / 2, iconStrokeWidth / 2, iconSize - iconStrokeWidth, iconSize - iconStrokeWidth);
        if self.iconSquare {
            iconPath = UIBezierPath(rect:iconRect )
        } else {
            iconPath = UIBezierPath(ovalInRect:iconRect)
        }
        iconColor.setStroke()
        iconPath.lineWidth = iconStrokeWidth;
        iconPath.stroke()
        CGContextAddPath(context, iconPath.CGPath);

         // draw indicator
        if (selected) {
            var indicatorPath:UIBezierPath!
            let indicatorRect:CGRect = CGRectMake((iconSize - indicatorSize) / 2, (iconSize - indicatorSize) / 2, indicatorSize, indicatorSize);
            if self.iconSquare {
                indicatorPath = UIBezierPath(rect:indicatorRect )
            } else {
                indicatorPath = UIBezierPath(ovalInRect:indicatorRect)
            }
            indicatorColor.setStroke()
            indicatorPath.lineWidth = iconStrokeWidth;
            indicatorPath.stroke()
            
            indicatorColor.setFill()
            indicatorPath.fill()
            CGContextAddPath(context, indicatorPath.CGPath);
        }
        
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsPopContext()
        UIGraphicsEndImageContext();
        
        image.accessibilityIdentifier = "Generated Icon";
        return image;
    }
    
    func touchDown () {
        self.selected = true
    }
    
    func initRadioButton () {
        super.addTarget(self, action:"touchDown", forControlEvents:.TouchUpInside)
        self.selected = false
    }
    
    override func prepareForInterfaceBuilder () {
        self.initRadioButton()
        self.drawButton()
    }

    // MARK: -- ISRadiobutton
    
    //    @return Selected button in same group.
    
    func selectedButton() -> ISRadioButton!{
        if !self.multipleSelectionEnabled {
            if self.selected {
                return self
            }
        }else{
            for isRadioButton in self.otherButtons!  {
                if isRadioButton.selected {
                    return isRadioButton
                }
            }
        }
        return nil
    }
    
    //    @return Selected buttons in same group, use it only if multiple selection is enabled.
    
    func selectedButtons() -> NSMutableArray{
        
        let selectedButtons:NSMutableArray = NSMutableArray ()
        if self.selected {
           selectedButtons.addObject(self)
        }
        for isRadioButton in self.otherButtons!  {
            if isRadioButton.selected {
                selectedButtons .addObject(self)
            }
        }
        return selectedButtons;
    }
    
    //    Clears selection for other buttons in in same group.
    
    func deselectOtherButtons() {
        if self.otherButtons != nil {
            for isRadioButton in self.otherButtons!  {
                isRadioButton.selected = false
            }
         }
    }
    
    //    @return unselected button in same group.
    
    func unSelectedButtons() -> NSArray{
        let unSelectedButtons:NSMutableArray = NSMutableArray ()
        if self.selected {
            unSelectedButtons .addObject(self)
        }
        for isRadioButton in self.otherButtons!  {
            if isRadioButton.selected {
                unSelectedButtons .addObject(self)
            }
        }
        return unSelectedButtons ;
    }
    
    // MARK: -- UIButton
    
    override func titleColorForState(state:UIControlState) -> UIColor{
        if (state == UIControlState.Selected || state == UIControlState.Highlighted){
            var selectedOrHighlightedColor:UIColor!
            if (state == UIControlState.Selected) {
                selectedOrHighlightedColor = super.titleColorForState(.Selected)
            }else{
                selectedOrHighlightedColor = super.titleColorForState(.Highlighted)
            }
            self.setTitleColor(selectedOrHighlightedColor, forState: .Selected)
            self.setTitleColor(selectedOrHighlightedColor, forState: .Highlighted)
        }
        return super.titleColorForState(state)!
    }
    
    // MARK: -- UIControl
    
    override var selected: Bool {
        didSet(oldValue) {
            if (multipleSelectionEnabled) {
                if oldValue == true && self.selected == true {
                    self.selected = false
                }
            }
            else {
                if selected {
                    self.deselectOtherButtons()
                }
            }
        }
    }
    
    // MARK: -- UIView

    required internal init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.initRadioButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initRadioButton()
    }
    
    override func drawRect(rect:CGRect) {
        super.drawRect(rect)
        self.drawButton()
    }
}
