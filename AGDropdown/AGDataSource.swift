//
//  AGDataSource.swift
//  test
//
//  Created by huangyawei on 16/3/22.
//  Copyright © 2016年 xjmeplws. All rights reserved.
//

import Foundation
import UIKit

public class AGDropDownData {
    let icon: UIImage?
    let key: String?
    let value: String?
    let backgroundColor: UIColor?
    
    public init(value: String, key: String? = "", icon: UIImage? = nil, backgroundColor: UIColor? = nil) {
        self.value = value
        self.key = key == "" ? value : key
        self.icon = icon
        self.backgroundColor = backgroundColor
    }
}
public enum AGDropDownGroup {
    case ByFirstChar
    case ByFirstWord
    case ByFullWords
    case NONE
}

class AGDataSource {
    
    class func makeDataSource(datasource: [AGDropDownData], groupBy: AGDropDownGroup?) -> NSArray {
        if let groupBy = groupBy {
            switch groupBy {
            case .ByFirstChar:
                return firstCharDictionary(datasource)
            case .ByFirstWord:
                return firstWordDictionary(datasource)
            case .ByFullWords:
                return fullWordDictionary(datasource)
            case .NONE:
                return noneDictionary(datasource)
            }
        } else {
            return noneDictionary(datasource)
        }
    }
    ///数组不需要分组
    class func noneDictionary(datasource: [AGDropDownData]) -> NSArray {
        let sortedDataSource = defaultGroupDictionary(datasource)
        return [["#": sortedDataSource]]
    }
    
    ///根据字符串的第一个值进行分组排序
    class func firstCharDictionary(datasource: [AGDropDownData]) -> NSArray {
        let sourceKeys = datasource.flatMap { (data: AGDropDownData) -> String in
            return data.value![0...0]
        }
        return getArrayByKeys(sourceKeys, datasource: datasource)
    }
    ///根据字符串的第一个单词进行分组排序
    class func firstWordDictionary(datasource: [AGDropDownData]) -> NSArray {
        let sourceKeys = datasource.flatMap { (data: AGDropDownData) -> String in
            return data.value!.componentsSeparatedByString(" ")[0]
        }
        return getArrayByKeys(sourceKeys, datasource: datasource)
    }
    ///根据字符串进行分组排序
    class func fullWordDictionary(datasource: [AGDropDownData]) -> NSArray {
        let sourceKeys = datasource.flatMap { (data: AGDropDownData) -> String in
            return data.value!
        }
        return getArrayByKeys(sourceKeys, datasource: datasource)
    }
    ///根据key获取数组的字典
    class func getArrayByKeys(sourceKeys: [String], datasource: [AGDropDownData]) -> NSArray {
        let allKeys = clearDuplicate(sourceKeys).sort{ $0 < $1 }
        let array = NSMutableArray()
        for key in allKeys {
            let dic = NSMutableDictionary()
            let datas = datasource.filter{ $0.value![0...(sourceKeys[0].characters.count - 1)] == key }
            dic.setValue(defaultGroupDictionary(datas), forKey: key)
            array.addObject(dic)
            
        }
        return array
    }
    ///去掉重复的key
    private class func clearDuplicate(strings: [String]) -> [String] {
        var tempStrs = [String]()
        for str in strings {
            if !tempStrs.contains(str) {
                tempStrs.append(str)
            }
        }
        return tempStrs
    }
    ///获取数据源的总数
    class func getDataSourceCount(datasource: [AGDropDownData]) -> Int {
        let array = makeDataSource(datasource, groupBy: AGDropDownGroup.NONE)
        return array.count
    }
    
    class func defaultGroupDictionary(datasource: [AGDropDownData]) -> NSArray {
        return datasource.sort{ $0.value! < $1.value! }
    }
    
    class func hexColor(hex: Int) -> UIColor {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}

extension String {
    subscript(r: Range<Int>) -> String {
        let startIndex = self.startIndex.advancedBy(r.startIndex)
        let endIndex = self.startIndex.advancedBy(r.endIndex)
        return self[Range(start: startIndex, end: endIndex)]
    }
}