class Storage {
  constructor() {
    this.window = null;
    this.db = null;

    this.name = '_YAC';
    this.data = {};
  }

  init(win) {
    this.window = win;
    this.db = win.localStorage;
    this.load();

    if (win.YAC.version !== this.data.version.toString()) {
      this.clear();
      this.load();
      this.data.version = win.YAC.version;
      this.save();
      this.load();
    }
  }

  load() {
    this.data = JSON.parse(this.db.getItem(this.name) || '{}');
  }

  save() {
    this.db.setItem(this.name, JSON.stringify(this.data));
  }

  clear() {
    this.db.clear();
  }
}

export default new Storage();
