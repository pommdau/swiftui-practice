//
//  ContentView.swift
//  VideoConvertDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/13.
//

import SwiftUI
import AVKit

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                let url = URL(fileURLWithPath: "/Users/ikeh/Downloads/demo.mov")
                encodeVideo(at: url) { url, error in
                    print("stop")
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// ref: https://gist.github.com/iAmrSalman/0f2624ef3f4982600f53a4c9f0201fb0
// Don't forget to import AVKit
func encodeVideo(at videoURL: URL, completionHandler: ((URL?, Error?) -> Void)?)  {
    
    let avAsset = AVURLAsset(url: videoURL, options: nil)
    
    let filePath = videoURL
        .deletingLastPathComponent()
        .appendingPathComponent("demo_for_twitter.mp4")
        
    //Check if the file already exists then remove the previous file
    if FileManager.default.fileExists(atPath: filePath.path) {
        do {
            try FileManager.default.removeItem(at: filePath)
        } catch {
            completionHandler?(nil, error)
        }
    }
        
    // Create Export session
    // [AVAssetExportSession](https://developer.apple.com/documentation/avfoundation/avassetexportsession)
    guard let exportSession = AVAssetExportSession(asset: avAsset,
                                                   presetName: AVAssetExportPresetPassthrough) else {
        completionHandler?(nil, nil)
        return
    }
    exportSession.outputURL = filePath
    exportSession.outputFileType = AVFileType.mp4
    exportSession.fileLengthLimit = 10 * 1024 * 1024
    exportSession.shouldOptimizeForNetworkUse = true

    let start = CMTimeMakeWithSeconds(0.0, preferredTimescale: 0)
    let range = CMTimeRangeMake(start: start, duration: avAsset.duration)
    exportSession.timeRange = range
        
    let startDate = Date()
    exportSession.exportAsynchronously(completionHandler: {() -> Void in
        switch exportSession.status {
        case .failed:
            print(exportSession.error ?? "NO ERROR")
            completionHandler?(nil, exportSession.error)
        case .cancelled:
            print("Export canceled")
            completionHandler?(nil, nil)
        case .completed:
            //Video conversion finished
            let endDate = Date()
                
            let time = endDate.timeIntervalSince(startDate)
            print(time)
            print("Successful!")
            print(exportSession.outputURL ?? "NO OUTPUT URL")
            completionHandler?(exportSession.outputURL, nil)
                
            default: break
        }
            
    })
}
