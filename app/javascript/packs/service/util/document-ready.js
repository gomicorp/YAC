import { jQuery, $ } from 'jquery'

var seq = 0;
var fireds = window.fireds || {};
export default function onReady(fn, seq_name) {
  var t = window.Turbolinks;

  if (!fn.name) {
    Object.defineProperty(fn, "name", { value: seq_name || seq.toString() });
  }

  var ready_handler = function (e) {
    if (fireds[fn.name]) return;
    fn(e);
    fireds[fn.name] = true;
  };

  if (!fireds[fn.name]) {
    if (t && t.supported) {
      document.addEventListener("turbolinks:load", ready_handler);
    } else {
      if (jQuery) {
        $(document).ready(fn)
      } else {
        // Mozilla, Opera, Webkit
        if (document.addEventListener) {
          document.addEventListener("DOMContentLoaded", ready_handler, false);
        }

        // Internet Explorer
        else if (document.attachEvent) {
          document.attachEvent("onreadystatechange", function (e) {
            if (document.readyState === "complete") {
              ready_handler(e);
            }
          });
        }
      }
    }
  }

  seq += 1;
}
