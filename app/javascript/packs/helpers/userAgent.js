export default function userAgent() {

  var safari = navigator.userAgent.indexOf("Safari") > -1;
  // Chrome has Safari in the user agent so we need to filter (https://stackoverflow.com/a/7768006/1502448)
  var chrome = navigator.userAgent.indexOf('Chrome') > -1;
  if ((chrome) && (safari)) safari = false;

  return {
    chrome,
    safari
  }
}
