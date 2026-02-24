# Chrome Web Store Deployment Guide

## Prerequisites

### 1. Chrome Web Store Developer Account
- Go to [Chrome Web Store Developer Dashboard](https://chrome.google.com/webstore/devconsole)
- Sign in with your Google account
- Pay the **one-time $5 registration fee** (if not already paid)
- Complete the developer account setup

### 2. Required Assets Checklist

Before submitting, ensure you have:

- ✅ **Icons** (you have these):
  - `icons/icon16.png` (16x16px)
  - `icons/icon48.png` (48x48px)
  - `icons/icon128.png` (128x128px)

- ✅ **Store Assets** (you have these):
  - `store_assets/screenshot.png` (1280x800px or 640x400px recommended)
  - `store_assets/promo_small.png` (440x280px - optional but recommended)

- ⚠️ **Additional Assets You May Need**:
  - **Promo tile** (920x680px) - for featured placement
  - **Marquee** (1400x560px) - for featured placement
  - **Small promo tile** (440x280px) - you have this
  - **Screenshots** (1280x800px or 640x400px) - you have one, but consider adding 1-5 more

## Step 1: Prepare Your Extension

### 1.1 Verify Manifest Requirements

Your `manifest.json` should include:
- ✅ `manifest_version: 3` (you have this)
- ✅ `name` (you have this)
- ✅ `version` (you have this)
- ✅ `description` (you have this)
- ✅ `icons` (you have this)
- ✅ `permissions` (you have this)

**Optional but recommended additions:**

```json
{
  "manifest_version": 3,
  "name": "Magnet Link Grabber",
  "version": "1.0.0",
  "description": "Extract all magnet links from the current page, format them, and copy them to clipboard.",
  "author": "Your Name or Organization",
  "homepage_url": "https://your-website.com", // Optional
  "permissions": ["activeTab", "scripting"],
  // ... rest of your manifest
}
```

### 1.2 Remove Development Files

Before creating the zip, remove:
- `TESTING.md` (or any other documentation files)
- `DEPLOYMENT.md` (this file)
- `magnet-link-grabber.zip` (old zip file)
- Any `.git` folders
- Any development scripts

### 1.3 Create Production Zip File

**Important:** Only include the files needed for the extension to run:

**Required files:**
- `manifest.json`
- `popup.html`
- `popup.js`
- `popup.css`
- `content.js`
- `icons/` folder (with all icon files)

**Do NOT include:**
- `store_assets/` folder (these are uploaded separately)
- `TESTING.md` or other docs
- `.zip` files
- `.git` folders
- Any development files

**Windows PowerShell command to create zip:**
```powershell
# Navigate to the extension directory
cd C:\Projects\magnet-link-grabber\magnet-link-grabber

# Create zip (excludes store_assets and docs)
Compress-Archive -Path manifest.json,popup.html,popup.js,popup.css,content.js,icons -DestinationPath magnet-link-grabber-v1.0.0.zip -Force
```

**Or manually:**
1. Select only the required files and folders
2. Right-click → Send to → Compressed (zipped) folder
3. Name it `magnet-link-grabber-v1.0.0.zip`

## Step 2: Chrome Web Store Developer Dashboard

### 2.1 Access Developer Dashboard
1. Go to [Chrome Web Store Developer Dashboard](https://chrome.google.com/webstore/devconsole)
2. Click **"New Item"** button
3. Click **"Upload"** and select your zip file
4. Wait for upload and validation to complete

### 2.2 Fill Out Store Listing

#### **1. Store Listing Tab**

**Name:** (max 45 characters)
```
Magnet Link Grabber
```

**Summary:** (max 132 characters)
```
Extract and copy all magnet links from any webpage with one click.
```

**Description:** (max 16,000 characters)
```
🧲 Magnet Link Grabber - Extract and Copy Magnet Links Instantly

Magnet Link Grabber is a powerful Chrome extension that helps you quickly extract all magnet links from any webpage. Perfect for torrent users who need to collect multiple magnet links efficiently.

✨ Features:
• Automatically scans the current page for all magnet links
• Displays links in a clean, organized list
• Select individual links or select all at once
• One-click copy to clipboard
• Automatic duplicate removal (based on torrent hash)
• Shows torrent names when available
• Works on any website

🎯 How to Use:
1. Navigate to any webpage containing magnet links
2. Click the extension icon in your toolbar
3. Review the found magnet links
4. Select the links you want
5. Click "Copy Selected Links" to copy them to your clipboard

🔒 Privacy:
• No data collection
• No external servers
• All processing happens locally in your browser
• No tracking or analytics

Perfect for:
• Torrent site users
• Content collectors
• Anyone who needs to extract multiple magnet links quickly

Install now and start grabbing magnet links faster than ever!
```

**Category:**
- Select: **Productivity** or **Utilities**

**Language:**
- Select your primary language (usually English)

#### **2. Privacy Practices**

**Single Purpose:**
- ✅ Yes, my extension has a single purpose

**Host Permissions:**
- Explain why you need `<all_urls>`:
  ```
  The extension needs access to all URLs to scan for magnet links on any webpage the user visits. No data is collected or transmitted - all processing happens locally in the browser.
  ```

**Data Handling:**
- ✅ The extension does not collect user data
- ✅ The extension does not transmit user data
- ✅ The extension does not use analytics

#### **3. Distribution**

**Visibility:**
- **Unlisted** (for testing) - Only people with the link can install
- **Public** (for production) - Anyone can find and install

**Regions:**
- Select regions where you want to distribute (or select all)

**Pricing:**
- **Free** (most common)
- **Paid** (if you want to charge)

#### **4. Upload Assets**

**Screenshots:**
- Upload `store_assets/screenshot.png` (1280x800px recommended)
- You can upload up to 5 screenshots
- Consider creating additional screenshots showing:
  - The popup interface
  - Before/after comparison
  - Different use cases

**Promotional Images (Optional):**
- **Small promo tile:** Upload `store_assets/promo_small.png` (440x280px)
- **Promo tile:** (920x680px) - for featured placement
- **Marquee:** (1400x560px) - for featured placement

**Store Icon:**
- Upload `icons/icon128.png` (128x128px)

### 2.3 Review and Submit

1. Review all information carefully
2. Check for any validation errors (shown in red)
3. Click **"Submit for Review"**

## Step 3: Review Process

### Timeline
- **Initial review:** Usually 1-3 business days
- **Re-submission:** If changes are needed, another 1-3 days

### Common Rejection Reasons
1. **Privacy policy missing** (if you collect data)
2. **Permissions not justified** - Make sure you explain why you need `<all_urls>`
3. **Poor description** - Make it clear what the extension does
4. **Missing screenshots** - Add clear screenshots
5. **Violation of policies** - Review [Chrome Web Store policies](https://developer.chrome.com/docs/webstore/program-policies/)

### If Rejected
1. Read the feedback carefully
2. Make necessary changes
3. Update your extension
4. Create a new zip with updated version number
5. Re-upload and resubmit

## Step 4: After Approval

### Update Your Extension
1. Make changes to your code
2. **Update version number** in `manifest.json`:
   ```json
   "version": "1.0.1"
   ```
3. Create new zip file
4. Go to Developer Dashboard → Your Extension → **"Package"** tab
5. Upload new version
6. Submit for review (usually faster for updates)

### Monitor Your Extension
- Check reviews and ratings
- Respond to user feedback
- Monitor crash reports (if any)
- Track install statistics

## Best Practices

### 1. Version Numbering
- Use semantic versioning: `MAJOR.MINOR.PATCH`
- Example: `1.0.0` → `1.0.1` (patch) → `1.1.0` (minor) → `2.0.0` (major)

### 2. Update Description
- Keep description updated with new features
- Highlight improvements in update notes

### 3. Screenshots
- Use clear, high-quality screenshots
- Show the extension in action
- Highlight key features

### 4. Privacy
- Be transparent about data collection (you collect none, which is great!)
- Clearly state permissions usage

### 5. Support
- Consider adding a support email or website
- Respond to user reviews

## Quick Checklist Before Submission

- [ ] Extension tested thoroughly
- [ ] Version number set correctly
- [ ] All required files in zip (no unnecessary files)
- [ ] Icons are correct sizes and formats
- [ ] Screenshots prepared (at least 1, up to 5)
- [ ] Description is clear and compelling
- [ ] Privacy practices documented
- [ ] Permissions justified
- [ ] No console errors
- [ ] Works on multiple websites
- [ ] Zip file created correctly

## Resources

- [Chrome Web Store Developer Dashboard](https://chrome.google.com/webstore/devconsole)
- [Chrome Web Store Policies](https://developer.chrome.com/docs/webstore/program-policies/)
- [Publishing Your Extension](https://developer.chrome.com/docs/webstore/publish/)
- [Store Listing Best Practices](https://developer.chrome.com/docs/webstore/best-practices/)

## Support

If you encounter issues during submission:
1. Check the [Chrome Web Store Help Center](https://support.google.com/chrome_webstore)
2. Review error messages carefully
3. Ensure all requirements are met
4. Contact Chrome Web Store support if needed

Good luck with your submission! 🚀
