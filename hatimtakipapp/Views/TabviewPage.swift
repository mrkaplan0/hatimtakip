//
//  HomePage.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 01.08.23.
//

import SwiftUI

struct TabviewPage: View {
    let listsText : String = "Hatimlerim"
    let increaseText : String = "Okunan"
    let readText : String = "Kuran Oku"
    
    var body: some View {
        TabView{
            ListsPage().tabItem {
                Image(systemName: "list.clipboard")
                Text("\(listsText)")
            }
            IncCountsPage().tabItem {
                Image(systemName: "plus.circle")
                Text("\(increaseText)")
            }
            ReadingPage().tabItem {
                Image(systemName: "book")
                Text("\(readText)")
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        TabviewPage()
    }
}
