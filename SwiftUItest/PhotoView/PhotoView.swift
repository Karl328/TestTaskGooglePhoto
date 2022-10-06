//
//  ContentView.swift
//  SwiftUItest
//
//  Created by Линар Нигматзянов on 29/09/2022.
//

import SwiftUI
import Kingfisher
struct PhotoView: View {
    
    @State private var searchText = ""
    @State private var searching = false
    @FocusState var isFocused: Bool
    @ObservedObject var viewModel = PhotoViewModel()
    @State var appeared: Double = 0
    let columns = [
        GridItem(.fixed(100), spacing: 20),
        GridItem(.fixed(100), spacing: 20),
        GridItem(.fixed(100), spacing: 20)
    ]
    
    var body: some View {
      
        NavigationView {
            VStack(alignment: .leading) {
                HStack { SearchBar(searchText: $searchText, searching: $searching)
                        .focused($isFocused).onSubmit {
                            if !searchText.isEmpty {
                                viewModel.search(text: searchText)
                            }
                           
                        }
                    Button("Search") {
                        if !searchText.isEmpty {
                            resignFirstResponder()
                            viewModel.search(text: searchText)
                        }
                           
                        
                        searching = false
                    }.padding(.trailing, 10)
                }
                ScrollView {
                    if viewModel.isLoading {
                        ProgressBar().frame(width: 100 ,height: 100,alignment: .center)
                            .position(x: UIScreen.main.bounds.width/2)
                            .padding(.top, 100)
                        
                    }
                    else {
                        LazyVGrid(columns: columns, content: {
                            ForEach(viewModel.resultsArray) { data in
                                ForEach (0..<data.imagesResults.endIndex, id: \.self) { index in
                                    NavigationLink {
                                        DetailsView(imageLink: data.imagesResults[index].original, array: data.imagesResults, index: data.imagesResults[index].id )
                                            
                                    } label: {
                                        KFImage(URL(string: data.imagesResults[index].thumbnail))
                                            .resizable()
                                            .scaledToFit()
                                            
                                    }      .opacity(appeared)
                                        .animation(Animation.easeInOut(duration: 3.0), value: appeared)
                                        .onAppear {self.appeared = 1.0}
                                        .onDisappear {self.appeared = 1.0}
                                }
                            }
                        })
                    }
                    
                }
            }
            
            .navigationTitle(searching ? "Searching" : "Google photo search")
            .toolbar {
                if searching {
                    Button("Cancel") {
                        
                        searchText = ""
                        withAnimation {
                            resignFirstResponder()
                            searching = false
                        }
                    }
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
    
    struct SearchBar: View {
        @Binding var searchText: String
        @Binding var searching: Bool
        @ObservedObject var viewmodel = PhotoViewModel()
        var body: some View {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(.cyan))
                HStack {
                    Image(systemName: "magnifyingglass")
                    
                    TextField("Search ...", text: $searchText) { startedEditing in
                        if startedEditing {
                            withAnimation {
                                searching = true
                            }
                        }
                    } onCommit: {
                        resignFirstResponder()
                        withAnimation {
                            searching = false
                        }
                    }
                }
                .foregroundColor(.gray)
                
            }
            .frame( height: 40)
            .cornerRadius(13)
            .padding(.leading, 15)
        }
    }
    
}

func resignFirstResponder() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView()
    }
}
