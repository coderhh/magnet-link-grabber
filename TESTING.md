# Testing Guide for Magnet Link Grabber Extension

## Quick Start - Load Extension Locally

### Step 1: Open Chrome Extensions Page
1. Open Google Chrome
2. Navigate to `chrome://extensions/`
   - Or: Menu (⋮) → Extensions → Manage Extensions

### Step 2: Enable Developer Mode
- Toggle the "Developer mode" switch in the top-right corner

### Step 3: Load the Extension
1. Click the "Load unpacked" button
2. Navigate to and select the extension directory:
   ```
   C:\Projects\magnet-link-grabber\magnet-link-grabber
   ```
3. Click "Select Folder"

### Step 4: Verify Installation
- ✅ Extension should appear in the list
- ✅ Extension should be enabled (toggle ON)
- ✅ Extension icon should appear in Chrome toolbar

## Testing the Extension

### Test Scenario 1: Basic Functionality
1. Visit a webpage that contains magnet links (e.g., a torrent site)
2. Click the extension icon in the toolbar
3. Verify:
   - Popup opens showing found magnet links
   - Links are displayed in a list
   - Count badge shows correct number

### Test Scenario 2: Copy Functionality
1. Open popup on a page with magnet links
2. Select one or more links using checkboxes
3. Click "Copy Selected Links" button
4. Verify:
   - Toast notification appears: "Copied to clipboard!"
   - Links are actually copied (paste in notepad to verify)

### Test Scenario 3: Empty State
1. Visit a webpage without magnet links
2. Open the extension popup
3. Verify:
   - "No magnet links found on this page" message appears
   - Controls are hidden

### Test Scenario 4: Select All / Deselect All
1. Open popup on a page with multiple magnet links
2. Click "Select All" - verify all checkboxes are checked
3. Click "Deselect All" - verify all checkboxes are unchecked

## Debugging

### Inspect Popup
- Right-click the extension icon → "Inspect popup"
- Opens DevTools for the popup HTML/JS

### Inspect Content Script
- Open DevTools on any webpage (F12)
- Go to Console tab
- Content script logs will appear here

### View Extension Errors
- Go to `chrome://extensions/`
- Check for error messages under the extension card
- Click "Errors" button if available

### Reload Extension After Changes
1. Go to `chrome://extensions/`
2. Find your extension
3. Click the reload icon (🔄) on the extension card
4. Or toggle it off and on again

## Common Issues & Solutions

### Issue: Extension doesn't load
- **Solution**: Check that all files referenced in `manifest.json` exist
- Verify file paths are correct (case-sensitive on some systems)

### Issue: Popup doesn't open
- **Solution**: Check browser console for errors
- Verify `popup.html`, `popup.js`, and `popup.css` exist

### Issue: No magnet links found
- **Solution**: 
  - Verify you're on a page that actually has magnet links
  - Check content script is injected (view page source, look for content.js)
  - Open DevTools console to see if content script is running

### Issue: Copy to clipboard doesn't work
- **Solution**: 
  - Check browser console for permission errors
  - Verify clipboard API is available (Chrome 66+)
  - Test on a page with HTTPS (clipboard API requires secure context)

## Testing Checklist

- [ ] Extension loads without errors
- [ ] Extension icon appears in toolbar
- [ ] Popup opens when clicking icon
- [ ] Magnet links are detected on test pages
- [ ] Links are displayed correctly in popup
- [ ] Select All / Deselect All buttons work
- [ ] Copy to clipboard works
- [ ] Toast notification appears after copy
- [ ] Empty state shows when no links found
- [ ] Extension works on different websites
- [ ] No console errors in DevTools

## Test Pages

You can test the extension on:
- Any torrent site with magnet links
- Create a test HTML file with sample magnet links:
  ```html
  <a href="magnet:?xt=urn:btih:TEST123">Test Magnet Link</a>
  ```

## Notes

- After making code changes, always reload the extension
- Clear browser cache if you see stale behavior
- Use Chrome DevTools to debug JavaScript issues
- Check `chrome://extensions/` for detailed error messages
