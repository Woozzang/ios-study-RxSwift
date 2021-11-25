# RxSwift 여행기
<img src= "https://user-images.githubusercontent.com/70905219/141748352-44e4fe18-7636-4337-b865-c9327a1f74e3.png" width= 25%>
<br />

우짱의 RxSwift 공부 내용을 노션에 남겨놓았어요 📝
* 서브 페이지는 저작권 문제로 우선 공개하지 않습니다.
* 내재화 시킨후 여러 레퍼런스를 종합해서 공개하겠습니다.
* 읽어보고 싶으신 분은 woozzaang@gmail.com 으로 연락 주세요 📧


# 목표

더 많은 오픈소스 코드들을 이해하기 위해서

- 이해하고 더 좋은 코드를 만들기 위해서

우아한 Reactive Programming 을 하고 싶어서

# 개요

Swift 로 구현한 ReativeX 라이브러리

RxSwift 깃허브에 장점이 나와있다

- [x]  읽어보기

단순하고 직관적인 코드를 작성할 수 있다

[Reative Programming](https://www.notion.so/Reative-Programming-0b94307622924a0e98626d0ff6d9cfe1)

[MVVM 과 RxSwift가 관련이 있나요?](https://www.notion.so/MVVM-7fb2a2a7886e41b3ba8ca5bdf2738bfa)

[Observables](https://www.notion.so/Observables-fcd8997df6fc427190819cc0cdc1d555)

[Disposables](https://www.notion.so/Disposables-fb22bc9ab4414883a39e0a4c2b163c75)

[Operator](https://www.notion.so/Operator-660d0f67e7f04bdeaf0ec4e28a094f48)

# Subjects

Observable 인 동시에 Obsever 인 객체

- 이벤트를 방출할수 있고, 이벤트를 구독할 수 있다
- 따라서 onNext() 를 통해 이벤트를 서브젝트에 전달할 수 있음

[Publish Subject](https://www.notion.so/Publish-Subject-28e73236c36247f7bbbefd93b551e7d5)

[Behavior Subject](https://www.notion.so/Behavior-Subject-b4010ca7bbe443d9a7fcbf18d566ee6e)

[ReplaySubject](https://www.notion.so/ReplaySubject-eec3896bd58c452ab548425347bd6cdb)

[Async Subject](https://www.notion.so/Async-Subject-c37a4ab34b1241e2bca5faa54dcb2136)

[Relay](https://www.notion.so/Relay-5f458cacf49a4b799bf4f524000f1e7e)

# Creating Operator

[just, of, from](https://www.notion.so/just-of-from-5d95b7ffe5964ea58b5aa7877225279b)
[range, generate](https://www.notion.so/range-generate-7518bfb7cf654ddca866936ed9d32d12)

[repeatElement](https://www.notion.so/repeatElement-e84b53a3fba24561991607e67f29bfd7)

[deferred](https://www.notion.so/deferred-feaf09e2137c47c8995577cebedf7766)

[🌟 create](https://www.notion.so/create-945df8ca56ec47da8641ec731da43b8b)

[empty, error](https://www.notion.so/empty-error-b721f8db034b42e0b939c8ffe24628dd)



# Filtering Opeators

[ignoreElements & elementAt](https://www.notion.so/ignoreElements-elementAt-c8cdb29138da42f6ae66085713087665)

[filter Operator](https://www.notion.so/filter-Operator-869e080526764d54b89c263983058673)

[skip, skipWhile, skipUntil](https://www.notion.so/skip-skipWhile-skipUntil-f487ff5a9a8949f980fd3fb1512044cc)

[take, takeWhile, takeUntil, takeLast](https://www.notion.so/take-takeWhile-takeUntil-takeLast-7147eabdd6ae4904bc0dd88dacd6eba9)

[single](https://www.notion.so/single-9b833e32b6d642ff8d96c12939663d12)

[distinctUntilChange](https://www.notion.so/distinctUntilChange-40cf74acc0834eb3bad73e6f42b4af5d)

[🌟 debounce, throttle](https://www.notion.so/debounce-throttle-ca3df4864d654f6c9aa2e7d6f925a3dd)


# Combining Operators

[startWith](https://www.notion.so/startWith-51788adb8b404b83af97eb489a034771)

[concat](https://www.notion.so/concat-d437af5abcf5464eb1689e228c4e3687)

[merge](https://www.notion.so/merge-dd663463585d46d59c7a7a41fcf90612)

[CombineLatest](https://www.notion.so/CombineLatest-8c80966dddba4f83bfd0928066c11b10)

[zip](https://www.notion.so/zip-608f318082bc481db14c7f817cce31d3)

[sample](https://www.notion.so/sample-1f519d37ccac4227904e203f3cde7830)

[switchLatest](https://www.notion.so/switchLatest-ebaf24aa81324c4f8e226b831f472caf)

[reduce](https://www.notion.so/reduce-65978624b489432c8252c02efcd14ca3)

# Conditional Operator

[Amb](https://www.notion.so/Amb-d4f69ea843944590bde81532150485ba)

# Time-based Operators

[interval](https://www.notion.so/interval-2f8bfb6638c8477986a81bdbda5fdf82)

[timer](https://www.notion.so/timer-4f90cd774b07436187f5b5d1e1a73f6a)

[timeout](https://www.notion.so/timeout-453ab9e50e0b4e4096b38b2c6311e1bc)

[delay, delaySubscription](https://www.notion.so/delay-delaySubscription-bf44125dde1e4be18de35a3d8cc7e188)

# Sharing Subscription

[Sharing Subscription](https://www.notion.so/Sharing-Subscription-11c39c277bff480f931943e53049d31a)

[multicast](https://www.notion.so/multicast-c9884643a21847f2b9338ba21ab2fa36)

[publish](https://www.notion.so/publish-b29c49163e594231ac2a2468ad036dee)

[replay](https://www.notion.so/replay-5d9cc4243aa84c1e8490b27a47dc097c)

[refCount](https://www.notion.so/refCount-52c181c624bb40bea059fb97aed632d6)

# Scheduler

[scheduler](https://www.notion.so/scheduler-12aabf47f974449d8364d9b758c6bd17)

# Error Handling

[catchError, catchErrorJustReturn](https://www.notion.so/catchError-catchErrorJustReturn-a0746bfc7b524e42a47017553b4094ed)

[retry](https://www.notion.so/retry-ea20fdb2139746fcafd1bc9c531af584)
