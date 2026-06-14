# Complete Deployment & Publishing Guide

## 🚀 QUICK START - Publish to GitHub Pages (5 Minutes)

### Step 1: Create GitHub Repository
```bash
# Create a new repository on GitHub named: 
# <username>.github.io (for personal portfolio)
# OR
# customer-churn-analytics (for project portfolio)
```

### Step 2: Clone & Setup
```bash
# Clone the repository
git clone https://github.com/<your-username>/<your-repo-name>.git
cd <your-repo-name>

# Copy all project files to this directory
# - index.html
# - style.css
# - analysis.sql
# - schema.sql
# - customers.csv, orders.csv, products.csv
# - BRD.md
# - UserStories.md
# - README.md
```

### Step 3: Update Contact Information
**Edit `index.html` and replace placeholder text:**

```html
<!-- Find and replace these sections: -->
<p><strong>Email:</strong> <a href="mailto:your-email@gmail.com">your-email@gmail.com</a></p>
<p><strong>LinkedIn:</strong> <a href="https://linkedin.com/in/your-profile" target="_blank">linkedin.com/in/your-profile</a></p>
<p><strong>GitHub:</strong> <a href="https://github.com/your-username" target="_blank">github.com/your-username</a></p>
```

### Step 4: Push to GitHub
```bash
# Add all files
git add .

# Commit with message
git commit -m "Initial commit: Customer Churn Analytics Portfolio"

# Push to GitHub
git push -u origin main
```

### Step 5: Enable GitHub Pages
```
GitHub Repository Settings → Pages → Source: main branch → Save
```

✅ **Your site is now live at:** `https://<your-username>.github.io/<repo-name>`

---

## 📊 COMPLETE PROJECT STRUCTURE

```
customer-churn-analytics/
│
├── 📄 index.html              # Main portfolio page
├── 🎨 style.css               # Professional styling
│
├── 📋 Documentation/
│   ├── BRD.md                 # Business Requirements Document
│   ├── UserStories.md         # User Stories
│   └── README.md              # Project overview
│
├── 🗄️ Database/
│   ├── schema.sql             # Database design & tables
│   ├── analysis.sql           # 7 production-ready queries
│   └── data/
│       ├── customers.csv      # 20 customer records
│       ├── orders.csv         # 29 order transactions
│       └── products.csv       # 5 products
│
└── 📊 Dashboard/
    └── [Power BI screenshots to add]
```

---

## 🔧 LOCAL TESTING BEFORE PUBLISHING

### Option 1: Python Simple Server
```bash
# Navigate to project directory
cd /path/to/project

# Python 3
python -m http.server 8000

# Open: http://localhost:8000
```

### Option 2: Node.js (Node-http-server)
```bash
# Install globally
npm install -g http-server

# Run from project directory
http-server

# Open: http://localhost:8080
```

### Option 3: VS Code Live Server
```
1. Install "Live Server" extension in VS Code
2. Right-click index.html
3. Select "Open with Live Server"
```

---

## 📈 DATABASE SETUP (SQL Server or MySQL)

### For Local Database Testing:

**Step 1: Create Database**
```sql
CREATE DATABASE churn_analytics;
USE churn_analytics;
```

**Step 2: Run Schema**
```bash
# MySQL
mysql -u username -p churn_analytics < schema.sql

# SQL Server
sqlcmd -S <server> -U <username> -P <password> -d churn_analytics -i schema.sql
```

**Step 3: Import Data**
```bash
# MySQL - Load CSV
LOAD DATA INFILE 'path/to/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;
```

**Step 4: Run Analysis Queries**
```bash
# Execute all queries from analysis.sql
mysql -u username -p churn_analytics < analysis.sql
```

---

## 🎨 CUSTOMIZATION OPTIONS

### Change Color Scheme
Edit `style.css` root variables:
```css
:root {
    --primary-color: #1e40af;      /* Change this to your brand color */
    --secondary-color: #0f766e;    /* Secondary color */
    --accent-color: #dc2626;       /* Accent color */
}
```

### Add Power BI Dashboard Screenshots
1. Create `/assets` folder in project root
2. Add Power BI dashboard screenshots as:
   - `/assets/dashboard-1.png`
   - `/assets/dashboard-2.png`
3. Update HTML to embed images:
```html
<img src="assets/dashboard-1.png" alt="Power BI Dashboard" style="width: 100%; max-width: 1200px;">
```

### Add Google Analytics
Add to `<head>` section of index.html:
```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_MEASUREMENT_ID');
</script>
```

---

## ✅ PRE-PUBLICATION CHECKLIST

### Content
- [ ] Update email address in contact section
- [ ] Update LinkedIn URL with your profile
- [ ] Update GitHub URL with your profile
- [ ] Add Power BI screenshot references (or remove placeholder)
- [ ] Verify all links work correctly
- [ ] Review all text for typos

### Technical
- [ ] Test locally (all devices, all browsers)
- [ ] Test all hyperlinks (BRD.md, UserStories.md, SQL files)
- [ ] Verify responsive design on mobile
- [ ] Check loading speed (should be <2 seconds)
- [ ] Validate HTML (https://validator.w3.org/)

### Project Files
- [ ] Verify CSV data is properly formatted
- [ ] Test SQL queries independently
- [ ] Ensure all markdown files have proper formatting
- [ ] Check that all file references are correct

---

## 🚀 ADVANCED PUBLISHING OPTIONS

### Option 1: Vercel (Serverless, Recommended)
```bash
# 1. Install Vercel CLI
npm install -g vercel

# 2. Deploy
vercel

# 3. Follow prompts and accept defaults
```
✅ **Automatic HTTPS, CDN, Analytics included**

### Option 2: Netlify
```bash
# 1. Connect GitHub account
# 2. Select repository
# 3. Leave build settings blank (static site)
# 4. Deploy

# Or use CLI:
npm install -g netlify-cli
netlify deploy --prod --dir=.
```

### Option 3: GitLab Pages
```bash
# Create .gitlab-ci.yml in project root:
# See GitLab Pages documentation for latest config

git add .gitlab-ci.yml
git commit -m "Add GitLab CI configuration"
git push
```

---

## 📊 SEO OPTIMIZATION

### Update Meta Tags in `<head>`
```html
<meta name="description" content="Business Analyst portfolio showcasing customer churn analytics and data-driven insights">
<meta name="keywords" content="business analysis, data analytics, SQL, Power BI, customer retention">
<meta name="author" content="Your Name">
<meta property="og:title" content="Customer Churn Analytics - Business Analyst Portfolio">
<meta property="og:description" content="Comprehensive analysis reducing customer churn through data insights">
<meta property="og:image" content="https://your-site.com/assets/preview.png">
```

### Add Sitemap (for search engines)
```xml
<!-- sitemap.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://your-site.com/</loc>
    <priority>1.0</priority>
  </url>
</urlset>
```

---

## 🔒 SECURITY NOTES

### Before Publishing:
- [ ] Remove any personal sensitive data
- [ ] Use generic contact email (not personal home email)
- [ ] Do not hardcode API keys or passwords
- [ ] Ensure CSV data has no PII (personally identifiable info)
- [ ] Use HTTPS (automatic with GitHub Pages, Vercel, Netlify)

---

## 📱 MOBILE OPTIMIZATION

The CSS includes responsive design for:
- ✅ Mobile phones (320px+)
- ✅ Tablets (768px+)
- ✅ Desktops (1200px+)

Test on:
1. Chrome DevTools → Toggle Device Toolbar
2. Real iPhone/Android device
3. https://responsivedesignchecker.com/

---

## 🆘 TROUBLESHOOTING

### Page not loading?
```bash
# Verify all files are committed
git status

# Push any missing files
git add .
git commit -m "Add missing files"
git push
```

### CSS not applying?
- Clear browser cache (Ctrl+Shift+R)
- Verify style.css path is correct in HTML
- Check GitHub Pages is enabled in Settings

### Links broken?
- Verify file paths use lowercase
- Use relative paths: `./BRD.md` not `/BRD.md`
- Test locally first with Python server

### Slow loading?
- Optimize image sizes
- Use GitHub's CDN with raw.githubusercontent.com
- Enable GitHub Pages caching

---

## 📞 FINAL STEPS TO SHARE

Once published, share your portfolio:

1. **LinkedIn**
   - Post project summary
   - Link to live portfolio
   - Highlight key metrics and findings

2. **Email/Resume**
   - Add portfolio URL to resume
   - Reference in cover letters
   - Mention in job applications

3. **GitHub Profile**
   - Pin this repository
   - Add comprehensive README
   - Include link in GitHub bio

4. **Professional Networks**
   - Update portfolio links everywhere
   - Share with recruiters
   - Include in email signature

---

## 📈 NEXT STEPS FOR GROWTH

### Enhancement Ideas:
1. ✅ Add Power BI dashboard screenshots
2. ✅ Create interactive data visualizations (D3.js, Plotly)
3. ✅ Add Python data analysis notebook (Jupyter)
4. ✅ Build interactive SQL query tool
5. ✅ Add video walkthrough of project

### Related Portfolios to Build:
- Sales Analytics Dashboard
- Marketing Attribution Analysis
- Financial Forecasting Model
- Customer Lifetime Value Prediction

---

## 💡 SUCCESS METRICS

Track your portfolio's performance:
- Page views via GitHub Analytics
- Click-through rate to contact links
- Time on page (goal: >3 minutes)
- Bounce rate (goal: <30%)
- Use UTM parameters for LinkedIn tracking

---

**Good luck with your portfolio! You're ready to publish. 🎉**

For questions or updates, revisit this guide or check GitHub/Vercel documentation.
