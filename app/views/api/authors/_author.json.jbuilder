json.except! author, *[
  :reset_password_token,
:reset_password_sent_at,
:remember_created_at,
  :encrypted_password,
  :confirmation_token,
  :confirmed_at,
  :confirmation_sent_at,
  :unconfirmed_email
]


json.comments_count author.comments.site_with(@site.id).count

json.url api_author_url(@organization.api_key, @site.domain, author)
json.comments_url api_comments_url(@organization.api_key, @site.domain, author_id: author.id)
