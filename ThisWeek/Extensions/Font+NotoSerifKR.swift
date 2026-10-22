//
//  Font+NotoSerifKR.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/22/26.
//

import SwiftUI

extension Font {
    static func serifBold(_ size: CGFloat) -> Font {
        .custom("NotoSerifKR-Bold", size: size, relativeTo: .title)
    }
}
