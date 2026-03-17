# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A Chrome extension (Manifest V3) that extracts magnet links from webpages, displays them in a popup with deduplication, and copies selected links to the clipboard.

## Loading / Testing the Extension

There is no build step. Load the extension directly into Chrome:

1. Go to `chrome://extensions/`
2. Enable **Developer mode**
3. Click **Load unpacked** → select this directory (`c:\Projects\magnet-link-grabber`)

After any code change, reload the extension from `chrome://extensions/` (click the refresh icon on the extension card).

**Debugging:**
- Right-click the extension icon → "Inspect popup" — opens DevTools for popup.js
- Open page DevTools (F12) → Console — shows content.js output
- Check `chrome://extensions/` for extension-level errors

## Architecture

The extension has two execution contexts that communicate via Chrome messaging:

**`content.js`** — runs in the page context (`document_idle`). Responds to `getMagnets` messages by scanning in three passes: (1) `<a href="magnet:...">` tags, (2) regex over `document.documentElement.innerHTML` for raw `magnet:?xt=` URIs, (3) regex for bare 40-char hex SHA1 info hashes (`\b[a-f0-9]{40}\b`) not already captured — these are synthesized into minimal `magnet:?xt=urn:btih:<hash>` URIs. Word boundaries in step 3 prevent false matches against longer hashes like SHA256 (64 chars). Returns a deduplicated array of raw magnet URI strings.

**`popup.js`** — runs in the popup context. On open, it queries the active tab and sends a `getMagnets` message to content.js. If the content script isn't injected yet (e.g., extension was just installed), it falls back to `chrome.scripting.executeScript` to inject `content.js` first, then retries. Once it receives raw URIs, it parses them with `parseMagnet()` (extracts `dn` display name and `btih` hash), deduplicates by info hash via `removeDuplicates()` (preferring entries with a display name), renders a checkbox list, and handles select-all/copy actions.

**Key design points:**
- Deduplication happens at two levels: basic exact-string dedup in `content.js`, then hash-based dedup in `popup.js`
- The `btih` hash supports both 40-char hex (SHA1) and 32-char base32 (SHA1) formats
- Clipboard write uses `navigator.clipboard.writeText` with a `textarea`/`execCommand` fallback

## Packaging for Chrome Web Store

The production zip must contain only: `manifest.json`, `popup.html`, `popup.js`, `popup.css`, `content.js`, `icons/`

```powershell
Compress-Archive -Path manifest.json,popup.html,popup.js,popup.css,content.js,icons -DestinationPath magnet-link-grabber-v1.0.0.zip -Force
```

When releasing a new version, update `"version"` in `manifest.json` before zipping. See `DEPLOYMENT.md` for the full Chrome Web Store submission checklist.
