# 生成精简安卓安装包

在 `app` 目录使用已配置好的 Flutter、Android SDK 和 JDK 21 构建 ARM64 包：

```sh
flutter build apk --release --target-platform android-arm64 \
	-Pdisable-abi-filtering=true -Pcompact-apk=true \
	--split-debug-info=build/symbols
```

输出为 `app/build/app/outputs/flutter-apk/app-release.apk`。保留 `app/build/symbols`，用于还原此版本的 Dart 崩溃堆栈。发布签名仍由 `app/android/key.properties` 配置。未配置签名时，需先给 APK 签名才能安装。

`compact-apk` 压缩原生库，减小直接下载的 APK。Android 安装时会解压这些库，所以 APK 的缩减比例不等于安装占用的缩减比例。不传这个参数时，原生库继续使用不压缩存储。参考 [Android 原生库打包说明](https://developer.android.com/guide/practices/page-sizes)。

## 更新音频或励志文案后重新生成资源

原始资源保留在 `app/assets/fonts` 和 `app/assets/musics`。`pubspec.yaml` 只打包两款中文字体的裁剪版和音频的压缩版，文件位于 `app/assets/optimized`。计时数字字体继续使用原文件。

安装 FFmpeg，并在 Python 环境安装 `tools/requirements-assets.txt` 中的依赖。从仓库根目录运行：

```sh
python3 tools/optimize_assets.py
```

脚本保留 `TipsDialog` 源文件中的字符和 ASCII 字符，保留字体版权信息，并将全部 14 个 MP3 转为 96 kbps。每段音频的时长、采样率和声道数保持不变。脚本同时检查字体字符覆盖及 MP3 解码结果。修改 `tips_dialog.dart` 后也要重新运行脚本，再提交生成的资源。

## 查看 APK 体积构成

在仓库根目录运行，可传入一个或多个 APK 路径：

```sh
python3 tools/apk_size.py /path/to/before.apk /path/to/after.apk
```

输出包含 APK 总字节数、SHA-256，以及原生库、字体、音频和其他文件在 ZIP 内的实际占用。ZIP 目录、对齐填充和签名块单独计数。数值使用字节，不代表安装后的应用大小。
