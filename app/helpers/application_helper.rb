module ApplicationHelper
  require 'base64'

  def gravatar_for(user, options = {size: 80})
    size = options[:size]
    image_source =
      if user.avatar_attached?
        user.avatar_data
      else
        generated_avatar_data_uri(user, size)
      end

    image_tag(image_source, alt: user.username, class: "img-circle profile-avatar", size: "#{size}x#{size}")
  end

  def generated_avatar_data_uri(user, size = 80)
    seed = user.username.to_s
    palette = palette_for(seed)
    initials = user.username.to_s.split(/\s+/).map { |part| part[0] }.join.first(2).to_s.upcase.presence || "A"
    svg = <<~SVG
      <svg xmlns="http://www.w3.org/2000/svg" width="#{size}" height="#{size}" viewBox="0 0 #{size} #{size}">
        <defs>
          <linearGradient id="avatarGradient" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" stop-color="#{palette[:primary]}" />
            <stop offset="100%" stop-color="#{palette[:secondary]}" />
          </linearGradient>
        </defs>
        <rect width="#{size}" height="#{size}" rx="#{(size * 0.28).round}" fill="url(#avatarGradient)" />
        <circle cx="#{(size * 0.77).round}" cy="#{(size * 0.25).round}" r="#{(size * 0.12).round}" fill="rgba(255,255,255,0.25)" />
        <text x="50%" y="53%" text-anchor="middle" fill="#{palette[:ink]}" font-family="Manrope, Arial, sans-serif" font-size="#{(size * 0.34).round}" font-weight="800" dy=".1em">#{ERB::Util.html_escape(initials)}</text>
      </svg>
    SVG
    "data:image/svg+xml;base64,#{Base64.strict_encode64(svg)}"
  end

  def article_cover_data_uri(article, width: 1200, height: 720)
    seed = "#{article.title}-#{article.user&.username}"
    palette = palette_for(seed)
    accent = article.categories.first&.name || article.tag_list.first || "Editorial"
    title = article.title.to_s
    description = truncate(article.description.to_s, length: 120)
    svg = <<~SVG
      <svg xmlns="http://www.w3.org/2000/svg" width="#{width}" height="#{height}" viewBox="0 0 #{width} #{height}">
        <defs>
          <linearGradient id="coverGradient" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" stop-color="#{palette[:primary]}" />
            <stop offset="55%" stop-color="#{palette[:secondary]}" />
            <stop offset="100%" stop-color="#{palette[:tertiary]}" />
          </linearGradient>
        </defs>
        <rect width="#{width}" height="#{height}" fill="url(#coverGradient)" />
        <circle cx="#{(width * 0.82).round}" cy="#{(height * 0.2).round}" r="#{(height * 0.24).round}" fill="rgba(255,255,255,0.16)" />
        <circle cx="#{(width * 0.15).round}" cy="#{(height * 0.88).round}" r="#{(height * 0.22).round}" fill="rgba(12,16,20,0.18)" />
        <rect x="66" y="60" rx="30" ry="30" width="260" height="52" fill="rgba(255,255,255,0.18)" />
        <text x="98" y="94" fill="#F7F0E4" font-family="Manrope, Arial, sans-serif" font-size="22" font-weight="800" letter-spacing="3">#{ERB::Util.html_escape(accent.to_s.upcase)}</text>
        <text x="72" y="220" fill="#FCF8F1" font-family="Newsreader, Georgia, serif" font-size="74" font-weight="700">
          <tspan x="72" dy="0">#{ERB::Util.html_escape(title.to_s[0, 26])}</tspan>
          <tspan x="72" dy="86">#{ERB::Util.html_escape(title.to_s[26, 26].to_s)}</tspan>
        </text>
        <text x="72" y="476" fill="rgba(252,248,241,0.9)" font-family="Manrope, Arial, sans-serif" font-size="30" font-weight="500">
          <tspan x="72" dy="0">#{ERB::Util.html_escape(description.to_s[0, 58])}</tspan>
          <tspan x="72" dy="42">#{ERB::Util.html_escape(description.to_s[58, 58].to_s)}</tspan>
        </text>
        <text x="72" y="#{height - 72}" fill="rgba(252,248,241,0.92)" font-family="Manrope, Arial, sans-serif" font-size="26" font-weight="700">Alpha Blog</text>
      </svg>
    SVG
    "data:image/svg+xml;base64,#{Base64.strict_encode64(svg)}"
  end

  def page_title
    base = "Alpha Blog | Read Better"
    return @page_title if defined?(@page_title) && @page_title.present?
    return "#{@article.title} | Alpha Blog" if defined?(@article) && @article.present?
    return "#{@user.username} | Alpha Blog" if defined?(@user) && @user.present?

    base
  end

  def meta_description
    return @meta_description if defined?(@meta_description) && @meta_description.present?
    return truncate(@article.description.to_s, length: 155) if defined?(@article) && @article.present?
    return "A personal page for published articles, saved reads, and community presence." if defined?(@user) && @user.present?

    "Alpha Blog is an editorial reading platform for saving, discovering, and reading thoughtful articles in a clean, distraction-free interface."
  end

  def og_image
    "#{request.base_url}/app-icon-512.png"
  end

  private

  def palette_for(seed)
    palettes = [
      { primary: "#1F4F46", secondary: "#C78C45", tertiary: "#171717", ink: "#F8F1E4" },
      { primary: "#2A4365", secondary: "#E2A458", tertiary: "#12263A", ink: "#F8F3EA" },
      { primary: "#5B3A29", secondary: "#D8B26E", tertiary: "#26140D", ink: "#FFF6E8" },
      { primary: "#3E4C2B", secondary: "#E0BA72", tertiary: "#1D2315", ink: "#FBF7EF" }
    ]
    palettes[seed.to_s.bytes.sum % palettes.length]
  end
end
