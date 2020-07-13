import commentService from './comments/service';

/**
 * 댓글 서비스의 JS 동작을 정의합니다.
 * => 서비스 에이전트
 */

import onReady from '../helpers/onReady'
import { outerHeight } from '../helpers/computedStyle';

const iframeSelector = '#yac-thread iframe'; // in parent
const containerId = 'comments-wrapper'; // in child
const getCommentServiceFrameHeight = () => outerHeight(document.getElementById(containerId));

// 로딩됐을 때 프레임 높이 맞춰줘야 함.
const sendMessageToUpdateScreenSize = () => {
  parent.postMessage({
    eventName: 'updateFrameHeight',
    targetFrameSelector: iframeSelector,
    iframeHeight: getCommentServiceFrameHeight(),
  }, '*');
};
onReady(sendMessageToUpdateScreenSize);


// 에디터 내용이 변경되었을 때
const editorInputChangeListener = (e) => {
  // 프레임 높이 맞춰줘야 함.
  sendMessageToUpdateScreenSize();
};
const bindOnChangeListenerAtEditorInput = () => {
  const editors = document.querySelectorAll('trix-editor');
  editors.forEach(editor => {
    editor.addEventListener('trix-change', editorInputChangeListener);
  })
};
onReady(bindOnChangeListenerAtEditorInput);


// 소셜 로그인 버튼을 클릭하면, 부모 창의 페이지를 이동시켜줘야 함.
const bindOnClickListenerAtLoginBtn = () => {
  const loginBtn = document.querySelector('#loginBtn');
  loginBtn.addEventListener('click', commentService.__sendMessageToSocialLogin)
};
onReady(bindOnClickListenerAtLoginBtn);


// 별점 평가 체크박스가 체크되면, 이를 해당 라벨들의 상태로 옮겨줍니다.
const bindOnChangeListenerAtStarRatingInput = () => {
  // 폼 내에 별점 인풋 라디오들을 순회한다.
  document.querySelectorAll('.rating__input').forEach((input) => {
    // 라디오 인풋 각각의 값이 변경되었을 때
    input.addEventListener('change', (e) => {
      // 변경이 반영되어야 할 별점 아이템들을 가져와 순회한다.
      document.querySelectorAll(`label[for=${input.id}]`).forEach((targetLabel) => {
        // 해당 별점 아이템이 포함된 별점 UI의 전체 아이템을 순회한다.
        const labels = targetLabel.parentElement.querySelectorAll('label.rating__label');
        labels.forEach((label) => {
          // 원래 변경이 반영되어야 할 아이템인 경우 마킹해주고, 반대의 경우 마킹을 지워준다.
          if (label === targetLabel) {
            label.classList.add('active');
          } else {
            label.classList.remove('active');
          }
        })
      });
    });
  })
}
onReady(bindOnChangeListenerAtStarRatingInput);

/**
 * 댓글 생성에 대하여..
 *  댓글 생성 콜백은 'embed/comments/create.js.erb' 에서 호출됩니다.
 *  댓글 마크업 부분템플릿이 erb 로 정의되어 있고, 이를 재사용하기 위함입니다.
 */
window.commentService = commentService;
