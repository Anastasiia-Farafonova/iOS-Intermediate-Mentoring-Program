//
//  PizzaRowView.swift
//  Task 9 SwiftUI
//
//  Created by Anastasiia Farafonova on 06.01.2022.
//

import SwiftUI

struct PizzaRowView: View {
    private enum Const {
        static let imageSize: CGFloat = 70
        static let textFieldColor = Color(red: 0.31, green: 0.54, blue: 0.31)
    }
    
    @Binding var item: PizzaItem
    
    var body: some View {
        HStack {
            Image(item.image)
                .resizable()
                .cornerRadius(8)
                .frame(width: Const.imageSize, height: Const.imageSize)
            Spacer()
            VStack(alignment: .leading) {
                TextField(item.name, text: $item.name)
                .font(.title)
                .foregroundColor(Const.textFieldColor)
                HStack {
                    Text("Price: $\(item.price).00")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct PizzaRowView_Previews: PreviewProvider {
    static var previews: some View {
        PizzaRowView(item: .constant(PizzaItem(id: 1, name: "Pizza #1", price: 1, image: "2")))
    }
}
