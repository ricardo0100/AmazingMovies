//
//  IdentifierLoadable.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 26/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

protocol IdentifierLoadable {
    static func storyboardName() -> String
    static func storyboardIdentifier() -> String
}

extension IdentifierLoadable where Self: UIViewController {
    static func storyboardName() -> String {
        return String(describing: Self.self).replacingOccurrences(of: "ViewController", with: "")
    }
    
    static func storyboardIdentifier() -> String {
        return String(describing: Self.self)
    }
}

extension IdentifierLoadable where Self: UICollectionViewController {
    static func storyboardName() -> String {
        return String(describing: Self.self).replacingOccurrences(of: "CollectionViewController", with: "")
    }
    
    static func storyboardIdentifier() -> String {
        return String(describing: Self.self)
    }
}

extension UIStoryboard {
    static func loadViewController<T>() -> T where T: IdentifierLoadable, T: UIViewController {
        return UIStoryboard(name: T.storyboardName(), bundle: nil)
            // swiftlint:disable:next force_cast
            .instantiateViewController(withIdentifier: T.storyboardIdentifier()) as! T
    }
}
