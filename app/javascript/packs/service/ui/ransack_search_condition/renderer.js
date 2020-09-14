const bindRemoveField = () => {
  $('form .remove_condition_fields, form .remove_fields').unbind().click((evt) => {
    $(evt.currentTarget).closest('.field').remove();
    evt.preventDefault();
  });
}

const bindAddField = () => {
  $('form .add_condition_fields, form .add_fields').unbind().click((evt, ...arg) => {
    evt.preventDefault();

    const btn = evt.currentTarget;
    const time = new Date().getTime();
    const regexp = new RegExp(btn.dataset.id, 'g');
    $(btn).closest('fieldset').find('.condition_fields-container').append(btn.dataset.fields.replace(regexp, time));

    bindRemoveField();
  });
}

export default {
  render: () => {
    document.addEventListener('turbolinks:load', () => {
      bindAddField();
      bindRemoveField();
    });
  }
}
