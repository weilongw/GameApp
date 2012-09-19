module GeeksHelper
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(geek)
    gravatar_id = Digest::MD5::hexdigest(geek.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: geek.name, class: "gravatar")
    end
end
