//
//  ImageDownloadService.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 11/05/2022.
//

import Foundation
import UIKit

protocol ImageDownloadServiceProtocol {
    func get(for path: String?, completion: @escaping (UIImage?) -> Void) -> CancellationProtocol?
}

struct ImageDownloadService: BaseNetworkService, ImageDownloadServiceProtocol {
    
    func get(for path: String?, completion: @escaping (UIImage?) -> Void) -> CancellationProtocol? {
        guard let path = path,
              let url = URL(string: path) else {
            return nil
        }
        let downloadTask = session.dataTask(with: url) { data, _, _ in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
        downloadTask.resume()
        return downloadTask
    }
}
