export default class IFrame {
  constructor(args) {
    this._tagName = 'iframe';
    this._iframeTag = this.__makeTag(document.createElement(this._tagName), args);

    this._lifecycle = {
      willMountCallbacks: [],
      didMountCallbacks: [],
      mountFailedCallbacks: [],
    }
  }

  reset(args) {
    this._iframeTag = this.__makeTag(this._iframeTag, args);
  }

  appendChildInto(containerElement) {
    this.willMount();
    containerElement.appendChild(this._iframeTag);
  }

  // src 호스트를 로딩하기 전에 실행됨.
  willMount() {
    this.__executeQueue(this._lifecycle.willMountCallbacks);
  }

  // src 호스트를 로딩이 완료되었을 때 실행됨.
  didMount() {
    this.__executeQueue(this._lifecycle.didMountCallbacks);
  }

  // on error
  mountFailed() {
    this.__executeQueue(this._lifecycle.mountFailedCallbacks);
  }


  /**
   * Private
   */

  __makeTag(iframe, {src, classList = [], width, onload, onerror, ...args}) {
    iframe.src = src || null;
    iframe.width = width || '100%';
    for (const className of classList) iframe.classList.add(className);
    iframe.setAttribute('allowtransparency', 'true');
    iframe.setAttribute('frameborder', '0');
    iframe.setAttribute('scrolling', 'no');
    iframe.setAttribute('tabindex', '0');
    iframe.setAttribute('title', 'YAC');
    iframe.setAttribute('horizontalscrolling', 'no');
    iframe.setAttribute('verticalscrolling', 'no');

    if (typeof onload === 'function') this._lifecycle.didMountCallbacks.push(onload);
    iframe.onload = this.didMount.bind(this);

    if (typeof onerror === 'function') this._lifecycle.mountFailedCallbacks.push(onerror);
    iframe.onerror = this.mountFailed.bind(this);

    return iframe;
  }

  __executeQueue(queue) {
    for (const callbackFn of queue) {
      if (typeof callbackFn === 'function') callbackFn();
    }
  }

  __updateFrameHeight({ data: { targetFrameSelector, iframeHeight } }) {
    const iframe = document.querySelector(targetFrameSelector);

    iframe.style.height = iframeHeight + 'px';
  }
}
