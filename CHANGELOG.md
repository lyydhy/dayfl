## 0.1.2
* Dayfl().isUtc() 改成get方法 Dayfl().isUtc
* Dayfl().isLeapYear() 改成get方法 Dayfl().isLeapYear
* Dayfl().valueOf() 改成get方法 Dayfl().valueOf
* Dayfl().daysInMonth() 改成get方法 Dayfl().daysInMonth
* 去掉isDayfl 方法

## 0.1.1
* 添加语言包做了名称检测

## 0.1.0
* 新增方法 isLeapYear 判断是否是闰年
* 新增方法 daysInMonth 获取月份的天数
* 新增方法 isDayfl 判断是否是Dayfl类型
* 新增方法 isSame 判断两个日期是否相同 可根据单位决定
* 新增方法 getWeek 获取星期  返回map 值有 num(数字), text(文字)
* 新增静态方法 addLocale 添加语言包 没有做任何验证 请按照示例完整写入
* 新增方法 getLocale 获取当前使用的语言包
* 调整add 和 subtract 方法原来的只能加减天数单位的问题
* 格式化参数新增 W 和 WW  星期
* 实例新增第三个参数字段 locale 指定语言包

## 0.0.8
* 修复纯字符串日期解析

## 0.0.7
* 修改获取返回datetime 方法为 get方法 => Dayfl().dateTime
* 修改添加自定义格式化参数的方法传参 为 dayfl

## 0.0.6

* 添加平台支持
* 添加方法 isUtc
* 添加方法 compareTo
* 添加方法 delMatchers 删除自定义添加的参数

## 0.0.5

* 优化文档注释
* 新增 添加自定义格式化参数

## 0.0.4

* 优化解析代码
* 优化格式化代码

## 0.0.3

* 优化代码
* 新增格式化参数

## 0.0.2

* 优化代码

## 0.0.1

* 第一次提交
