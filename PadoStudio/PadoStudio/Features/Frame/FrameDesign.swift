//
//  FrameDesign.swift
//  PadoStudio
//
//  Created by kim yijun on 6/4/25.
//

import SwiftUI

struct FrameDesign: View {
    
    @State private var characters: [String] = ["Asset5", "Asset5", "Asset5","Asset5", "Asset5", "Asset5"] // 테스트용 데이터 추가
    
    var body: some View {
        
        ZStack{
            Image("Frame1")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
           
            VStack {
                Spacer()
                
            HStack(spacing: -40) {
                    ForEach(characters, id: \.self) { character in
                        Image(character)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120.scaled, height: 120.scaled)
                    }
                }
                .padding(.bottom, 30) 
            }
        }
    }
}


#Preview {
    FrameDesign()
}
