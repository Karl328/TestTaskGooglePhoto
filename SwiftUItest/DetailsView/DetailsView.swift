//
//  DetailsView.swift
//  SwiftUItest
//
//  Created by Линар Нигматзянов on 05/10/2022.
//

import SwiftUI
import Kingfisher
import SafariServices

struct DetailsView: View {
   
    var imageLink: String
    var array = [ImagesResult]()
    @State  var index: Int
    @State private var scale: CGFloat = 1
    @State  private var showWebView = false
   
    var body: some View {
        VStack {
            KFImage(URL(string: array[index - 1].original))
                .resizable()
                .scaledToFit()
            
       
            HStack {
                Button(action: {
                    if index > 1 {
                        index -= 1
                    }
                   
                }, label: {
                    Text("Prev")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                })
                Button(action: {
                    if index < array.count {
                        index += 1
                    }
                   
                }, label: {
                    Text("Next")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                })
                
                Button(action: {
                    showWebView.toggle()
                }, label: {
                    Image(systemName: "network")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }).sheet(isPresented: $showWebView) {
                    SafariView(url:URL(string: array[index - 1].link)!)
                    
                }
                
            }
        }
 }
        
    struct ProgressBar: View {
        var body: some View {
            ProgressView()
                .scaleEffect(3)
                .progressViewStyle(CircularProgressViewStyle(tint: .black))
        }
    }

    struct SafariView: UIViewControllerRepresentable {
        
        let url: URL
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
            return SFSafariViewController(url: url)
        }
        
        func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
            
        }
        
    }
    
}
