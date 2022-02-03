//
//  ViewModelBindable.swift
//  RxMemo
//
//  Created by Park Woo Chan on 2022/02/03.
//

import UIKit

protocol ViewModelBindable {
    
    /// 제네릭 프로토콜
    /// 이 경우 구현부에서 `typealias ViewModelType = 어떤 타입` 을 명시적으로 적어주어야한다.
    associatedtype ViewModelType
    
    /// 👀 혹은 viewModel 속성을 선언할 때 구현 타입을 적어주면 자동으로 채워진다.
    /// 지금은 간단한 프로토콜이라서 그 효용을 파악하기 어렵지만,
    /// 같은 타입인것까지만 강제하고 타입을 특정하지 않을 수 있는 제네릭의 장점은 쓸모가 많다.
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
}

extension ViewModelBindable where Self: UIViewController {
    
    /// 이렇게 하면 코드가 단순해진다는 장점이 있다고 하는데 일단 계속 진행해보자
    /// bindViewModel() 을 내부에서 호출하고 있긴 하다.
    mutating func bind(viewModel: Self.ViewModelType) {
        
        self.viewModel = viewModel
        
        loadViewIfNeeded()
        
        bindViewModel()
    }
}
