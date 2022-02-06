//
//  TransitionModel.swift
//  RxMemo
//
//  Created by Park Woo Chan on 2022/02/03.
//

import Foundation

enum TransitionStyle {
    case root
    case push
    case modal
}

enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
