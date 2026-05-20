# Changelog

## 2.0.2 (2026-05-20)

### Bug Fixes

- **修复 format() 替换污染 bug**: 单字符 token（如 `a`/`am`、`A`/`AM`、`m`/`M`）在替换后会污染已替换的内容。例如 `format('MMM a', 'en')` 会把 `January` 中的字母 `a` 替换为 `am`，导致输出 `Jamnuamry`。改用 Unicode 私用区占位符两轮替换，彻底避免二次污染
- **修复 MMM 语言切换失效**: `format('MMM', 'en')` 始终返回中文月份名。原因是 MMM 在构造时被静态设置，`format()` 的 `containsKey("MMM")` 判断跳过了语言切换逻辑。现在每次 `format()` 调用都根据当前语言重新设置 MMM

### Removed

- **移除 `monthStart` 字段**: 该字段来自 Day.js 的 locale 系统，在 dayfl 中无实际作用（`monthStart: 0` 和 `monthStart: 1` 两个分支产生相同结果）。已从 `Locale` 类、内置语言定义和 example 中移除

### Tests

- 测试用例从 47 个扩展到 174 个
- 新增覆盖：构造函数变体、所有 format 占位符、dayFormat 文字格式化、add/subtract 全单位、isBefore/isAfter/isSame/compareTo、difference/diffIn、endOf、MMM 月份缩写中英文、语言包切换、addMatchers/delMatchers、自定义格式解析、边界情况

## 2.0.1

- 修复星期格式化和月份溢出 bug
