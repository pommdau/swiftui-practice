#!/usr/bin/env python3
"""選択中のmacOS SDKから標準画像を抽出してMarkdown一覧を生成する。"""
from pathlib import Path
import json
import re
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]
SDK = subprocess.check_output(['xcrun', '--show-sdk-path'], text=True).strip()
HEADER = Path(SDK) / 'System/Library/Frameworks/AppKit.framework/Headers/NSImage.h'
NAMES = re.findall(r'^APPKIT_EXTERN NSImageName\s+const\s+(\w+)', HEADER.read_text(), re.M)
BASE = '''項目を追加
Bluetooth
Bonjourによるサービス検出
ブックマーク
注意・警告
コンピュータ
フルスクリーンを開始
フルスクリーンを解除
フォルダ
ディスク作成用フォルダ
スマートフォルダ
リンク先へ移動（枠なしボタン向け）
ホーム
旧iChat Theater
施錠
解錠
ネットワーク
パス
クイックルック
更新（枠なしボタン向け）
更新
項目を削除
対象を表示（枠なしボタン向け）
共有
スライドショー
利用可能（緑）
状態なし（グレー）
一部利用可能（黄）
利用不可（赤）
処理を停止（枠なしボタン向け）
処理を停止
空のゴミ箱
中身のあるゴミ箱
アクションメニュー
スマート項目のバッジ
アイコン表示
リスト表示
カラム表示
カバーフロー表示
入力データの不備を表示
進む（UIの配置方向に対応）
戻る（UIの配置方向に対応）
右へ移動（方向固定）
左へ移動（方向固定）
右向きの三角形
左向きの三角形
旧.Mac（非推奨、MobileMeと同じ画像。Swiftの静的定数がないため名前文字列で指定）
旧MobileMe
複数書類のドラッグ表示
ユーザアカウント設定
一般設定
詳細設定
情報
フォントパネル
カラーパネル
ユーザ
ユーザグループ
全ユーザ
ゲストユーザ
メニューの選択状態（メニュー用）
メニューの混在状態（メニュー用）
実行中アプリのアイコン'''.splitlines()
TOUCH = '''詳細を追加
項目を追加
アラーム
マイクをミュート
音声入力
音声出力をミュート
音量：大
音量：小
音量：中
音量：オフ
ブックマーク
塗りの色を選択
文字の色を選択
線の色を選択
音声通話
ビデオ通話
作成・編集
削除
ダウンロード
フルスクリーンを開始
フルスクリーンを解除
早送り
フォルダへコピー
フォルダへ移動
フォルダ
情報を見る
戻る
下へ移動
進む
上へ移動
履歴
アイコン表示
リスト表示
メール
新規フォルダ
新規メッセージ
ブラウザで開く
一時停止
再生・一時停止
再生
クイックルック
録音を開始
録音を停止
更新
項目を削除
巻き戻し
左へ回転
右へ回転
検索
共有
サイドバー
15秒先へ移動
30秒先へ移動
先へスキップ
15秒前へ移動
30秒前へ移動
前へスキップ
末尾へ移動
先頭へ移動
スライドショー
タグ
太字
テキストボックス
中央揃え
斜体
両端揃え
左揃え
リスト
右揃え
取り消し線
下線
ユーザを追加
ユーザグループ
ユーザ
音量を下げる
音量を上げる
再生位置'''.splitlines()
assert len(BASE) == sum('TouchBar' not in n for n in NAMES)
assert len(TOUCH) == sum('TouchBar' in n for n in NAMES)
DESCRIPTIONS = BASE + TOUCH

def swift_name(name):
    if name == 'NSImageNameDotMac':
        return 'NSImage.Name("NSDotMac")'
    stem = name.removeprefix('NSImageName')
    return 'NSImage.' + stem[0].lower() + stem[1:] + 'Name'

OUT = ROOT / 'docs'
IMAGES = OUT / 'images'
IMAGES.mkdir(parents=True, exist_ok=True)
entries = ',\n'.join('@{ @"symbol": @"' + n + '", @"name": ' + n + ' }' for n in NAMES)
source = r'''#import <AppKit/AppKit.h>
int main(int argc, const char *argv[]) { @autoreleasepool {
    [NSApplication sharedApplication];
    NSAppearance *appearance = [NSAppearance appearanceNamed:NSAppearanceNameAqua];
    NSMutableArray *results = [NSMutableArray array];
    [appearance performAsCurrentDrawingAppearance:^{
    for (NSDictionary *entry in ENTRIES) {
        NSImage *image = [NSImage imageNamed:entry[@"name"]];
        BOOL ok = NO;
        if (image && image.size.width > 0 && image.size.height > 0) {
            NSBitmapImageRep *rep = [[NSBitmapImageRep alloc]
                initWithBitmapDataPlanes:NULL pixelsWide:96 pixelsHigh:96
                bitsPerSample:8 samplesPerPixel:4 hasAlpha:YES isPlanar:NO
                colorSpaceName:NSDeviceRGBColorSpace bytesPerRow:0 bitsPerPixel:0];
            [NSGraphicsContext saveGraphicsState];
            [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithBitmapImageRep:rep]];
            CGFloat scale = MIN(64.0/image.size.width, 64.0/image.size.height);
            NSSize size = NSMakeSize(image.size.width*scale, image.size.height*scale);
            NSRect rect = NSMakeRect((96-size.width)/2, (96-size.height)/2, size.width, size.height);
            [image drawInRect:rect fromRect:NSZeroRect operation:NSCompositingOperationCopy fraction:1];
            if (image.isTemplate) {
                [[NSColor blackColor] setFill];
                NSRectFillUsingOperation(NSMakeRect(0,0,96,96), NSCompositingOperationSourceIn);
            }
            [[NSColor whiteColor] setFill];
            NSRectFillUsingOperation(NSMakeRect(0,0,96,96), NSCompositingOperationDestinationOver);
            [NSGraphicsContext restoreGraphicsState];
            NSString *path = [[NSString stringWithUTF8String:argv[1]] stringByAppendingPathComponent:[entry[@"symbol"] stringByAppendingString:@".png"]];
            ok = [[rep representationUsingType:NSBitmapImageFileTypePNG properties:@{}] writeToFile:path atomically:YES];
        }
        [results addObject:@{@"symbol":entry[@"symbol"], @"saved":@(ok)}];
    }
    }];
    NSData *data = [NSJSONSerialization dataWithJSONObject:results options:0 error:NULL];
    puts([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding].UTF8String);
} return 0; }
'''.replace('ENTRIES', '@[' + entries + ']')
with tempfile.TemporaryDirectory(prefix='nsimage-export-') as tmp:
    src, exe = Path(tmp)/'export.m', Path(tmp)/'export'
    src.write_text(source)
    subprocess.run(['xcrun', 'clang', '-fobjc-arc', '-fblocks', '-Wno-deprecated-declarations', '-framework', 'AppKit', str(src), '-o', str(exe)], check=True)
    results = json.loads(subprocess.check_output([str(exe), str(IMAGES)], text=True))
version = subprocess.check_output(['xcodebuild', '-version'], text=True).strip().replace('\n', ' / ')
os_version = subprocess.check_output(['sw_vers', '-productVersion'], text=True).strip()
lines = ['# NSImage 標準画像一覧', '', f'生成環境：{version}、macOS {os_version}。', '',
    '選択中のSDKの`NSImage.h`に宣言された画像名定数を掲載しています。シンボル名はSwiftで参照する名前です。SF Symbolsの名前ではありません。説明は用途を日本語で整理したものです。', '',
    'PNGは96 × 96ピクセルの白背景に、縦横比を保って最大64 × 64ピクセルで描画しています。テンプレート画像は黒で描画しています。実際のコントロールでの色・外観とは異なります。Touch Bar用画像は本来Touch Barで使う画像です。アプリアイコンは書き出しプロセスの実行環境に依存します。', '',
    ]
lines += (Path(__file__).with_name('usage-example.md')).read_text().splitlines()
for is_touch, title in [(False, '一般用の標準画像'), (True, 'Touch Bar用の標準画像')]:
    lines += ['## ' + title, '', '|画像|シンボル名|説明|', '|---|---|---|']
    for result, desc in zip(results, DESCRIPTIONS):
        name = result['symbol']
        if ('TouchBar' in name) != is_touch:
            continue
        symbol = swift_name(name)
        pic = f'![{symbol}](images/{name}.png)' if result['saved'] else '取得・保存不可'
        lines.append(f'|{pic}|`{symbol}`|{desc}|')
    lines.append('')
count = sum(r['saved'] for r in results)
lines += ['', f'保存結果：{count} / {len(NAMES)}件。', '',
    '再生成：プロジェクトディレクトリで`python3 scripts/export_images.py`を実行します。', '']
lines += ['', (Path(__file__).with_name('uiimage-guide.md')).read_text().rstrip(), '']
(OUT/'NSImage-catalog.md').write_text('\n'.join(lines))
print(f'Saved {count}/{len(NAMES)} images: {OUT / "NSImage-catalog.md"}')
print('Failed:', [r['symbol'] for r in results if not r['saved']])

swift_lines = [
    '#if os(macOS)',
    '// scripts/export_images.pyで生成。画像名は選択中のSDKに基づきます。',
    'import AppKit', '',
    'extension StandardImage {',
    '    static let all: [StandardImage] = ['
]
for name, desc in zip(NAMES, DESCRIPTIONS):
    symbol = swift_name(name)
    swift_lines.append(f'        .init(name: {symbol}, symbol: {json.dumps(symbol)}, label: {json.dumps(desc, ensure_ascii=False)}, isTouchBar: {str("TouchBar" in name).lower()}),')
swift_lines += ['    ]', '}', '#endif', '']
(ROOT / 'NSImageDemo/StandardImage.swift').write_text('\n'.join(swift_lines))
