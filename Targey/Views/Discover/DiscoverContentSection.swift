//
//  DiscoverContentSection.swift
//  Targey
//
//  Created by Jaylen Smith on 1/12/23.
//

import SwiftUI


///Header displayed above a view passed through. Doesn't only need to be for DiscoverView but for other views as well
struct DiscoverContentSection<Content: View>: View {
    
    let header: String
    let content: () -> Content
    
    init(header: String, @ViewBuilder content: @escaping () -> Content) {
        self.header  = header
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Section {
                content()
            } header: {
                Text(header)
                    .font(.system(size: 18).bold())
            }
        }
    }
}

struct DiscoverContentSection_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverContentSection(header: "Promotions") {
            MyStoreNotSelectView(locationM: LocationServicesManager())
        }
    }
}
