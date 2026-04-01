# Alpha Blog - Rails & Ruby Upgrade Guide

## Current Status
- **Rails**: 4.2.10
- **Ruby**: 2.7.8
- **Status**: ✅ Running and fully functional

---

## Upgrade Path: Rails 4.2.10 → Rails 6.1 → Rails 7.x

### Phase 1: Rails 4.2.10 → Rails 5.2 (Breaking Changes Ahead)

#### Step 1: Update Ruby to 3.0+
```bash
rbenv install 3.0.7
# Update .ruby-version to 3.0.7
```

**Why**: Rails 5.2+ requires Ruby 2.5+, Rails 6.0+ requires Ruby 2.7+. Ruby 3.0+ recommended for Rails 6+.

#### Step 2: Update Gemfile Dependencies

```ruby
gem 'rails', '~> 5.2.0'
gem 'sass-rails', '~> 6.0'
gem 'webpacker', '~> 5.4'   # Asset pipeline modernization
gem 'turbolinks', '~> 5.2'  # Kept, but will be replaced with turbo-rails in Rails 6+
gem 'jbuilder', '~> 2.7'
gem 'puma', '~> 4.3'

# Remove will_paginate, replace with:
gem 'kaminari', '~> 1.2'

# Remove old gems
# gem 'bootstrap-will_paginate'
# gem 'coffee-rails' (CoffeeScript deprecated in Rails 6+)
```

#### Step 3: Code Changes Required

1. **Remove deprecated config** (already done in your project):
   - ❌ `config.active_record.raise_in_transactional_callbacks = true` (Rails 5.0+)

2. **Update form syntax** from `form_for` to `form_with`:
   ```erb
   <!-- Rails 4.2 -->
   <%= form_for @article do |f| %>

   <!-- Rails 5.2+ -->
   <%= form_with(model: @article, local: true) do |f| %>
   ```

3. **Update asset pipeline** references if needed

4. **Update controller before_actions**:
   ```ruby
   # Deprecated in Rails 5.0+
   before_action :method_name, except: [:index]
   # Still works but use more modern pattern
   ```

5. **Update view pagination syntax**:
   ```erb
   <!-- will_paginate -->
   <%= will_paginate @articles %>
   
   <!-- Kaminari replacement -->
   <%= paginate @articles %>
   ```

#### Step 4: Database Migrations
```bash
bundle install
bundle exec rake db:migrate
```

---

### Phase 2: Rails 5.2 → Rails 6.1 (Recommended Version for Current Project)

#### Why Rails 6.1?
- ✅ Still supports Ruby 2.7+
- ✅ Modern asset handling with Webpacker
- ✅ Turbo for SPA-like experiences
- ✅ Good balance between modern and stable
- ✅ Less breaking changes than Rails 7

#### Step 1: Update Gemfile

```ruby
gem 'rails', '~> 6.1.0'
gem 'puma', '~> 5.6'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.4'
gem 'turbo-rails', '~> 1.4'
gem 'stimulus-rails'         # New: Lightweight JS framework

# Upgrade your gems
gem 'kaminari', '~> 1.2'
gem 'bootstrap', '~> 5.1'    # Modern Bootstrap 5
```

#### Step 2: Update Syntax

1. **form_for → form_with** (fully enforced):
   ```erb
   <%= form_with(model: @article) do |f| %>
     <%= f.text_field :title %>
     <%= f.submit %>
   <% end %>
   ```

2. **jQuery helpers → Rails UJS or Turbo data attributes**:
   ```erb
   <!-- Old -->
   <%= link_to 'Delete', article, method: :delete, data: { confirm: 'Sure?' } %>
   
   <!-- New (Rails 6.1+) -->
   <%= link_to 'Delete', article, method: :delete, data: { turbo_confirm: 'Sure?' } %>
   ```

3. **Asset references** - updated automatically

4. **JavaScript in ERB files** - move to Webpacker:
   ```bash
   # Create app/javascript/packs/application.js
   # Move JavaScript logic from app/assets/javascripts/
   ```

#### Step 3: Test & Deploy
```bash
bundle install
bundle exec rake db:migrate
bundle exec rails server
```

---

### Phase 3: Rails 6.1 → Rails 7.x (Latest)

#### Requirements
- Ruby 3.0+ (we recommend 3.2 or 3.3)
- **Breaking Changes**: Webpacker → Shakapacker or Esbuild/Import Maps

#### Why Consider Rails 7?
- ✅ Modern JavaScript bundling (Esbuild, Importmap)
- ✅ Hotwire fully integrated (Turbo + Stimulus)
- ✅ Better performance
- ✅ Latest security patches
- ⚠️ More breaking changes than 6.1

#### Update Strategy
1. Upgrade Ruby to 3.3
2. Replace Webpacker with Esbuild or Shakapacker  
3. Modernize JavaScript structure
4. Update view helpers and syntax

See Rails Guides for detailed 7.0 upgrade guide.

---

## Recommended Immediate Steps (Next 1-2 weeks)

1. **Backup current database** ✅
2. **Test Rails 5.2 upgrade** in development:
   - Create feature branch
   - Update Gemfile to Rails 5.2
   - Fix deprecated code patterns
   - Run full test suite
3. **Once stable**: Merge to main branch
4. **Then plan**: Rails 6.1 upgrade over next sprint

---

## Testing Checklist for Each Version

- [ ] `bundle exec rails server` runs without errors
- [ ] `bundle exec rake test` or `bundle exec rspec` passes
- [ ] All routes work: articles, users, categories, sessions
- [ ] Forms submit correctly
- [ ] Authentication (login/logout) works
- [ ] Create/Edit/Delete operations function
- [ ] Pagination displays correctly

---

## Files to Watch During Upgrade

Key files affected in your project:
- `config/application.rb` - Rails configuration
- `config/initializers/` - Compatibility patches
- `app/views/**/*.html.erb` - Form syntax, helpers
- `app/controllers/**/*.rb` - before_action patterns
- `Gemfile` - Dependencies

---

## Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| BigDecimal.new not found | Add `gem 'bigdecimal'` to Gemfile |
| Webpacker asset errors | Run `bundle exec rails webpacker:install` |
| form_for deprecated error | Replace with `form_with(model: ...)`  |
| Turbolinks conflicts | Replace with `turbo-rails` in Rails 6+ |
| CoffeeScript compatibility | Convert to ES6 JavaScript |

---

## Resources

- [Rails 5.2 Upgrade Guide](https://edgeguides.rubyonrails.org/5_2_release_notes.html)
- [Rails 6.0 Upgrade Guide](https://edgeguides.rubyonrails.org/6_0_release_notes.html)
- [Rails 6.1 Upgrade Guide](https://edgeguides.rubyonrails.org/6_1_release_notes.html)
- [Rails 7.0 Upgrade Guide](https://edgeguides.rubyonrails.org/7_0_release_notes.html)

---

**Last Updated**: March 30, 2026
