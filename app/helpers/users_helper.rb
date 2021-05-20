module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    if user.image.attached?
      gravatar_url = user.image.variant(resize_to_limit: [options[:size], options[:size]])
    else
      gravatar_url = 'default_profile_pic.jpg'
    end
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
