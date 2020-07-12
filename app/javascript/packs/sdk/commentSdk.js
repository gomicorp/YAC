import CommentThreadFrame from './commentThreadFrame';

class CommentSdk {
  render(k) {
    this.api_key = k;

    const w = window;
    const container = document.getElementById('yac-thread');
    const url = new URL('http://localhost:3000/embed/comments'); //?api_key='+k;

    container.innerHTML = '';

    url.searchParams.set('api_key', k);
    url.searchParams.set('origin', w.location.origin);
    url.searchParams.set('location', w.location.href);
    url.searchParams.set('canonical_url', container.dataset.canonical_url);

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