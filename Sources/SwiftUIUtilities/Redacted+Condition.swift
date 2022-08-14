//
//  File.swift
//  
//
//  Created by Christian Mitteldorf on 24/07/2022.
//

import SwiftUI

@available(iOS 14.0, *)
extension View {

    @ViewBuilder
    public func redacted(when condition: @autoclosure () -> Bool) -> some View {
        redacted(reason: condition() ? .placeholder : [])
    }
}
