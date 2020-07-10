# YAC, your awesome comment

## Features
- [ ] Key 기능.
- [ ] CDN & 임베드 기능.
- [ ] 댓글 기능.
- [ ] 이미지 멉로드 기능.
- [ ] 사용자 페이스북 로그인 기능.
- [ ] 별점 평가 기능.
- [ ] 대댓글 기능.

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
