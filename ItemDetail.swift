//
//  ItemDetail.swift
//  iDine
//
//  Created by Benjamin Dirgo on 4/28/20.
//  Copyright © 2020 Benjamin Dirgo. All rights reserved.
//

import SwiftUI

struct ItemDetail: View {
    var item: MenuItem
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
                Text("Photo: \(item.photoCredit)")
                    .padding(4)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .font(.caption)
                    .offset(x: -5, y: -5)
            }
            Text(item.description)
                .padding()
            Spacer()
        }.navigationBarTitle(Text(item.name), displayMode: .inline)
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ItemDetail(item: MenuItem.example)
        }
    }
}
