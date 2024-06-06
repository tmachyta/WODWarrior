//
//  VideoPicker.swift
//  WODWarrior
//
//  Created by Мачита Тарас on 06.06.2024.
//

import Foundation
import SwiftUI
import AVKit
import PhotosUI

class VideoPicker: ObservableObject {
    enum VideoImportState {
        case empty
        case loading(Progress)
        case success(AVPlayer)
        case failure(Error)
    }
    
    @Published private(set) var videoImportState: VideoImportState = .empty
    
    struct VideoType: Transferable {
        let url: URL
        
        static func documentDirectory() -> URL {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            return documentDirectory
        }
        
        static var transferRepresentation: some TransferRepresentation {
            FileRepresentation(contentType: .movie,
                               exporting: { _ in
                                   // Placeholder for exporting closure
                                   fatalError("Exporting not implemented")
                               },
                               importing: { received in
                                   let fileName = received.file.lastPathComponent
                                   let documentDirectory = Self.documentDirectory()
                                   let copy = documentDirectory.appendingPathComponent(fileName)
                                   do {
                                       try FileManager.default.copyItem(at: received.file, to: copy)
                                       return Self.init(url: copy)
                                   } catch {
                                       fatalError("Failed to copy file: \(error)")
                                   }
                               })
        }
    }
    
    @Published var videoSelection: PhotosPickerItem? = nil {
        didSet {
            if let videoSelection = videoSelection {
                let progress = loadTransferableVideo(from: videoSelection)
                videoImportState = .loading(progress)
            } else {
                videoImportState = .empty
            }
        }
    }
    
    private func loadTransferableVideo(from videoSelection: PhotosPickerItem) -> Progress {
        return videoSelection.loadTransferable(type: VideoType.self) { result in
            DispatchQueue.main.async {
                guard videoSelection == self.videoSelection else {
                    print("Failed to get the selected item")
                    return
                }
                
                switch result {
                case .success(let video?):
                    let fileName = UUID().uuidString + ".mp4"
                    let documentsDirectory = VideoType.documentDirectory()
                    let destinationURL = documentsDirectory.appendingPathComponent(fileName)
                    
                    do {
                        try FileManager.default.moveItem(at: video.url, to: destinationURL)
                        let player = AVPlayer(url: destinationURL)
                        self.videoImportState = .success(player)
                    } catch {
                        self.videoImportState = .failure(error)
                    }
                case .success(nil):
                    self.videoImportState = .empty
                case .failure(let error):
                    self.videoImportState = .failure(error)
                }
            }
        }
    }
    
    func getVideoURL() -> URL? {
        if case .success(let player) = videoImportState {
            return (player.currentItem?.asset as? AVURLAsset)?.url
        }
        return nil
    }
    
    // Метод для отримання відносного шляху до відео
    func getRelativeVideoPath() -> String? {
        if case .success(let player) = videoImportState {
            if let url = (player.currentItem?.asset as? AVURLAsset)?.url {
                let documentDirectory = VideoType.documentDirectory().path
                return url.path.replacingOccurrences(of: documentDirectory, with: "")
            }
        }
        return nil
    }
    
    // Метод для відновлення повного шляху з відносного шляху
    func getFullVideoPath(from relativePath: String) -> URL {
        return VideoType.documentDirectory().appendingPathComponent(relativePath)
    }
}
