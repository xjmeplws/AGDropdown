//
//  AGDropdown.swift
//  AGDropdown
//
//  Created by huangyawei on 16/3/22.
//  Copyright © 2016年 xjmeplws. All rights reserved.
//

import UIKit

class AGDropdown: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        //set a split line
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 1.0)
        CGContextSetRGBStrokeColor(context, 210.0, 210.0, 210.0, 1)
        CGContextSetRGBFillColor(context, 210.0, 210.0, 210.0, 1)
        CGContextMoveToPoint(context, rect.width - 30.0, 0)
        CGContextAddLineToPoint(context, rect.width - 30.0, rect.height)
        
        let agButton = AGButton(frame: CGRectMake(rect.width - 30.0, 0, 30.0, rect.height))
        self.addSubview(agButton)
    }
}
