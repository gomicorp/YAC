// import $ from 'jquery';
// import 'jquery-ui';
import 'select2/dist/js/select2.full.min';

import { each } from '../util/iterate';
import onReady from "../util/document-ready";

import 'select2/dist/css/select2.min.css';
import './auto-complete.scss';

import template from './auto-complete/template';

const renderAutoComplete = (select) => {
  const width = select.dataset.width || '100%';
  const source = select.dataset.autocompleteSrc;
  const placeholder = select.dataset.autocompletePlaceholder || 'Search ..';
  const templateName = select.dataset.autocompleteTemplate;

  const {
    templateAdapter,
    templateResult,
    templateSelection,
  } = template[templateName];

  $(select).select2({
    minimumInputLength: 1,
    ajax: {
      url: source,
      dataType: 'json',
      delay: 500,
      processResults: templateAdapter,
      cache: true
    },
    width,
    placeholder,
    templateResult,
    templateSelection,
  })
};

document.addEventListener("turbolinks:load", () => {
  const autoCompleteSelects = $('select[data-autocomplete-src]');
  each(renderAutoComplete, autoCompleteSelects);
});
