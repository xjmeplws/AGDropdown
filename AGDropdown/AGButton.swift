//
//  AGButton.swift
//  AGDropdown
//
//  Created by huangyawei on 16/3/22.
//  Copyright © 2016年 xjmeplws. All rights reserved.
//

import Foundation
import UIKit

class AGButton: UIButton {

    private var isRotate = false
    ///button's image
    var image: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if self.image == nil {
            self.image = renderImage()
        }
        self.setImage(self.image, forState: .Normal)
        self.imageEdgeInsets = UIEdgeInsetsMake(0, (self.frame.size.width - 30), 0, 0)
        self.removeTarget(self, action: "rotateSelf", forControlEvents: .TouchUpInside)
        self.addTarget(self, action: "rotateSelf", forControlEvents: .TouchUpInside)
    }
    
    func rotateSelf() {
        guard let rotateImageView = self.imageView else {
            return
        }
        let transform = CGAffineTransformMakeRotation(!isRotate ? CGFloat(M_PI) : 0)
        isRotate = !isRotate
        UIView.animateWithDuration(0.1, animations: {
            rotateImageView.transform = transform
        })
    }
    
    
    private func renderImage() -> UIImage? {
        let renderRect = CGRectMake(0.0, 0.0, 14.0, 10.0)
        UIGraphicsBeginImageContext(renderRect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, AGDataSource.hexColor(0xAAAAAA).CGColor)
        CGContextMoveToPoint(context, 0.0, 0.0)
        CGContextAddLineToPoint(context, 14.0, 0.0)
        CGContextAddLineToPoint(context, 7.0, 10.0)
        CGContextFillPath(context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}