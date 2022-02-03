//
//  MemoStorageType.swift
//  RxMemo
//
//  Created by Park Woo Chan on 2022/02/02.
//

import Foundation
import RxSwift

protocol MemoStorageType {
    
    /// 반환된 옵저버블 타입을 사용하여 구독자가 작업 결과를 원하는 방식으로 처리할 수 있게 된다.
    /// 작업 결과가 필요없는 경우를 위해 어노테이션 추가
    @discardableResult
    func createMemo(content: String) -> Observable<Memo>
    
    /// 지금 생각으로는 `completionHandelr` 구현 코드를 `subscribe` 부분에 넣는 차이 정도가 있는 것 같다.
    // func createMemo(content: String, completionHandler: @escaping (Memo) -> Void) 정도????
    
    @discardableResult
    func memoList() -> Observable<[Memo]>
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo>
    
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo>
}
