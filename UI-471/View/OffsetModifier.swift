//
//  OffsetModifier.swift
//  UI-471
//
//  Created by nyannyan0328 on 2022/02/19.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    var coordinateSpace : String = ""
    var rect : (CGRect) -> ()
    func body(content: Content) -> some View {
        content
            .overlay(
            
            
                GeometryReader{proxy in
                    
                    
                    Color.clear
                    
                        .preference(key: OffsetKey.self, value: proxy.frame(in: .named(coordinateSpace)))
                    
                    
                }
            
            )
            .onPreferenceChange(OffsetKey.self) { rect in
                self.rect(rect)
            }
    }
}

struct OffsetKey : PreferenceKey{
    
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        
        value = nextValue()
    }
}

