//
//  AGDropdown.swift
//  AGDropdown
//
//  Created by huangyawei on 16/3/22.
//  Copyright © 2016年 xjmeplws. All rights reserved.
//

import UIKit

public class AGDropdownList: UITextField, UITableViewDataSource, UITableViewDelegate {
    ///button
    private var agButton: AGButton?
    ///local datasource
    private var agDropDownDataArray: NSArray?
    
    public var key: String?
    
    ///group style
    public var groupBy: AGDropDownGroup?
    ///datasource
    public var datasource: [AGDropDownData]? {
        didSet {
            agDropDownDataArray = AGDataSource.makeDataSource(datasource!, groupBy: groupBy)
        }
    }
    ///是否可作为文本框进行编辑
    public var editable: Bool = true {
        didSet {
            let agX = editable ? self.frame.width - 30.0 : 0
            let agWidth = editable ? 30.0 : self.frame.width
            agButton?.frame = CGRectMake(agX, 0, agWidth, self.frame.height)
        }
    }
    ///下拉框最大高度
    public var maxHeight: CGFloat = 150.0 {
        didSet {
            guard let height = agTableView?.frame.height else {
                return
            }
            if height > maxHeight {
                agTableView?.frame.size.height = maxHeight
            }
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        groupBy = AGDropDownGroup.NONE
        self.clipsToBounds = true
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let agX = editable ? rect.width - 30.0 : 0
        let agWidth = editable ? 30.0 : rect.width
        agButton = AGButton(frame: CGRectMake(agX, 0, agWidth, rect.height))
        agButton?.removeTarget(self, action: "singleSelect:", forControlEvents: .TouchUpInside)
        agButton?.addTarget(self, action: "singleSelect:", forControlEvents: .TouchUpInside)
        self.addSubview(agButton!)
    }
    
    private var agTableView: UITableView?
    ///下拉选项是否已显示
    private var isDropDownShowed = false
    func singleSelect(sender: UIButton) {
        guard let parentView = self.superview else {
            return
        }
        if agTableView == nil {
            agTableView = UITableView(frame: CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.height, self.frame.width, maxHeight))
            agTableView?.dataSource = self
            agTableView?.delegate = self
            agTableView?.separatorStyle = .None
            agTableView?.tableFooterView = nil
            agTableView?.layer.borderColor = AGDataSource.hexColor(0xA4A4A4).CGColor
            agTableView?.layer.borderWidth = 1.0
            parentView.addSubview(agTableView!)
        }
        toggleShowed()
    }
    
    //single selection tableview
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let agDropDownDataArray = agDropDownDataArray else {
            return 0
        }
        return agDropDownDataArray.count
    }
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (agDropDownDataArray![section] as! NSDictionary).allValues[0].count
    }
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("AGDropDownListCell") as? AGDropDownCell
        if cell == nil {
            tableView.registerClass(AGDropDownCell.classForCoder(), forCellReuseIdentifier: "AGDropDownListCell")
            cell = tableView.dequeueReusableCellWithIdentifier("AGDropDownListCell") as? AGDropDownCell
        }
        let data = (agDropDownDataArray![indexPath.section] as! NSDictionary).allValues[0][indexPath.row] as? AGDropDownData
        
        cell?.frame.size.height = self.frame.height
        cell?.configCell(data)
        if data?.backgroundColor == nil {
            if indexPath.row % 2 != 0 {
                cell?.backgroundColor = AGDataSource.hexColor(0xEFEFEF)
            }
        }
        
        return cell!
    }
    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if groupBy == nil || groupBy == AGDropDownGroup.NONE {
            return nil
        }
        
        return (agDropDownDataArray?[section] as! NSDictionary).allKeys[0] as? String
    }
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let data = (agDropDownDataArray![indexPath.section] as! NSDictionary).allValues[0][indexPath.row] as? AGDropDownData
        self.text = data?.value
        self.key = data?.key
        toggleShowed()
        agButton?.rotateSelf()
    }
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.frame.height
    }
    //end selection
    
    ///控制下拉显示和按钮样式
    private func toggleShowed() {
        agTableView?.alpha = isDropDownShowed ? 0 : 1
        isDropDownShowed = !isDropDownShowed
    }
    
    deinit {
        agButton = nil
        agButton?.removeFromSuperview()
        agTableView?.delegate = nil
        agTableView?.dataSource = nil
        agTableView?.removeFromSuperview()
        agTableView = nil
        agDropDownDataArray = nil
        datasource = nil
    }
}
