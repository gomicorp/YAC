import storage from './storage';

class SessionHandler {
  constructor() {
    this.storage = storage;
    this.name = 'sessionHandler';
    this.data = null;
  }

  init(win) {
    this.storage.init(win);
    this.load();
  }

  load() {
    this.data = this.storage.data[this.name] || {};
  }

  save() {
    this.storage.data[this.name] = this.data;
    this.storage.save();
  }

  clear() {
    this.storage.data[this.name] = {};
    this.storage.save();
    this.load();
  }

  get user() {
    return this.data['user'];
  }

  set user(id) {
    this.data['user'] = id;
  }

  lookupUser() {
    const self = this;
    if (!self.user) {
      const uri = new URL(location.href);
      let consume_key_value = null;

      (uri.href.split('?')[1] || '').replace(uri.hash, '').split('&').map(el => {
        if (el.includes('=')) {
          const [key, val] = el.split('=');
          if (key === 'user') {
            self.user = val;
            consume_key_value = el;
          }
        }
      });
      self.save();
      history.replaceState('', '', location.href.replace(consume_key_value, ''));
    }
  }
}

export default new SessionHandler();
