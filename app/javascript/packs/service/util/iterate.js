
export const curry = (f) => (fn, iter) => iter ? f(fn, iter) : (iter) => f(fn, iter)

export const each = curry((f, iter) => {
  for (let i=0; i<iter.length; i++) f.bind(iter[i])(iter[i], i, iter);
  return iter;
})

export const map = curry((f, iter) => {
  const res = [];
  each((el, i, iter) => { res.push(f.bind(el)(el, i, iter)) }, iter);
  return res;
})

export const filter = curry((f, iter) => {
  const res = [];
  each((el, i, iter) => {
    if (f.bind(el)(el, i, iter)) res.push(iter[i]);
  }, iter);
  return res;
})

// fuurry(reduce);
export const reduce = curry((f, acc, iter) => {
  if (!iter) {
    const _a = acc[0];
    acc.shift();
    iter = acc;
    acc = _a;
  }
  each(el => {acc = f.bind(el)(acc, el)}, iter);
  return acc;
})

export const go = (args) => reduce((a, f) => f(a), args)

export const pipe = (fs) => {
  const f = fs.shift();
  return (as) => {
    fs.unshift(f(as));
    return go(fs);
  }
}

export const uniq = (iter) => filter((value, index, self) => self.indexOf(value) === index, iter).sort((a, b) => a - b);

export const uniq_object = (array, key) => {
  const unique = {};
  const res = [];
  for(let i=0; i<array.length; i++){
    if(typeof(unique[array[i][key]]) == "undefined"){
      res.push(array[i]);
    }
    unique[array[i][key]] = true;
  }
  return res;
}

export const map_with_trim = (v) => v.trim();

export const sum = (a, b) => a + b;

/*
 * Cascading
 */

export const toInt = (n) => parseInt(n || 0);
