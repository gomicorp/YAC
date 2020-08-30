export default class Post {
  static findUrl(YAC, identifier) {
    return YAC.api_host+'/posts/'+identifier+'.json';
  }
}
