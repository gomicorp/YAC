import CommentThreadFrame from './commentThreadFrame';

class CommentSdk {
  render(k) {
    this.api_key = k;

    const w = window;
    const container = document.getElementById('yac-thread');
    const url = new URL('httpis://yac.gomicorp.vn/embed/comments'); //?api_key='+k;

    container.innerHTML = '';

    url.searchParams.set('api_key', k);
    url.searchParams.set('domain', w.location.origin.replace(/http(s|):\/\//, ''));
    url.searchParams.set('location', w.location.href);
    url.searchParams.set('identifier', container.dataset.identifier);

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
