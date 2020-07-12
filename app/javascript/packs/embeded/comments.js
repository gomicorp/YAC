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


/**
 * 댓글 생성에 대하여..
 *  댓글 생성 콜백은 'embed/comments/create.js.erb' 에서 호출됩니다.
 *  댓글 마크업 부분템플릿이 erb 로 정의되어 있고, 이를 재사용하기 위함입니다.
 */
window.commentService = commentService;
