//
//  MemoryStorage.swift
//  RxMemo
//
//  Created by Park Woo Chan on 2022/02/03.
//

import Foundation
import RxSwift

/// 메모리에 메모를 저장
class MemoStorage: MemoStorageType {
    
    private var list = [
        Memo(content: "조아 조아", insertDate: Date().addingTimeInterval(-10)),
        Memo(content: "퇴근 후 공부", insertDate: Date().addingTimeInterval(-20))
    ]
    
    /// 배열은 옵저버블을 통해 외부에 공개되어야 한다??
    /// 새로운 메모가 생기면 next 이벤트를 통해 방출된다.
    /// Subejct 로 만들어야하고, 초기 값이 필요하므로 BehaviorSubject 로 만든다.
    private lazy var store = BehaviorSubject<[Memo]>(value: list)
    
    @discardableResult
    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content)
        list.insert(memo, at: 0)
        
        /// 요기가 포인트 👇🏻 서브젝트에 넥스트 이벤트를 전달한다.
        /// = memoList( ) 를 통해 store 를 구독하고 있는 구독자들에게도 해당 이벤트가 전달될 것이다.
        store.onNext(list)
        
        return Observable.just(memo)
    }

    @discardableResult
    func memoList() -> Observable<[Memo]> {
        return store
    }
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo> {
        let updated = Memo(original: memo, updatedContent: content)
        
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
            list.insert(updated, at: index)
        }
        
        /// 요기가 포인트 👇🏻 서브젝트에 넥스트 이벤트를 전달한다.
        store.onNext(list)
        
        return Observable.just(updated)
    }
    
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo> {
        if let index = list.firstIndex(where: { $0 == memo}) {
            list.remove(at: index)
        }
        
        /// 요기가 포인트 👇🏻 서브젝트에 넥스트 이벤트를 전달한다.
        store.onNext(list)
        
        return Observable.just(memo)
    }
}
