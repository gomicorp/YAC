import CommentThreadFrame from './commentSdk/commentThreadFrame';

class CommentSdk {
  render(k, d, i) {
    this.api_key = k;

    const w = window;
    const container = document.getElementById('yac-thread');
    const url = new URL(window.YACHost+'embed/comments'); //?api_key='+k;

    if (!container) return;

    container.innerHTML = '';

    url.searchParams.set('api_key', k);
    url.searchParams.set('domain', d || w.location.origin.replace(/http(s|):\/\//, ''));
    url.searchParams.set('location', w.location.href);
    url.searchParams.set('identifier', i || container.dataset.identifier);

    if (w.YAC.sessionHandler.data && w.YAC.sessionHandler.data.user) {
      url.searchParams.set('user_id', w.YAC.sessionHandler.data.user);
      console.log(url.toString());
    }

    this.iframe = new CommentThreadFrame({
      api_key: this.api_key,
      src: url.toString(),
      width: '100%',
      classList: ['yac-frame'],
    });

    this.iframe.appendChildInto(container);
  }
}

export default new CommentSdk();
