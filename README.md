# 🧲 Magnet Link Grabber

A Chrome extension that extracts all magnet links from the current webpage, lets you select which ones to keep, and copies them to your clipboard with one click.

## Features

- **Scan any page** — Automatically finds all magnet links on the page you're viewing
- **Select & copy** — Choose individual links or select all, then copy to clipboard
- **Duplicate removal** — Deduplicates links by torrent hash
- **Torrent names** — Shows torrent names when available in the magnet link
- **Privacy-first** — No data collection, no external servers, everything runs locally

## Installation

### From Chrome Web Store

[Install Magnet Link Grabber](https://chrome.google.com/webstore) *(link when published)*

### Developer / Load Unpacked

1. Clone this repository:
   ```bash
   git clone https://github.com/coderhh/magnet-link-grabber.git
   ```
2. Open Chrome and go to `chrome://extensions/`
3. Enable **Developer mode** (top right)
4. Click **Load unpacked** and select the `magnet-link-grabber` folder

## Usage

1. Navigate to any webpage that contains magnet links (e.g., a torrent search results page)
2. Click the Magnet Link Grabber icon in your Chrome toolbar
3. Review the list of found magnet links
4. Use **Select All** / **Deselect All** to choose which links to copy
5. Click **Copy Selected Links** to copy them to your clipboard

## Privacy

This extension does not collect, store, or transmit any user data. All processing happens locally in your browser.

- [Privacy Policy](https://coderhh.github.io/magnet-link-grabber/privacy-policy.html)

## Project Structure

```
magnet-link-grabber/
├── manifest.json      # Extension manifest (Manifest V3)
├── popup.html        # Popup UI
├── popup.js          # Popup logic
├── popup.css         # Popup styles
├── content.js        # Content script (scans page for magnet links)
├── icons/            # Extension icons (16, 48, 128px)
├── privacy-policy.html
└── README.md
```

## License

MIT License — see [LICENSE](LICENSE) for details.
