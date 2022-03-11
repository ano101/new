//
//  formater.swift
//
//  Created by Иван Котляр on 10.03.2022.
//

import Foundation
import SwiftUI

class formaterr: ObservableObject {
     func priceFormat(price: Double)->NSString{
        let nf = NSString(format:"%.2f", price)
        return nf
    }
}
