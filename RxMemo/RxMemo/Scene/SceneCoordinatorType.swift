//
//  SceneCoordinatorType.swift
//  RxMemo
//
//  Created by Park Woo Chan on 2022/02/06.
//

import Foundation
import RxSwift

/// SceneCoordinator 가 공통적으로 구현해야 하는 멤버를 선언
protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable
    
    @discardableResult
    func close(animated: Bool) -> Completable
}
