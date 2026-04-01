# Alpha Blog - Modern UI/Design System Guide

## 🎨 Design Overview

Your Alpha Blog has been completely redesigned with a modern, professional aesthetic using **Bootstrap 5** and a custom design system. The new design features:

- **Modern Color Palette** - Professional blue/gray theme with accent colors
- **Responsive Layout** - Fully mobile-optimized for all devices
- **Enhanced Components** - Beautiful buttons, cards, alerts, and forms
- **Smooth Interactions** - Hover effects, transitions, and animations
- **Professional Typography** - Clear hierarchy and readable fonts

---

## 🎯 Color Palette & Design Tokens

### Primary Colors

```
Primary Color:     #2c3e50  (Deep Blue-Gray) - Main brand color
Secondary Color:   #3498db  (Bright Blue) - Links and CTA buttons
Accent Color:      #e74c3c  (Coral Red) - Danger/Delete actions
```

### Status Colors

```
✅ Success:  #27ae60  (Green)
⚠️ Warning:  #f39c12  (Orange)
ℹ️ Info:     #3498db  (Blue)
❌ Danger:   #e74c3c  (Red)
```

### Backgrounds

```
Light Background:  #f8f9fa  (Off-white gray)
Dark Background:   #2c3e50  (Deep blue-gray)
```

---

## 🔘 Button Styles & Variants

### Button Types

**1. Primary Button** (Blue)
```html
<%= link_to "Click Me", path, class: "btn btn-primary" %>
```
- Used for main actions and CTAs
- Gradient blue background
- Hover effect: lifts up with enhanced shadow

**2. Success Button** (Green)
```html
<%= link_to "Approve", path, class: "btn btn-success" %>
```
- For positive/approval actions

**3. Danger Button** (Red)
```html
<%= link_to "Delete", path, class: "btn btn-danger" %>
```
- For destructive actions
- Warns user of consequences

**4. Warning Button** (Orange)
```html
<%= link_to "Caution", path, class: "btn btn-warning" %>
```
- For warning/attention actions

**5. Outline Button**
```html
<%= link_to "Maybe", path, class: "btn btn-outline-primary" %>
```
- Transparent with colored border
- Secondary/tertiary actions

### Button Sizes

```html
<!-- Extra Large (for CTAs) -->
<%= link_to "Start Now", path, class: "btn btn-primary btn-xl" %>

<!-- Large -->
<%= link_to "Click", path, class: "btn btn-primary btn-lg" %>

<!-- Normal (default) -->
<%= link_to "Click", path, class: "btn btn-primary" %>

<!-- Small -->
<%= link_to "Edit", path, class: "btn btn-primary btn-sm" %>

<!-- Icon Button (circular) -->
<%= link_to "×", path, class: "btn btn-primary btn-icon" %>
```

### Button Features

- **Smooth Transitions** - 0.3s hover animations
- **Ripple Effect** - Visual feedback on click
- **Shadow Depth** - Changes on hover for depth perception
- **Accessibility** - Full keyboard support and ARIA labels

---

## 📇 Card Components

Cards are the primary content containers in Alpha Blog.

```html
<div class="card">
  <div class="card-header">
    <h5>Card Title</h5>
  </div>
  <div class="card-body">
    <!-- Content here -->
  </div>
  <div class="card-footer">
    <!-- Footer actions -->
  </div>
</div>
```

### Card Features

- Rounded corners (12px border-radius)
- Subtle shadow effect
- Hover animation (lifts up with larger shadow)
- Header with gradient background
- Suitable for articles, statistics, user profiles

---

## 🎨 Forms & Inputs

### Form Group

```html
<div class="form-group mb-3">
  <label for="title" class="form-label">Article Title</label>
  <input type="text" class="form-control" id="title" placeholder="Enter title">
  <small class="form-text text-muted">Helper text here</small>
</div>
```

### Form Control Features

- **Focus State** - Blue border and shadow highlight
- **Validation** - Error states with red border
- **Disabled State** - Grayed out appearance
- **Smooth Transitions** - 0.3s border color change

### Textarea

```html
<textarea class="form-control" rows="5"></textarea>
```
- Min-height: 120px
- Vertical resize only
- Matches input styling

---

## 📢 Alerts & Notifications

### Alert Types

```html
<!-- Success (Green) -->
<div class="alert alert-success alert-dismissible fade show">
  ✓ Article published successfully!
  <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>

<!-- Danger (Red) -->
<div class="alert alert-danger alert-dismissible fade show">
  ✗ Error deleting article
  <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>

<!-- Warning (Orange) -->
<div class="alert alert-warning alert-dismissible fade show">
  ⚠ Be careful with this action
  <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>

<!-- Info (Blue) -->
<div class="alert alert-info alert-dismissible fade show">
  ℹ This is helpful information
  <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
```

### Alert Features

- **Left Border** - Color-coded visual indicator
- **Icons** - Status emoji for quick recognition
- **Dismissible** - Close button (×) to dismiss
- **Animation** - Slide in from top on appear

---

## 🏷️ Badges

Badges are small labeled elements for categories, tags, or status.

```html
<!-- Primary Badge -->
<span class="badge bg-primary">Primary</span>

<!-- Success Badge -->
<span class="badge bg-success">Success</span>

<!-- Info Badge -->
<span class="badge bg-info">Info</span>

<!-- Danger Badge -->
<span class="badge bg-danger">Danger</span>
```

### Badge Features

- **Pill Shape** - Rounded with 20px border-radius
- **Uppercase Text** - All caps for emphasis
- **Responsive** - Scales on mobile
- **Used For** - Categories, tags, statuses, admin badges

---

## 🔗 Navigation & Navbar

### Navbar Features

- **Gradient Background** - Professional gradient from dark blue to lighter blue
- **Active State Indicator** - Underline on current page
- **Dropdown Menus** - Smooth dropdown for categories, actions
- **Mobile Responsive** - Hamburger menu on mobile
- **User Menu** - Logged-in user profile dropdown

```html
<!-- Logo/Brand -->
<a class="navbar-brand">📝 Alpha Blog</a>

<!-- Nav Links -->
<a class="nav-link" href="/articles">Articles</a>

<!-- Dropdown -->
<div class="dropdown">
  <button class="btn btn-dropdown">Menu</button>
  <ul class="dropdown-menu">
    <li><a class="dropdown-item">Item</a></li>
  </ul>
</div>
```

---

## 📱 Article Components

### Article Card (List View)

```html
<div class="card article-card mb-4 shadow-sm">
  <div class="card-body">
    <h3 class="article-title">Article Title</h3>
    <div class="article-meta">
      👤 Author | 📅 2 days ago | 🏷️ 3 categories
    </div>
    <p class="article-excerpt">Article preview...</p>
    <div class="article-actions">
      <a href="#" class="btn btn-primary btn-sm">Read More</a>
      <a href="#" class="btn btn-warning btn-sm">Edit</a>
    </div>
  </div>
</div>
```

### Article Header (Detail View)

```html
<header class="article-header mb-4 pb-4">
  <h1 class="display-5 fw-bold">Article Title</h1>
  <div class="article-meta">
    Information: author, date, categories
  </div>
</header>
```

### Article-Specific Features

- **Meta Information** - Author avatar, publish date, category count
- **Excerpt Truncation** - 150 characters on list view
- **Category Badges** - Visual tag display
- **Action Buttons** - Read, Edit, Delete with appropriate permissions
- **Author Box** - Sidebar with author profile and other articles

---

## 🙎 User Profile

### Profile Card

- **Avatar** - Circular gravatar image, 120px on profile, 50px in lists
- **User Info** - Username, role badges
- **Admin Badge** - Yellow badge for admin users
- **Article Count** - Shows user's publication history

---

## 🎯 Home Page Layout

### Hero Section (Jumbotron)

- **Full-width Banner** - Gradient blue background
- **Large Heading** - Display-3 size (3.5rem)
- **Call-to-Action Buttons** - Primary and secondary actions
- **Pseudo-pattern Background** - Subtle grid pattern

### Latest Articles Section

- **Grid Layout** - 3 columns on desktop, 1-2 on mobile
- **Article Cards** - Compact card design with preview
- **Category Tags** - Visual category badges
- **Meta Information** - Author and date

### Statistics Section

- **3-Column Layout** - Total articles, users, categories
- **Large Numbers** - Display-5 text size
- **Light Background** - Off-white container

### Call-to-Action Section

- **Primary Color Background** - Blue gradient
- **White Text** - High contrast
- **Large Button** - Encourages signup/creation

---

## 🎨 Shadows & Depth

The design uses multiple shadow levels for visual hierarchy:

```
Small Shadow:      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1)
Medium Shadow:     box-shadow: 0 4px 8px rgba(0, 0, 0, 0.12)
Large Shadow:      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15)
Extra-Large:       box-shadow: 0 12px 24px rgba(0, 0, 0, 0.18)
```

- Buttons: Small shadow at rest, medium on hover
- Cards: Small shadow at rest, large on hover
- Sticky elements: Medium shadow for depth

---

## 📊 Typography

### Heading Sizes

```
h1: 2.5rem (40px)
h2: 2rem   (32px)
h3: 1.75rem (28px)
h4: 1.5rem (24px)
h5: 1.25rem (20px)
h6: 1rem   (16px)
```

### Font Family

```
Font: Segoe UI, Roboto, Helvetica Neue, Arial, sans-serif
Weight: 400 (normal), 600 (headings), 700 (bold)
Line-height: 1.6 (body), 1.2-1.4 (headings)
```

### Text Utilities

```html
<!-- Center aligned -->
<div class="text-center">Content</div>

<!-- Right aligned -->
<div class="text-right">Content</div>

<!-- Bold text -->
<strong class="fw-bold">Bold</strong>

<!-- Light text -->
<small class="text-light">Light</small>
```

---

## 🔄 Responsive Design Breakpoints

```
Mobile:        < 576px   (phones)
Tablet:        ≥ 576px   (tablets)
Desktop:       ≥ 768px   (small screens)
Large Desktop: ≥ 992px   (monitors)
XL Desktop:    ≥ 1200px  (large monitors)
```

### Mobile-First Features

- **Hamburger Menu** - On small screens
- **Single Column** - Articles stack vertically
- **Full-width Buttons** - Touch-friendly sizing
- **Reduced Padding** - Optimized spacing for small screens

---

## ✨ Interactive Elements

### Hover Effects

- **Buttons** - Lift up 2px with enhanced shadow
- **Links** - Color change and underline
- **Cards** - Lift up 4px with larger shadow
- **Navbar Links** - Color change and underline indicator

### Transitions

All interactive elements have 0.3s smooth transitions for:
- Color changes
- Border changes
- Box shadow changes
- Transform (scale/translate) changes

### Disabled States

- **Opacity** - 0.6 opacity for disabled buttons
- **Cursor** - `not-allowed` cursor
- **No Hover** - Hover effects disabled

---

## 🚀 Performance Tips

1. **Use Bootstrap Classes** - Don't write custom CSS when utility class exists
2. **Card Components** - Use for consistent styling across pages
3. **Validation States** - Add `.is-invalid` class for error styling
4. **Loading States** - Use spinner badges while loading
5. **Mobile Testing** - Always test on mobile devices

---

## 📝 CSS Variables & Customization

To customize the design, edit values in `app/assets/stylesheets/custom.css.scss`:

```scss
// Change primary color (currently #2c3e50)
$primary-color: #your-color;

// Change secondary color (currently #3498db)
$secondary-color: #your-color;

// Change accent color (currently #e74c3c)
$accent-color: #your-color;

// Change shadow intensity
$shadow-md: 0 4px 8px rgba(0, 0, 0, 0.12);
```

Then recompile CSS:
```bash
bundle exec rails assets:precompile
```

---

## 📚 Usage Examples

### Creating an Article Card

```erb
<div class="card article-card mb-4">
  <div class="card-body">
    <h3 class="article-title"><%= article.title %></h3>
    <div class="article-meta">
      <span>👤 <%= article.user.username %></span>
      <span>📅 <%= time_ago_in_words(article.created_at) %> ago</span>
    </div>
    <p><%= truncate(article.description, length: 150) %></p>
    <%= link_to "Read More", article_path(article), class: "btn btn-primary btn-sm" %>
  </div>
</div>
```

### Creating an Alert

```erb
<% if flash[:notice] %>
  <div class="alert alert-success alert-dismissible fade show">
    <%= flash[:notice] %>
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  </div>
<% end %>
```

### Creating a Form Group

```erb
<div class="form-group mb-3">
  <label for="title" class="form-label">Title</label>
  <input type="text" class="form-control" id="title" name="title">
</div>
```

---

## 🎓 Best Practices

1. ✅ Use semantic Bootstrap classes
2. ✅ Test responsiveness on all devices
3. ✅ Use standard button variants (primary, success, danger, warning)
4. ✅ Keep consistency across similar components
5. ✅ Use proper spacing utilities (mb-3, mt-2, etc.)
6. ✅ Include appropriate icons for better UX
7. ✅ Maintain color contrast for accessibility

---

## 🔗 Resources

- [Bootstrap 5 Documentation](https://getbootstrap.com/docs/5.0/)
- [Font Awesome Icons](https://fontawesome.com/icons)
- [SCSS Documentation](https://sass-lang.com/documentation)
- [Material Design Guidelines](https://material.io/design)

---

**Last Updated**: March 30, 2026
**Design System Version**: 1.0
**Bootstrap Version**: 5.3.0
