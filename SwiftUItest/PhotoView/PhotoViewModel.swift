//
//  PhotoViewModel.swift
//  SwiftUItest
//
//  Created by Линар Нигматзянов on 04/10/2022.
//

import Foundation

final class PhotoViewModel: ObservableObject {
    @Published var resultsArray = [PhotoModel]()
    @Published var isLoading = false
    func search(text: String) {
        isLoading = true
        ApiCaller.shared.makeAPIRequest(with: "https://serpapi.com/search.json?q=\(text)&tbm=isch&ijn=0&api_key=2f5dd6d36e870437eaec3a1057c7b4d00ae3ea225b24b862d4f0d2dfb3910f4d", PhotoModel.self) { result in
            switch result {
            case .success(let data) :
                DispatchQueue.main.async {
                    defer {self.isLoading = false }
                    self.resultsArray = [data]
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
