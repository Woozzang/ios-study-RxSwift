# TableView

## RxCocoa 로 바인딩

RxCocoa 를 사용하면 , Delegate 과 DataSource 를 사용할 필요가 없다

- 대신 옵저버블을 테이블 뷰에 바인딩한다.
- 그렇기 때문에 옵저버블이 테이블 뷰에 표시할 데이터를 방출해야한다.

cellForRowAt 대신 items 메서드를 사용한다

- 옵저버블을 테이블 뷰에 바인딩 할 때는 **items 메서드를 사용한다.**
- 여러 오버로딩 메서드가 있다.

다음은 items 메서드의 구현부분이다. 이 코드를 전부 이해해야 하는 것은 아니다.

- 샘플 코드를 보고 어떻게 사용하면 되는지 이해하면 된다.

```swift
public func items<Sequence: Swift.Sequence, Source: ObservableType>
        (_ source: Source)
        -> (_ cellFactory: @escaping (UITableView, Int, Sequence.Element) -> UITableViewCell)
        -> Disposable
        where Source.Element == Sequence {
            return { cellFactory in
                let dataSource = RxTableViewReactiveArrayDataSourceSequenceWrapper<Sequence>(cellFactory: cellFactory)
                return self.items(dataSource: dataSource)(source)
            }
    }
```

Delegate 대신 RxCocoa extension 의 옵저버블을 구독하는 방식을 사용한다.

클로저가 어떤 파라미터를 전달하는지 잘 알 수 없을 때?

- 우선 파라미터를 비우고 컴파일 에러 메시지를 살펴본다 ( 파라미터의 개수를 파악할 수 있다)
- 파라미터 개수만큼 채워넣고, 타입을 본다
- 더 좋은 방법이 있다면 수정하자... ( RxCocoa 쪽 구현 코드 너무 어렵게 짜여져 있다...)

## itemSelected

Control Event 타입

- 셀을 선택할때마다 next 이벤트를 방출한다 제네릭 타입은 IndexPath

## RxCocoa 를 사용하지만 따로 delegate 도 지정할수 있긴하다

그런데 방식이 다름

- **기존 방식으로 하면 Rxcocoa 바인딩된 부분은 작동하지 않음**
- 기존 방식으로 추가하면 Delegate 에만 반응하고 Rx 구현 내용은 더이상 동작하지 않는다.

대신 아래 코드 처럼 한다

- disposeBag 으로 정리해주어야 함

```swift
listTableView.rx.setDelegate(self)
.disposed(by:bag)
```

disposebag에 넣어주어야함

# 구현

## 가장 기본적인 방식

옵저버블을 control property 에 바인딩 하고 있다

```swift
nameObservable
       .bind(to: listTableView.rx.items) { tableView, row, element in

       let cell = tableView.dequeueReusableCell(withIdentifier: "standardCell")!

       cell.textLabel?.text = element
       return cell
     }
     .disposed(by: bag)
```

## dequeue 와 return cell 을 없애보자

items 메서드에 cellIdentifier 파라미터를 추가하였다.

```swift
nameObservable.bind(to: listTableView.rx.items(cellIdentifier: "standardCell")) {
       row, element, cell in

       cell.textLabel?.text = element
     }
     .disposed(by: bag)
```

## 시스템 기본 셀 말고 커스텀 셀을 사용해보자

`cellType` 이라는 파라미터에 타입을 전달한다.

```swift
productObservable.bind(to: listTableView.rx.items(cellIdentifier: "productCell", cellType: ProductTableViewCell.self)) { [weak self] row, element, cell in

   cell.categoryLabel.text = element.category

   cell.productNameLabel.text = element.name

   cell.summaryLabel.text = element.summary

   cell.priceLabel.text = self?.priceFormatter.string(for: element.price)

 }
 .disposed(by: bag)
```

## 셀 선택 이벤트를 처리하면서 데이터가 필요하다면

이벤트를 누가 방출하는가? 를 먼저 생각하자

- 셀이 방출한다
- RxCocoa 에서는 UI 에서 방출하는 이벤트는 보통 ControlEvent 타입의 속성이다.
- 여기서는 modelSelected()

```swift
listTableView.rx.modelSelected(Product.self)
       .subscribe(onNext: { product in
         print(product.name)
       })
       .disposed(by: bag)
```

## 셀 선택 이벤트를 처리하면서 인덱스로만 충분하다면

이벤트를 누가 방출하는가? 셀!!

인덱스패스로 충분하다면

여기서는 subscribe 를 쓰는 이유는??

- 

```swift
listTableView.rx.itemSelected
     .subscribe(onNext: { [weak self] indexPath in
       self?.listTableView.deselectRow(at: indexPath, animated: true)
     })
     .disposed(by: bag)
```

## 인덱스와 데이터가 모두 필요하다면 무엇을 고려해봐야할까?

zip 의 동작은?

왜 여기서는 bind 인가?

```swift
Observable.zip(listTableView.rx.itemSelected, listTableView.rx.modelSelected(Product.self))
     .bind { [weak self] (indexPath, product) in
       self?.listTableView.deselectRow(at: indexPath, animated: true)
       print(product.name)
     }
     .disposed(by: bag)
```
