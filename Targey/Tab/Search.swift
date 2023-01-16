//
//  SearchView.swift
//  Targey
//
//  Created by Jaylen Smith on 12/21/22.
//

import Foundation
import SwiftUI

struct SearchView: View {
    
    @State private var searchField = ""
    
    @State private var isShowingBarcodeScannerView = false
    
    @StateObject private var searchModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TextField("Search", text: $searchField, onEditingChanged: { _ in
                    searchModel.merchandises = []
                    searchModel.suspendCurrentSearchTask()
                }) {
                    if !searchField.isEmpty {
                        searchModel.fetchForProducts(term: searchField)
                    }
                }
                .textFieldStyle(.roundedBorder)
                .padding()
                ZStack {
                    VStack {
                        switch searchModel.isSearching {
                        case true:
                            HangTightProgressView()
                        case false:
                            switch searchModel.didFailToSearch {
                            case true:
                                NoResultsFoundView()
                            case false:
                                switch searchField.isEmpty {
                                case true:
                                    SearchInstruction()
                                case false:
                                    SearchResultsView(searchField: $searchField, searchModel: searchModel)
                                }
                            }
                        }
                    }
                    ScannerButton(isShowingBarcodeScannerView: $isShowingBarcodeScannerView, searchModel: searchModel)
                }
            }
            .accentColor(.targetRed)
        }
        .fullScreenCover(isPresented: $isShowingBarcodeScannerView) {
            BarcodeScannerView()
        }
    }
}

fileprivate struct ScannerButton: View {
    
    @Binding var isShowingBarcodeScannerView: Bool
    
    @ObservedObject var searchModel: SearchViewModel
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    isShowingBarcodeScannerView.toggle()
                } label: {
                    Image(systemName: "barcode.viewfinder")
                        .largeButtonStyle()
                }
            }
            .padding()
        }
    }
}

fileprivate struct SearchInstruction: View {
    var body: some View {
        VStack {
            Image.
        }
    }
}

 

struct Previews_Search_Previews: PreviewProvider {
    static var previews: some View {
        SearchInstruction()
    }
}
