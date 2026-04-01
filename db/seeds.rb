# frozen_string_literal: true

puts "Seeding Alpha Blog demo content..."

author = User.find_or_create_by!(email: "editor@alphablog.app") do |user|
  user.username = "arbab_editor"
  user.password = "password"
  user.admin = true
end

reader = User.find_or_create_by!(email: "reader@alphablog.app") do |user|
  user.username = "quiet_reader"
  user.password = "password"
end

curator = User.find_or_create_by!(email: "curator@alphablog.app") do |user|
  user.username = "story_curator"
  user.password = "password"
end

category_names = [
  "Reading",
  "Design",
  "Productivity",
  "Writing",
  "Technology"
]

categories = category_names.each_with_object({}) do |name, memo|
  memo[name] = Category.find_or_create_by!(name: name)
end

stories = [
  {
    title: "A Better Way to Save Articles for the Evening",
    description: "Instapaper-style reading works best when the queue feels calm, finite, and intentional. This piece explores how a simple nightly reading list can turn scattered links into a ritual you actually look forward to.",
    category_names: ["Reading", "Productivity"],
    tags: "reading queue, focus, habits"
  },
  {
    title: "Why Reader Mode Makes Longform Feel Humane Again",
    description: "A clean page changes how we think. Removing banners, sidebars, and interruptions lets the writing breathe and helps readers stay with an idea long enough for it to matter.",
    category_names: ["Reading", "Design"],
    tags: "reader mode, typography, calm ui"
  },
  {
    title: "Designing a Homepage That Feels Like a Magazine",
    description: "Great editorial products use rhythm, hierarchy, and restraint. Here is a practical look at featured shelves, trending clusters, and visual pacing for a modern article platform.",
    category_names: ["Design", "Writing"],
    tags: "editorial design, homepage, layout"
  },
  {
    title: "Highlights Are Tiny Promises to Your Future Self",
    description: "The best highlight systems are lightweight and personal. A saved sentence is less about decoration and more about building a map back to what moved you the first time.",
    category_names: ["Reading", "Technology"],
    tags: "highlights, notes, knowledge"
  },
  {
    title: "Bookmarks, Likes, and Comments Without the Noise",
    description: "Engagement does not need to feel loud. Thoughtful interaction can still help readers discover strong work when the signals stay simple and useful.",
    category_names: ["Technology", "Writing"],
    tags: "engagement, comments, likes"
  },
  {
    title: "How to Build a Personal Reading Library That Lasts",
    description: "Saving an article is easy. Returning to it is harder. This story looks at small product choices that make people revisit saved ideas instead of letting them disappear into a pile.",
    category_names: ["Productivity", "Reading"],
    tags: "bookmarks, library, curation"
  }
]

stories.each_with_index do |story, index|
  article = Article.find_or_create_by!(title: story[:title]) do |record|
    record.description = story[:description]
    record.user = [author, curator, author, reader, curator, author][index]
    record.view_count = 30 + (index * 17)
  end

  article.update_columns(view_count: 30 + (index * 17)) if article.view_count.blank?

  story[:category_names].each do |category_name|
    category = categories.fetch(category_name)
    ArticleCategory.find_or_create_by!(article: article, category: category)
  end

  article.tag_list = story[:tags]
  article.save! if article.changed?

  Like.find_or_create_by!(user: reader, article: article)
  Like.find_or_create_by!(user: curator, article: article) if index.even?
  Bookmark.find_or_create_by!(user: reader, article: article)
  Bookmark.find_or_create_by!(user: author, article: article) if index.odd?

  Comment.find_or_create_by!(user: reader, article: article, content: "Saved this one for a slower reread later.")
  Comment.find_or_create_by!(user: curator, article: article, content: "Strong structure and a clean point of view.") if index < 3

  Highlight.find_or_create_by!(user: reader, article: article, content: story[:description].split(".").first.to_s.strip, position: 1)
end

puts "Alpha Blog demo content ready."
