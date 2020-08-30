import storage from './sdk/storage';
import sessionHandler from './sdk/sessionHandler';
import commentSdk from './sdk/commentSdk';
import api from './sdk/api';

window.YAC = {
  // If version change,
  // Clear all localStorage data
  version: '0.18.3',
  storage,
  sessionHandler,
  commentSdk,
  api,
  component: {
    cache: (elem, name, resource) => {
      delete resource.id;
      delete resource.created_at;
      delete resource.updated_at;
      delete resource.url;
      elem.dataset[name] = JSON.stringify(resource);
    },
    mark: (elem, resource) => {
      elem.querySelectorAll('[data-yac_marker]').forEach(marker => {
        marker.innerText = resource[marker.dataset.yac_marker]
      });
    },
  }
};
