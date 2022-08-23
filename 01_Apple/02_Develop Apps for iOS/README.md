# [Develop Apps for iOS](https://developer.apple.com/tutorials/app-dev-training)

## Memos

- dataファイルの確認
    - 中身はJSON文字列なのでCotEditor等で確認できる

>[With Scrumdinger running in Simulator, open Terminal and type xcrun simctl get\_app\_container booted com\.example\.apple\-samplecode\.Scrumdinger data\. You can now view the path of the app’s data folder\. Try to locate the scrums\.data file\.](https://developer.apple.com/tutorials/app-dev-training/persisting-data)

```command
xcrun simctl get_app_container booted com.example.apple-samplecode.Scrumdinger data

// 実際
xcrun simctl get_app_container booted com.gmail.ikeh1024.Scrumdinger data
```