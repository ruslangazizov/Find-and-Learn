//
//  FilesManager.swift
//  Find-and-Learn
//
//  Created by Руслан on 04.06.2022.
//

import UIKit

protocol FilesManagerProtocol {
    func saveAvatar(_ image: UIImage)
    func getAvatar() -> UIImage?
    func deleteAvatar()
}

final class FilesManager: FilesManagerProtocol {
    private let avatarImageName = "avatar.png"
    
    func saveAvatar(_ image: UIImage) {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        if let data = image.pngData(), let documentDirectory = documentDirectory {
            let url = documentDirectory.appendingPathComponent(avatarImageName)
            do {
                try data.write(to: url)
            } catch {
                assertionFailure("Unable to write data to disk: \(error)")
            }
        } else {
            assertionFailure("Unable to get Data from UIImage or find documentDirectory in FileManager")
        }
    }
    
    func getAvatar() -> UIImage? {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        if let documentDirectory = documentDirectory {
            let url = documentDirectory.appendingPathComponent(avatarImageName)
            return UIImage(contentsOfFile: url.path)
        } else {
            assertionFailure("Unable to find documentDirectory in FileManager")
        }
        return nil
    }
    
    func deleteAvatar() {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        guard let documentDirectory = documentDirectory else {
            return
        }
        let url = documentDirectory.appendingPathComponent(avatarImageName)
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            assertionFailure("Unable to delete avatar at \(url)")
        }
    }
}
