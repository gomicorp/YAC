# YAC, your awesome comment

## 서비스 가이드

1. (ActiveAdmin) 조직 생성  
`api_key` 를 얻습니다.

1. (ActiveAdmin) 연동할 사이트 도메인을 등록  
`http:// or https://` 를 제거한 도메인이어야 합니다. (SSL 적용여부와 관계없이 동일 서비스임을 인식)

1. 스크립트 설치  
연동하려는 사이트의 HTML 을 편집해야 합니다.
    1. `<head>` 내에 sdk 삽입
        ```html
        <script src="https://yac.gomicorp.vn/embed/comments/sdk.js?api_key=<API_KEY>"></script>
        ```
    1. 서비스가 임베드될 위치를 잡아준다.
        ```html
        <div id="yac-thread" data-identifier="<UNIQ-KEY-OF-POST>"></div>
        ```
       
1. 서비스를 실행시킨 후, 서비스를 통해 페이스북으로 로그인.  
로그인이 완료되면, 임베드된 서비스 화면 **우측 상단에 자신의 페이스북 계정 이름이 나타납니다.**

1. (!) 관리자 등록.  
나타난 페이스북 계정이름과 조직 이름을 개발자에게 전달함으로써 이 계정을 해당 조직의 관리자 계정으로 등록할 수 있습니다.

## Features
- [x] Key 기능.
- [x] CDN & 임베드 기능.
- [x] 댓글 기능.
- [x] 이미지 멉로드 기능.
- [x] 사용자 페이스북 로그인 기능.
- [x] 별점 평가 기능.
- [ ] 대댓글 기능.
- [x] 댓글 페이지네이션.
- [x] 조직 관리자 기능.
- [x] 댓글 가리기 기능.

### Framework
- [ ] Iframe 이 호스트 서버를 로딩 중에 에러가 발생한 경우.

## Model

### Business Model

**Organization**
- [x] has_many sites
- [x] has_many posts through sites
- [x] has_many comments through posts

**Site**
- [x] has_many posts
- [x] has_many comments through posts

**Post**
- [x] has_many comments

**Comment**
- [ ] has_many comments

### User Model
`User`는 `gem Devise`를 사용하며, 인증 수단으로 Facebook 로그인을 사용합니다.
- [ ] a comment belongs_to User also.
- [ ] Admin inherited User
- [ ] a organization has_many admins
