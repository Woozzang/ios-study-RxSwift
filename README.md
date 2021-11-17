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

[MVVM에 대한 이해](https://www.notion.so/MVVM-7fb2a2a7886e41b3ba8ca5bdf2738bfa)

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