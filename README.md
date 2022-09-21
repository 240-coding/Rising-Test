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
