import { outerHeight } from "../../helpers/computedStyle";
import { fadeOut } from "../../helpers/fade";

const iframeSelector = '#yac-thread iframe'; // in parent
const containerId = 'comments-wrapper'; // in child
const getCommentServiceFrameHeight = () => outerHeight(document.getElementById(containerId));
const getCommentItemId = (id) => 'YAC-Comment-'+id;

class CommentService {
  /**
   * 신규 댓글이 생성되었을 때,
   * 기존 댓글 목록 상단에 새로운 댓글을 추가합니다.
   * @param commentsCount
   * @param commentMarkUp
   */
  newCommentCreated({ commentsCount, commentMarkUp }) {
    this.__attachNewCommentMarkup(commentMartUp);
    this.__updatePostCommentsCounter(commentsCount);
    this.__clearEditor();
  }

  /**
   * 페이지네이션 요청의 결과로서,
   * 기존 댓글 목록 뒤에 다음 페이지 댓글 목록을 추가합니다.
   * @param nextPage
   * @param commentsMarkUp
   */
  displayRequestedPage({ nextPage, commentsMarkUp }) {
    if (nextPage) {
      this.__updatePaginator(nextPage);
    } else {
      this.__hidePaginator();
    }

    this.__attachCommentsPageMarkup(commentsMarkUp);
  }

  /**
   * 관리자 또는 작성자가 댓글을 숨김처리 했을 때,
   * 해당 댓글 UI 에 대한 숨김 인터렉션을 처리합니다.
   * @param commentId
   * @param commentsCount
   */
  hideComment(commentId, { commentsCount }) {
    const commentItem = document.getElementById(getCommentItemId(commentId));
    fadeOut(commentItem);
    this.__updatePostCommentsCounter(commentsCount);
  }

  /**
   * 관리자가 숨겨진 댓글을 다시 공개처리 했을 때,
   * 해당 댓글 UI 에 대한 공개 상태 전환 인터렉션을 처리합니다.
   * @param commentId
   * @param commentsCount
   * @param commentMarkUp
   */
  displayComment(commentId, { commentsCount, commentMarkUp }) {
    this.__attachRenewCommentMarkUp(commentId, commentMarkUp);
    this.__updatePostCommentsCounter(commentsCount);
  }


  /**
   * @private
   */

  __updatePostCommentsCounter(commentsCount) {
    const counters = document.querySelectorAll('.post-comments_count');
    counters.forEach(counter => {
      counter.innerText = commentsCount.toString();
    });
  }

  __attachNewCommentMarkup(markup) {
    const positionMark = document.querySelector('#newbie-comment-position');
    const temp = document.createElement('span');

    // Attach new comment markup
    temp.innerHTML = markup;
    positionMark.after(temp.firstChild);
    this.__sendMessageToUpdateScreenSize();
  }

  __attachRenewCommentMarkUp(commentId, markup) {
    const positionMark = document.getElementById(getCommentItemId(commentId));
    const temp = document.createElement('span');

    // Attach new comment markup
    temp.innerHTML = markup;
    positionMark.after(temp.firstChild);
    positionMark.remove();
    this.__sendMessageToUpdateScreenSize();
  }

  __attachCommentsPageMarkup(markup) {
    const moreBtnWrapper = document.querySelector('#comments-more-btn-wrapper');
    const temp = document.createElement('span');

    // Attach new comment markup
    temp.innerHTML = markup;
    moreBtnWrapper.before(temp);
    this.__sendMessageToUpdateScreenSize();
  }

  __clearEditor() {
    const newCommentEditor = document.querySelector('#new-comment-form trix-editor');
    newCommentEditor.value = '';
  }

  __hidePaginator() {
    const moreBtnWrapper = document.querySelector('#comments-more-btn-wrapper');
    moreBtnWrapper.classList.add('d-none');
  }

  __updatePaginator(nextPage) {
    const moreBtn = document.querySelector('#comments-more-btn');
    var url = new URL(moreBtn.href);
    var href = url.href.replace((nextPage-1)+'.js', nextPage+'.js');
    moreBtn.setAttribute('href', href);
  }


  __sendMessageToUpdateScreenSize() {
    parent.postMessage({
      eventName: 'updateFrameHeight',
      targetFrameSelector: iframeSelector,
      iframeHeight: getCommentServiceFrameHeight(),
    }, '*');
  };

  __sendMessageToSocialLogin(e) {
    const loginBtn = e.target;
    console.log(loginBtn.dataset.href);

    parent.postMessage({
      eventName: 'requestLoginRedirect',
      loginUrl: loginBtn.dataset.href
    }, '*');
  }
}

export default new CommentService();
