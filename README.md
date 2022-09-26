## 🗓 2022.09.17 진행상황

- 기획서 작성 완료
- 1주차 작업 범위 확정

## 🗓 2022.09.18 진행상황

- 이미지 리소스 구하기
- 프로젝트 생성

## 🗓 2022.09.19 진행상황

### 폴더 세분화

- Configuration
- Util
- Source
    - Login
    - Main

### 로그인/회원가입 화면 구현

- `Login` 폴더 및 `LoginStoryboard` 생성
- Main 스토리보드가 아닌 새 스토리보드 사용 관련 에러 해결
    - [https://mini-min-dev.tistory.com/32](https://mini-min-dev.tistory.com/32)
    - Info.plist의 `Storyboard Name` 도 새 스토리보드 이름으로 바꿔주어야 한다.
- `LoginViewController` 생성 후 UI 작업
    - 로그인 화면 문구/이미지 부분 구현
        - UICollectionView 및 PageControl 사용
    - 로그인 버튼 추가
## 🗓 2022.09.20 진행상황

- 뼈대 레이아웃 구성
    - Tab Bar 생성 및 스타일링
    - 검색, 등록 메뉴는 modal로 뜨도록 구현
        - `UITabBarControllerDelegate` 의 `shouldSelect` 메소드 활용
        - [https://stackoverflow.com/questions/61371106/present-modally-uiviewcontroller-from-uitabbarcontroller-programmatically](https://stackoverflow.com/questions/61371106/present-modally-uiviewcontroller-from-uitabbarcontroller-programmatically)
- 등록 화면
    - 내비게이션 바 UI 구현
    - 하단 안전결제, 등록 버튼 및 주의사항 문구 부분 UI 구현
    - 사진 첨부 부분
        - UIView xib 안에 UICollectionView를 포함할 때는 xib에서 UICollectionViewCell을 추가할 수 없다. → Cell도 xib를 만들어서 register 해주어야 한다.
            - [https://stackoverflow.com/questions/38285469/can´t-add-items-to-uicollectionview-inside-uiview-xib](https://stackoverflow.com/questions/38285469/can%C2%B4t-add-items-to-uicollectionview-inside-uiview-xib)

## 🗓 2022.09.21 진행상황

- 등록 화면
    - 이미지 첨부시 보여질 UICollectionViewCell 구현
    - 상품명, 카테고리, 태그, 가격 부분 UI 구현
        - 각각 View를 두고 하단 border 설정
    - 상품 설명 부분 구현
        - UITextView
        - ⚠️ 입력한 텍스트 내용에 따라 UITextView의 높이가 동적으로 바뀌어야 하는데 이 부분은 방법을 더 찾아봐야 할 것 같다.
 ## 🗓 2022.09.22 진행상황

### 검색 화면

- 내비게이션 바 UI 구현
    - 뒤로 가기 버튼
    - UISearchBar
    - 홈 버튼
- 검색어 입력 여부에 따라 다른 view controller 띄우기
    - Custom container view controller 사용
    - [참고 영상](https://www.youtube.com/watch?v=tcdEjazeYtY&ab_channel=iOSAcademy)
    - 최근 검색어, 요즘 많이 찾는 검색어 UI 구현

## 🗓 2022.09.23 진행상황

### 검색 화면

- 인기 카테고리 UI 구현
    - UICollectionView
### 카카오 소셜로그인 구현

- 서버 로그인 API 호출하는 과정에서 500 Internal Server Error가 발생했다.
- → 사용자 이메일을 동의 항목으로 선택하지 않아서 발생하는 문제였다.
    - [참고했던 링크](https://devtalk.kakao.com/t/api/124184/2)
        
## 🗓 2022.09.24 진행상황

### 카카오 소셜 로그인

- 로그인 성공시 로직 구현
    - 사용자 jwt 토큰 UserDefaults에 저장 후 메인 스토리보드로 화면 전환
- 자동 로그인 기능 구현
    - 로그인 여부 UserDefaults에 저장 후 그 값에 따라 로그인 화면 또는 메인 화면을 띄운다.

### 홈 화면

- 배너
    - 우측 하단 `현재 페이지 번호 / 전체 페이지 번호` 수 뜨도록 하였다.
    - 타이머 기능을 사용해서 2초마다 자동으로 스크롤이 되도록 하였다.
- 카테고리
    - UICollectionView 사용
    - ⚠️ PageControl(?) 부분은 어떻게 구현해야 할지 더 고민해야 할 것 같다.
        - 일반적인 page control처럼 페이지가 딱 나뉘어 떨어지지 않고 자연스럽게 움직여야 해서 더 까다롭다…!
- 내비게이션 바
    - 왼쪽에는 메뉴(카테고리) 버튼, 오른쪽에는 검색 및 알림 버튼 배치
    - 스크롤뷰의 `contentOffset.y` 값이 0 이하면 내비게이션 바의 배경을 투명하게 하고 tintColor는 흰 색이 되도록 하였다. 아래로 스크롤 할 때는 내비게이션 바의 배경은 흰 색, tintColor는 검은색이 되도록 하였다.
        - `UIScrollViewDelegate` 의 `scrollViewDidScroll` 메소드 사용
- 추천상품/브랜드
    - UIContainerView, TabMan 라이브러리 사용
    - scroll view 스크롤 관련 이슈 해결
        - 추천상품/브랜드 collection view의 스크롤 기능을 막고 collection view 전체 높이에 맞춰서 container view 및 스크롤뷰 높이가 동적으로 설정되어야 한다.
        - 추천상품/브랜드 부분은 HomeViewController → Container View(TabManViewController) → RecommendViewController/BrandViewController 계층 구조로 이루어져 있기 때문에 부모 - 자식 view controller 사이에서 collection view의 높이를 전달받고, scroll view의 높이를 다시 설정해주어야 했다.
        - 해결 방법
            - HomeViewController의 ScrollView 안에 있는 ContentView의 너비와 높이를 ScrollView와 같게 설정한다. 이때 높이의 priority는 250으로 설정한다.
            - RecommendViewController의 Collection View의 constraint들의 priority는 250보다 높은 500으로 설정한다.
            - RecommendViewController의 `viewDidLayoutSubViews` 메소드 안에서 collection view의 높이를 `collectionView.contentSize.height` 으로 설정한다.
            - TabManViewController의 `viewDidLayoutSubViews` 메소드 안에서 RecommendViewController의 collection view의 높이 값을 부모 view controller에게 전달해준다.
            - ⚠️ 3개의 view controller들을 거쳐가야 해서 가독성이나 효율성 측면에서 좋은 방법인지는 잘 모르겠다. 나중에 더 고민해봐야 할 것 같다. 🥲
        - 참고 링크
            - [https://stackoverflow.com/questions/35014362/sizing-a-container-view-with-a-controller-of-dynamic-size-inside-a-scrollview](https://stackoverflow.com/questions/35014362/sizing-a-container-view-with-a-controller-of-dynamic-size-inside-a-scrollview)
            - [https://www.youtube.com/watch?v=MGQPRuoTdVo&ab_channel=DivyeshGondaliya](https://www.youtube.com/watch?v=MGQPRuoTdVo&ab_channel=DivyeshGondaliya)
    - 서버에서 받아온 데이터 추천상품 collection view에 반영하기
        1. 서버에서 받은 추천상품 데이터 RecommendViewController에 전달
            - 서버에서 배너 이미지와 추천상품에 관련한 데이터를 한꺼번에 보내준다. 따라서 HomeViewController와 RecommendViewController에서 같은 데이터를 중복해서 받지 않고 HomeViewController에서 받은 추천상품 데이터를 RecommendViewController에게 전달해주는 방식을 선택했다.
            - 데이터 전달 역시 사이에 TabManViewController가 껴있기 때문에 HomeViewController → TabManViewController → RecommendViewController 를 거쳐서 데이터를 전달해주어야 했다. 😂
                - ⚠️ 다음 view controller로 데이터를 전달하면서 `viewWillAppear` 를 호출해주어야 했는데, 이 과정이 비효율적인 것 같아서 NotificationCenter 같은 다른 방법으로 리팩토링 해야 할 것 같다.
        2. 서버에서 받은 데이터 반영 후 container view 높이 재계산
            - 서버에서 데이터를 받은 후 collection view가 reload 되면 container view의 높이도 다시 계산되어야 한다.
            - 처음에는 delegate 패턴을 사용해서 새로 바뀐 높이 값을 홈에 전달하려고 했지만 두 view controller가 바로 연결된 게 아니라서 사용하기가 어려웠다. 그래서 NotificationCenter를 사용해서 RecommendViewController의 `viewDidLayoutSubviews` 메소드가 호출될 때 HomeViewController에 Notification을 보내고, container view의 높이를 설정하는 메소드가 호출되도록 했다.
        
        홈 화면 구현을 내가 늦게 한 편이라 서버쪽에서 구현한 방식을 그대로 따랐는데, 다음부터는 서버측의 작업 속도와 맞추면서 효율적인 데이터 전달 형식을 서버 개발자분들과 함께 생각해봐야 할 것 같다고 느꼈다. 
## 🗓 2022.09.25 진행상황

### 홈 화면 내비게이션 바 UI 구현 방법 변경

- 홈 화면에서 템플릿에 있는 `isTransparent` 를 적용하면 내비게이션 바의 backgroundImage와 shadowImage가 없는 것처럼 적용된다. 그래서 홈 화면에서 상품 상세페이지 화면으로 들어가면 내비게이션 바 위에 status bar 부분이 검은 색으로 보여지는 문제가 있었다.
- 이를 해결하기 위해 `UINavigationBarAppearance()` 를 사용해서 배경색을 투명 또는 흰색으로 설정하는 방식으로 구현 방법을 변경하였다.

### 상품 상세페이지

- 내비게이션 바
- UIScrollView 사용
    - 상품 설명 내용에 따라 ScrollView의 높이가 동적으로 조절되어야 한다.
    - [구글링](https://stackoverflow.com/questions/44839101/how-to-dynamically-increase-the-height-of-scroll-view/44839329#44839329)을 해서 스크롤뷰의 높이를 조절하는 코드는 찾았지만 스크롤뷰의 끝부분까지 스크롤이 되지 않는다.
        - ⚠️ 스크롤뷰 높이에 임시 방편으로 상수값을 더하거나 곱해서 아래부분까지 다 보여지도록 했지만.. 더 알맞은 방법을 찾아봐야 할 것 같다.
- 서버에서 상품 데이터 받아오기
    - 어떤 상품 상세페이지에서는 `The data couldn’t be read because it is missing.` 라는 에러 메시지가 발생했다.
        - 특정 상품의 `goodsAddress` 값이 서버에 `null` 로 저장되어 있는데 이 변수를 옵셔널로 설정하지 않아서 발생한 에러였다.
- 상점 상품/거래후기
    - 각각을 collection view로 구현했다.
    - 판매 상품/거래후기 존재 여부에 따라 각각의 collection view를 숨기거나 보이도록 했다.
    - 거래후기는 최대 2개까지만 보여지도록 했다.

## 🗓 2022.09.26 진행상황

### 상품 결제 화면

- UICollectionView를 사용해서 각 부분(타이틀/배송지/번개포인트…)을 UICollectionViewCell로 구현했다.
- 배송지
    - 주소 변경
        - 배송지 변경 버튼을 누르면 `sheetPresentationController` 를 사용해서 bottom sheet 형태로 주소 선택 화면이 뜨도록 했다.
        - 처음에는 기본배송지로 설정된 주소 정보가 뜨고, 주소 변경 화면에서 다른 주소를 누르면 배송지가 그 주소로 바뀐다.
    - 수령 방법
        - 버튼들을 배열에 저장한 후 인덱스 값을 사용해서 수령 방법을 구분한다.
        - 주소 변경 화면과 마찬가지로 delegate 패턴을 사용한다.
    - 주소 수정
        - TextFieldEffects 라이브러리 사용
            - 기존에는 텍스트필드에 내용이 있으면 하단 선 색상이 Border Active Color로 쭉 설정되었다.
            - 텍스트필드에서 입력 중일 때만 하단 선이 검정색이 되도록 코드를 수정했다.
