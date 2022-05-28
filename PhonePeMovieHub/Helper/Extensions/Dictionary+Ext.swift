//
//  Dictionary+Ext.swift
//  PhonePeMovieHub
//
//  Created by Zeba Khan on 28/05/22.
//

import Foundation
import UIKit

extension Dictionary {
    var asQuery: String {
        var output: String = ""
        for (key, value) in self {
            output += "\(key)=\(value)&"
        }
        return String(output.dropLast())
    }
}

extension UIStoryboard {
    static var main: UIStoryboard {
        get {
            return UIStoryboard(name: "Main", bundle: nil)
        }
    }
    
    func instantiateViewController<T:UIViewController>(type: T.Type) -> T {
        if let viewController = instantiateViewController(withIdentifier: String(describing: T.self)) as? T {
            return viewController
        } else {
            fatalError("Problem with " + String(describing: T.self))
        }
    }
}
