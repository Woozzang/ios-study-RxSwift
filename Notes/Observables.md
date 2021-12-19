# Observables

## 참고자료

- KxCoding
- rayWendelich

## 목표

- Observable 의 특징은?
- Observable 을 만드는 두 가지 방법을 이해한다
- Observable 을 사용하는 방법을 이해한다

## 옵저버블이 뭔가요?

Rx 의 심장 💗

- Rx 에서 모든 것은:
    - 시퀀스 이거나
    - 시퀀스와 함께 동작하는 것들

Observable, Observable sequence, Sequence 는 모두 옵저버블을 가리키는 말

- 비동기 시퀀스이다.
- 시퀀스는 일정 기간 (유한 ~ 무한) 동안 이벤트를 생산한다.
- 이것을 이벤트를 방출한다고 표현한다.
- 옵저버블은 옵저버가 구독한다.

이벤트의 방출은 특히 [마블 다이어그램](https://rxmarbles.com)으로 이해하면 편하다:

- 시간은 왼쪽으로 오른쪽으로 흐른다 ⏰
    - 마블 간 간격이 특정한 시간의 크기를 나타내는 것은 아니다
    - 이벤트 전 후 관계를 표현할뿐
- 하나의 마블이 [하나의 이벤트] 를 가리킨다
- 가장 오른쪽에 보이는 vertical bar 는 시퀀스의 종료 시점을 가리킨다
    - ❌ 마크도 있는데 [에러 이벤트의 발생] 을 가리킨다.
<img src="https://user-images.githubusercontent.com/70905219/146681530-f46aac2b-38a4-416d-b088-3e1ead670188.png" width = 50%>


### 간단 정리!

- 옵저버블(시퀀스) 는 elements (보통 데이터, 인스턴스) 를 포함하고 있는 `next` 이벤트를 방출한다!
- 옵저버블은 error 과 completed 이벤트로 종료된다
- 종료된 옵저버블은 더이상 이벤트를 방출하지 않는다.

### 이벤트는 열거형, 3가지 케이스는:

- `next(Element)`
연관 값으로 Obsevable 의 타입 파라미터로 정의된 형식의 값이 들어있다.

- `error(Swift.Error)`
    
    [Error 프로토콜](https://developer.apple.com/documentation/swift/error)을 채택한 타입의 값이 연관 값으로 들어있다.
    
    completed 와 마찬가지로 이후 시퀀스가 종료된다.
    
- `completed`
    
    시퀀스 종료 전 마지막 이벤트
    
    시퀀스가 ‘성공적으로 종료되었음’ 을 알리는 역할도 한다.
    

## Observables 를 만드는 방법!

- 단, 만든다고 이벤트를 방출하는 것이 아님을 기억하자
    
    subscribe 해야 이벤트가 방출된다
    
1. create 를 사용
    - 어떤 이벤트를 어떻게 전달할지 직접 정의해줄 수 있다
    - 옵저버블은 Disposable 을 반환해야하는 것을 상기하자
        - `return Disposable.create()`
        
2. operator 를 사용
    - 이게 타입 메서드랬나 하여간 새로운 Observables를 반환한다
    - 타입 메서드로 만들 수도 있고, 인스턴스 메서드로 만들 수도 있다.
    

## Observable 구독하기

- 옵저버블은 구독자가 생기기 전까지 이벤트를 방출하지 않는다
    - 구독을 시작되어야 이벤트 방출을 시작한다
- 옵저버블 자체는 시퀀스에 대한 정의일 뿐이다

```swift
func subscribe(_ on: @escaping (Event<Int>) -> Void) -> Disposable
```

- Event 타입은 `element` 라는 속성을 가지고 있고, 이벤트가 가지고 있는 연관 값이다.
    - 우리가 정말로 관심있는 그 값
    - 위 코드에서는 `Int` 타입의 element 를 가지고 있다.
        - 제네릭이므로 옵저버블의 정의에 따라 유연하게 바뀜을 인지하자

### .empty()

- 아무 이벤트도 방출하지 않고, 바로 `completed` 이벤트를 방출하고 종료되는 시퀀스
- 보통 Void 타입으로 지정한다

```swift
Observable<Void>.never()
```

### .never()

- 암것도 안함 ㅋㅋ..

## Disposing & Terminating

- subscribe 가 시퀀스를 시작한다면, error 와 completed 가 시퀀스를 종료 시킨다.
- 그런데 시퀀스를 수동으로 종료시키는 또다른 방법이 있다.
    - 시퀀스를 종료시킨다 = 구독을 취소한다 , 정리한다 (dispose)

- subscribe 메서드는 Disposable 타입 인스턴스를 반환한다.
    - 이 타입은 dispose 라는 메서드를 가지고 있다
    - 호출하면 구독이 취소된다!
    - `subscription.dispose()`

- 일일이 이렇게 구독을 관리하는 것은 장황하다
    - DisposeBag 에 Disposable 들을 넣어만 두면, DisposeBag 이 메모리 해제되는 시점에 관련 자원들을 정리해준다.
    - **이것이 가장 자주쓰는 패턴!**
    - `disposed(by:)`
        - disposeBag 이 알아서 하나씩 dispose()를 호출해줄 것이다.
    
    ```swift
    // 1
      let disposeBag = DisposeBag()
    
      // 2
      Observable.of("A", "B", "C")
        .subscribe { // 3
          print($0)
        }
        .disposed(by: disposeBag) // 4
    ```
    
    - 이런식으로 정리해주지 않으면 메모리 릭이 발생한다.

## 옵저버블 팩토리 생성하기

- `deffered` Operator 사용
    - 첨보는디??
- 새로운 구독이 시작될 때마다 flip 의 상태가 변경된다
    
    filp 에 따라 다른 옵저버블을 반환한다
    
    ```swift
      let disposeBag = DisposeBag()
    
      // 1
      var flip = false
    
      // 2
      let factory: Observable<Int> = Observable.deferred {
    
        // 3
        flip.toggle()
    
        // 4
        if flip {
          return Observable.of(1, 2, 3)
        } else {
          return Observable.of(4, 5, 6)
        }
      }
    ```
    

## Traits 사용하기 ( 나중에 필요할 때 정리하자 )

Traits 는 기존 옵저버블보다 제한된 동작을 수행하는 옵저버블이다.

사용해도되고 사용하지 않아도 된다.

코드의 의도를 명확하게 해준다.

- 직관적인 코드의 작성 가능

종류

- Single
- Maybe
- Completable

## Challenge 🔥

- `do` 연산자의 사용
    - event 에 영향을 주지않는 작업을 할 수 있게 해준다
        - 즉, 파라미터는 따로 없는 핸들러를 구현할 수 있다.
        - onNext, afterNext, onSubscribe 등 다양한 시점에 할 어떤 동작을 정의할 수 있다.
    - 연산자이므로 옵저버블을 반환한다.
    
- `debug` 연산자의 사용
    - 옵저버블이 방출하는 이벤트 정보를 볼 수 있다!!!!!!!
    - identifier 를 전달하면 어느 옵저버블에서 발생하는 이벤트인지 확인할 수 있기 때문에 좋다!!!!
        - 특히 체이닝 상황에서
    
    ```swift
    observable
        .debug("테스트", trimOutput: false)
        .subscribe(
        onNext: { element in
          print(element)
        },
        onCompleted: {
          print("Completed")
        }
        ).disposed(by: DisposeBag())
    ```
    
    - 결과
    
    ```swift
    --- Example of: never ---
    2021-12-20 00:36:22.756: 테스트 -> subscribed
    2021-12-20 00:36:22.757: 테스트 -> isDisposed
    ```
