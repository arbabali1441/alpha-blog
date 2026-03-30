module ApplicationHelper
  def gravatar_for(user, options = {size: 80})
    size = options[:size]
    image_source =
      if user.avatar_attached?
        user.avatar_data
      else
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      end

    image_tag(image_source, alt: user.username, class: "img-circle profile-avatar", size: "#{size}x#{size}")
  end
end
