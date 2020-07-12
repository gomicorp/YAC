import { outerHeight } from "../../helpers/computedStyle";

const iframeSelector = '#yac-thread iframe'; // in parent
const containerId = 'comments-wrapper'; // in child
const getCommentServiceFrameHeight = () => outerHeight(document.getElementById(containerId));

class CommentService {
  newCommentCreated({ commentsCount, commentMartUp }) {
    this.__attachNewCommentMarkup(commentMartUp);
    this.__updatePostCommentsCounter(commentsCount);
    this.__clearEditor();
  }

  displayRequestedPage({ nextPage, commentsMarkUp }) {
    if (nextPage) {
      this.__updatePaginator(nextPage);
    } else {
      this.__hidePaginator();
    }

    this.__attachCommentsPageMarkup(commentsMarkUp);
  }


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
}

export default new CommentService();
