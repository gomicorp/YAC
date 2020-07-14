import IFrame from '../../helpers/iFrame';

export default class CommentThreadFrame extends IFrame {
  constructor(args) {
    super(args);
    this.api_key = args.api_key;
  }

  willMount() {
    const self = this;

    this._lifecycle.willMountCallbacks.push(() => {
      window.addEventListener('message', (e) => {
        switch (e.data.eventName) {
          case "updateFrameHeight":
            self.__updateFrameHeight(e);
            break
          case 'requestLoginRedirect':
            self.__requestLoginRedirect(e.data.loginUrl);
            break
          default:
            return;
        }
      }, false);
    });

    super.willMount();
  }
}
