//
//  ImageBut.swift
//  Tummy Tales
//
//  Created by Rehan Shaik on 20/05/25.
//

import SwiftUI

struct ImageBut: View {
    var body: some View {
        ZStack {
            Image("pinkbut")
                .resizable()
                .frame(width: 220, height: 60)
            Image("what")
                .resizable()
                .frame(width: 190, height: 40)
               
            
        }
      
    }
}



#Preview {
    ImageBut()
}


struct ImageButt: View {
    var body: some View {
        ZStack {
            Image("pinkbut")
                .resizable()
                .frame(width: 190, height: 60)
            Image("daily")
                .resizable()
                .frame(width: 160, height: 40)
               
        }
      
    }
}
