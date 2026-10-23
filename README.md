# iPomodoro-Flutter

<img src="logo.png" width="300" height:auto alt="logo.png"/>

iPomodoro(爱番茄)。🍅 番茄工作法是一种时间管理法方法，在上世纪八十年代由Francesco Cirillo创立。 该方法使用一个定时器来分割出一个一般为25分钟的工作时间和5分钟的休息时间，而那些时间段被称为pomodori，为意大利语单词pomodoro之复数。


## iPomodoro(爱番茄🍅)
爱番茄是一个简单和有效的番茄工作法的应用，灵感来自 iOS app `我要当学霸` 和 macOS app `Promodoro Timer`，这2个App已经下架多年了，所以，想以此为基础，开发Android/iOS/macOS版本，并且开源，所有平台暂定免费下载，计划内置打赏机制，iOS/macOS版本不定时收费1人民币(苹果开发账号费)。


## 简介

- 分心？❌
- 拖延？❌
- 高效？✅
- 专注？✅

iPomodoro(爱番茄)

【功能简介】
番茄时间管理和学习规划，妈妈再也不用担心我的学习啦！不再分心！不再拖延！高效！专注！，让大家在学习时可以更加专注也可以快速和简单的学习get!

【三大特点】
1、番茄学习模式，使用番茄工作法学习，让你劳逸结合！
2、计时学习模式，按照设定的时长学习，想学多久就学多久！
3、定时任务模式，倒数日、任务记录，每日学习任务！

杜绝学习没有目标！满足你对学习的求知欲望！


**番茄学习**
- 使用番茄工作法学习

**计时学习**
- 按照设定的时长学习
- 在「计时」页切换「倒计时 / 正计时」。正计时从零开始，支持暂停、继续，点击「结束」可查看本次专注时长。
- 正计时在应用退到后台后继续累计，暂停时不累计；结束后归零，并将本次记录保存到专注日历。

**专注日历与统计**
- 底部「统计」入口包含月历和每日时间轴，可查看开始/结束时间、实际专注时长、暂停时长和复盘备注。
- 番茄钟、倒计时完成后，以及正计时手动结束后自动保存；倒计时和番茄钟中途结束会标记为「中途结束」。番茄钟休息不计入专注记录。
- 支持日、周、月、年、累计概览，展示专注时长、专注天数、完成与中途结束次数、趋势、模式分布和年度热力图。点击趋势柱或热力图日期可继续查看对应记录。
- 记录可补充标题与备注、确认删除，也可通过右上角「+」补记过去的专注。开始和结束时间不可晚于当前时间。
- 暂停不计入时长；跨午夜的专注时段分摊到实际日期，次数计入开始日期。日均专注按有专注记录的天数计算。
- 历史记录通过 SharedPreferences 保存在本机，重开应用后可读取；不会上传云端。升级前的专注没有历史数据，可手动补记。正在进行的会话不会在应用被终止后恢复；保存失败时保留当前会话，支持重试。

验证计时功能（需 Flutter SDK）：

```bash
cd app
flutter pub get
flutter test
```

请不要
放弃治疗！
好好学习
你还有救！


### 下载&安装

1、商店安装

| 已上架的商店 | 下载地址 | 备注 |
|--------|---|---|
| 苹果商店   | [https://apps.apple.com/cn/app/ipomodoro/id6775220048](https://apps.apple.com/cn/app/ipomodoro/id6775220048)  | SwiftUI 版本 |
| 苹果商店   | ~~[https://apps.apple.com/cn/app/ipomodoro/id1439666929](https://apps.apple.com/cn/app/ipomodoro/id1439666929)~~  | Flutter 版本(不再维护） |
| 谷歌商店   | [https://play.google.com/store/apps/details?id=com.iHTCboy.iPomodoros](https://play.google.com/store/apps/details?id=com.iHTCboy.iPomodoros) | 可供下载 |
| ~~华为商店~~   | [https://appgallery.huawei.com/#/app/C103911977](https://appgallery.huawei.com/#/app/C103911977) | 不合规被下架 |
| ~~小米商店~~   | [http://app.xiaomi.com/detail/1341005](http://app.xiaomi.com/detail/1341005) | 不合规被下架 |
| ~~酷安商店~~   | [https://www.coolapk.com/apk/282769](https://www.coolapk.com/apk/282769) | 不合规被下架 |
| APK下载  | [https://github.com/iHTCboy/iPomodoro-Flutter/releases](https://github.com/iHTCboy/iPomodoro-Flutter/releases) | 可供下载 |

> 注：因为苹果开发者账号需要 ￥688 年费，所以 App Store下载收费1元。介意的朋友可以下载本项目代码在 macOS 系统编译安装。


2、编译安装
iOS app 因为苹果开发者账号需要 ￥688 年费，所以 AppStore 为付费下载，请见谅。你可以下载本项目代码在macOS系统编译安装。

3、Gradle
- [Compatibility Matrix](https://docs.gradle.org/current/userguide/compatibility.html)
- [Gradle Distributions](https://services.gradle.org/distributions/)

### 应用截图

| ![](screenshot/01.png) | ![](screenshot/02.png) |
| ----- | ----- |
| ![](screenshot/03.png) | ![](screenshot/04.png) |
| ![](screenshot/05.png) | ![](screenshot/06.png) |
| ![](screenshot/07.png) |  |

