//
//  formater.swift
//  new
//
//  Created by Иван Котляр on 10.03.2022.
//

import Foundation
import SwiftUI

//Hm... With lower case?)
//Why NSString?
//What is nf? and why its class?
class formaterr: ObservableObject {
     func priceFormat(price: Double)->String{
        let nf = String(format:"%.2f", price)
        return nf
    }
}

//Do like this or something else 
public extension Double {
    
    var priceFormat: String {
        String(format: "%.2f", self)
    }
}
