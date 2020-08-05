json.except! site
json.posts_count site.posts.count
json.comments_count site.comments.count
json.authors_count site.authors.count

# json.comments_count author.comments.site_with(@site.id).count
json.url api_sites_url(@organization.api_key) + "/#{site.domain}"

json.comments_url api_comments_url(@organization.api_key, site.domain)
