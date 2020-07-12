# YAC, your awesome comment

## Features
- [x] Key 기능.
- [x] CDN & 임베드 기능.
- [x] 댓글 기능.
- [x] 이미지 멉로드 기능.
- [ ] 사용자 페이스북 로그인 기능.
- [ ] 별점 평가 기능.
- [ ] 대댓글 기능.
- [x] 댓글 페이지네이션.

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
