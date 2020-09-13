const admin = {
  templateAdapter: (data, params) => {
    params.page = params.page || 1;

    return {
      results: data.items,
      pagination: {
        more: (params.page * 30) < data.total_count
      }
    };
  },
  templateResult: (admin) => {
    if (admin.loading) return admin.text;

    const {email, name, image_url} = admin;

    return $(`
      <div class="d-flex align-items-center">
        <img src="${image_url}" width="40" height="40" class="rounded mr-4" />
        <p class="m-0"><span class="f-500 mr-3">@${name}</span> <span class="f--12 f-200">${email}</span></p>
      </div>`
    );
  },
  templateSelection: (admin) => (
    !admin.id ? admin.text
      : !admin.name ? 'Already registered.'
      : `@${admin.name} (${admin.email})`
  )
}

export default {
  admin
}
