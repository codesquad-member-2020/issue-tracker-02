# 👨🏻‍💻 DoCollabo - iOS Ground Rule

[🗒 요구사항 기술서](https://docs.google.com/spreadsheets/d/1PS3qxyUZ9dthyNLMbDasInC9mER7WPdZ7khVixbp6ng/edit?usp=sharing)

<br>

## 🤖 컨벤션

- View는 특별한 경우가 아니면 XIB로 구현하여 관리한다.
- 클래스 하나에 파일 하나를 갖도록 한다.
- 상속을 하지 않을 class는 final class로 선언한다.
- class의 첫줄은 개행으로 유지한다. extension, struct는 개행없이 코드를 작성한다.
- 그 외에 Swift 코드 스타일은 다음 컨벤션을 따른다.
  - [스타일 쉐어 코드 컨벤션](https://github.com/StyleShare/swift-style-guide#%EC%A4%84%EB%B0%94%EA%BF%88)


### 📂 폴더 구조

- 기능단위로 폴더를 나눈다.
- 해당 기능 폴더 안에서 아래와 같이 폴더를 나눈다.
  - Views/Models/ViewControllers


### ✅ PR 리뷰

- dev-ios로 PR을 요청시에는 서로에게 review 요청한다.
- dev로 PR을 요청할 때 JK에게 review 요청한다.


### 📑 이슈 및 PR 관리
- 스프레드 시트에 백로그를 Task 단위까지 나누며 GitHub 이슈에 추가한다. 
- Task 단위에 이슈번호를 기재한다.
- 이슈는 최대한 작게 쪼개며 커밋 하나에 이슈하나가 대응되도 괜찮다.
- PR은 GitHub Repository 프로젝트에 추가하여 관리한다.


### ⏱ 마일 스톤
- 기본적으로 ViewController 단위로 마일스톤을 정한다.


### 💥 소스 충돌 방지
아래와 같은 요소들은 수정 하기 전 상의한다.
- 프로젝트 설정, info.plist, Assets
- storyboard, XIB 수정