import IFrame from '../helpers/iFrame';

export default class CommentThreadFrame extends IFrame {
  constructor(args) {
    super(args);
  }

  willMount() {
    const self = this;

    this._lifecycle.willMountCallbacks.push(() => {
      window.addEventListener('message', (e) => {
        switch (e.data.eventName) {
          case "updateFrameHeight":
            self.__updateFrameHeight(e);
            break
          default:
            return;
        }
      }, false);
    });

    super.willMount();
  }
}
