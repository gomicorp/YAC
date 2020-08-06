import storage from './sdk/storage';
import sessionHandler from './sdk/sessionHandler';
import commentSdk from './sdk/commentSdk';

window.YAC = {
  // If version change,
  // Clear all localStorage data
  version: '0.18.2',
  storage,
  sessionHandler,
  commentSdk,
};
