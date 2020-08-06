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

    if (win.YAC.version !== (this.data.version || '')) {
      console.log(`YAC | Current storage version is '${this.data.version}'.`);
      console.log(`YAC | Clear storage protocol starting...`);
      this.clear();
      this.load();
      this.data.version = win.YAC.version;
      this.save();
      this.load();
      console.log(`YAC | Finished. Storage version is '${this.data.version}'`);
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
    console.log(`YAC | Storage cleared.`);
  }
}

export default new Storage();
