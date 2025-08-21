## 2.0.0
* 🎯 **纯Dart实现**: 完全使用Dart语言编写，无需原生平台依赖
* 🌍 **跨平台支持**: 支持iOS、Android、Web、Windows、macOS、Linux等所有Flutter支持的平台
* ⚡ **性能优化**: 进一步优化核心算法，提升日期处理性能
* 🛡️ **稳定性增强**: 加强边界条件处理，提升库的稳定性和可靠性
* 📦 **零依赖**: 保持轻量级特性，无第三方依赖

## 1.0.4
* ✨ 新增 `diffIn` 方法，支持计算两个时间的差值并可自定义单位（年、月、日、时、分、秒）。
* 🔧 支持与 Dayfl 对象或 DateTime 对象进行时间差计算。
* 📊 返回指定单位的时间差值（整数类型），支持正负值表示时间前后关系。
* 🧪 为 `diffIn` 方法添加了全面的测试用例，包括跨年月份计算等边界情况。

## 1.1.0
* ✨ 新增 `endOf` 方法，用于获取指定时间单位的末尾时间点 (例如 `endOf(DateLocationEnum.month)` 获取当月最后一天)。
* 🐛 修复了 `format` 方法中毫秒 (`SSS`) 格式化不正确的问题。
* 🧪 为 `endOf` 方法添加了完整的测试用例。

## 1.0.3
* 🐛 修复 Android 平台构建时因 `namespace` 未在 `build.gradle` 文件中定义而导致的构建失败问题。

## 1.0.2
* ✨ 新增链式调用方法：setYear、setMonth、setDay、setHour、setMinute、setSecond
* 🔗 支持方法链式调用，提升API易用性和代码可读性
* 📝 示例：`Dayfl().setYear(2025).setMonth(12).setDay(25).format()`
* 🛡️ 保持与原setter相同的参数验证逻辑
* 🔄 向后兼容：原有setter属性仍然可用
* 🧪 新增完整的测试用例覆盖所有链式调用方法
* 📚 更新示例代码展示链式调用用法

## 1.0.1
* 📖 重新设计README文档，提升项目展示效果
* ✨ 添加项目徽章（版本、许可证、Dart/Flutter版本要求）
* 🎨 优化文档结构，使用Emoji图标增强视觉效果
* 📚 完善使用示例，添加多种场景的代码演示
* 📋 重新组织格式化参数表，按功能分类展示
* 🌍 添加多语言支持说明
* 🤝 完善开源项目标准信息（贡献指南、许可证、致谢）

## 1.0.0
* 🎉 重大版本更新 - 全面代码审查和优化
* 🐛 修复12小时制转换逻辑，正确处理午夜0点显示为12点的情况
* 🐛 修复dayFormat逻辑，改进条件判断，使用else if避免重复执行
* 🐛 修复数组越界问题，在访问月份缩写数组时添加边界检查
* 🐛 优化时间戳处理，智能识别毫秒、秒时间戳和年份
* 🛡️ 增强异常处理：在_set方法中添加参数和年份范围验证
* 🛡️ 增强空值检查：在getLocale方法中确保语言包不为空
* 🛡️ 改进错误信息：在_object方法中提供更具体的错误描述
* 🔒 提升类型安全：在isBefore、isAfter、difference和compareTo方法中添加空值检查
* 🔒 加强参数验证：确保传入的Dayfl对象包含有效的日期时间
* 🔒 增强字符串验证：检查空字符串和无效格式
* ⚡ 性能优化：在format方法中避免重复调用getLocale
* ⚡ 缓存优化：在_init方法中减少重复的int.parse调用
* ⚡ 字符串优化：使用padLeft替代循环拼接零字符
* ⚡ 新增_getWeekInfo辅助方法提高周信息获取效率
* 🔄 代码重构：创建_isValidDateParam和_convertToSafeDayfl通用验证方法
* 🔄 消除重复代码：统一日期参数验证和转换逻辑
* 🔄 提高可维护性：将重复的类型检查逻辑抽取为可复用方法

## 0.1.5
* format 新增第三个参数dayFormat 可传bool或者带参的function 主要是实现 类似于小于10s 返回刚刚这种文字

## 0.1.4
* 调整compileSdkVersion 和 targetSdkVersion 为31

## 0.1.3
* 添加空判断 解析日期错误时 不在是当前时间， 正常报错部分方法返回null或者空字符串
* 新增方法 toArray 返回List<int>  示例：dayfl('2019-01-25').toArray() // [ 2019, 0, 25, 0, 0, 0, 0 ]

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
