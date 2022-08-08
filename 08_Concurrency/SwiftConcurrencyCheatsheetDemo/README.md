#  Coucurrency
## 全般
- [Swift Concurrency チートシート](https://zenn.dev/koher/articles/swift-concurrency-cheatsheet#async-%2F-await)


## Case11
- [Swift Async/AwaitのCancelの仕方](https://zenn.dev/zunda_pixel/articles/98493abbb3beca)
- Taskの型名

```swift
@State var downloadTask: Task<(), Never>?
```

- Task内のwait
   - `Thread.sleep(forTimeInterval: 2.0)`ではうまくキャンセル処理できなかった

```swift
try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
```
