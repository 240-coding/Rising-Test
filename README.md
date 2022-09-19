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
