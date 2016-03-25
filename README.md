# AGDropdown
iOS Dropdownlist

the AGDropdownList is a single select view like the "select" dom in html, and it's very easy to use it.

below is the example:

		var datasource = [AGDropDownData]()
        datasource.append(AGDropDownData(value: "a_select 1"))
        datasource.append(AGDropDownData(value: "a_select 2"))
        datasource.append(AGDropDownData(value: "a_select 3", icon: UIImage(named: "favorites")))
        datasource.append(AGDropDownData(value: "a_select 4"))
        datasource.append(AGDropDownData(value: "b_select 1", icon: UIImage(named: "search")))
        datasource.append(AGDropDownData(value: "b_select 2", backgroundColor: UIColor.purpleColor()))
        datasource.append(AGDropDownData(value: "b_select 3"))
        let dropdown = AGDropdownList(frame: CGRectMake(100, 100, 250, 30))
        dropdown.groupBy = AGDropDownGroup.ByFirstChar
        dropdown.datasource = datasource
        dropdown.minHeight = 300.0
        dropdown.editable = false
        dropdown.layer.borderColor = UIColor.blackColor().CGColor
        dropdown.layer.borderWidth = 1.0
        self.view.addSubview(dropdown)


![image](https://github.com/xjmeplws/AGDropdown/blob/master/ScreenShots/1.png)

![image](https://github.com/xjmeplws/AGDropdown/blob/master/ScreenShots/2.png)

![image](https://github.com/xjmeplws/AGDropdown/blob/master/ScreenShots/3.png)
