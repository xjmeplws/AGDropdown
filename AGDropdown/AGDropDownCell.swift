//
//  AGDropDownCell.swift
//  test
//
//  Created by huangyawei on 16/3/25.
//  Copyright © 2016年 xjmeplws. All rights reserved.
//

import UIKit

class AGDropDownCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(data: AGDropDownData?) {
        guard let data = data else {
            return
        }
        for v in self.contentView.subviews {
            v.removeFromSuperview()
        }
        self.backgroundColor = data.backgroundColor
        var label: UILabel
        if let img = data.icon {
            let imgView = UIImageView(frame: CGRectMake(5, 3, frame.height - 6, frame.height - 6))
            imgView.image = img
            self.contentView.addSubview(imgView)
            label = UILabel(frame: CGRectMake(frame.height + 3, 0, frame.width - frame.height - 3, frame.height))
        } else {
            label = UILabel(frame: CGRectMake(5, 0, frame.width - 5, frame.height))
        }
        label.text = data.value
        self.contentView.addSubview(label)
    }
}
