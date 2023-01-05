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
        .init(title: "Scan", image: ""),
        .init(title: "Search", image: ""),
        .init(title: "Manual", image: "")
    ]
    
    var body: some View {
        NavigationView {
            HStack {
                ForEach(options) { option in
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Select an Option")
                        .font(.system(size: 18).bold())
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .accentColor(.targetRed)
        }
    }
}

struct AddItemOptionView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemOptionView()
    }
}
