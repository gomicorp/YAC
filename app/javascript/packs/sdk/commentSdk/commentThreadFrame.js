import IFrame from '../../helpers/iFrame';
import sessionHandler from '../../sdk/sessionHandler';

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
          case 'expireSessionHandler':
            sessionHandler.init(window);
            sessionHandler.clear();
          default:
            return;
        }
      }, false);
    });

    super.willMount();
  }
}
