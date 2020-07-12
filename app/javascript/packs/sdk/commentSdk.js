import CommentThreadFrame from './commentThreadFrame';

class CommentSdk {
  render(k) {
    const d = document;
    const w = window;
    const container = d.getElementById('yac-thread');
    const url = new URL('http://localhost:3000/embed/comments'); //?api_key='+k;
    url.searchParams.set('api_key', k);
    url.searchParams.set('origin', w.location.origin);
    url.searchParams.set('location', w.location.href);
    url.searchParams.set('canonical_url', container.dataset.canonical_url);

    const iframe = new CommentThreadFrame({
      src: url.toString(),
      width: '100%',
      classList: ['yac-frame'],
    });

    iframe.appendChildInto(container);
  }
}

export default new CommentSdk();
