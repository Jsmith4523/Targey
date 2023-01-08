//
//  AddItemOptionView.swift
//  Targey
//
//  Created by Jaylen Smith on 12/31/22.
//

import SwiftUI

struct AddItemOptionView: View {
    
    @Environment (\.dismiss) var dismiss
    
    struct Option: Identifiable {
        var id = UUID()
        var title: String
        var image: String
    }
    
    let options: [Option] = [
        .init(title: "Scan", image: "iphone.rear.camera"),
        .init(title: "Search", image: "magnifyingglass"),
        .init(title: "Manual", image: "text.badge.plus")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ForEach(options) { option in
                        Spacer()
                        Button {
                            
                        } label: {
                            VStack {
                                Image(systemName: option.image)
                                    .shoppingListSelectionOptionButtonStyle()
                                Text(option.title)
                                    .font(.system(size: 14).bold())
                                    .foregroundColor(.reversed)
                            }
                        }
                        Spacer()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Select Option")
                        .font(.system(size: 18).bold())
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .accentColor(.targetRed)
                    }
                }
            }
        }
    }
}

struct AddItemOptionView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemOptionView()
    }
}
