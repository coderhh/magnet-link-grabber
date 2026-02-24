// content.js — Extracts magnet links from the current page

(() => {
  /**
   * Scan the page for magnet links:
   *  1. <a href="magnet:..."> elements
   *  2. Raw magnet:?xt= URIs in the page text / HTML source
   * Returns a deduplicated array of magnet URIs.
   */
  function getMagnetLinks() {
    const magnetSet = new Set();

    // 1. Anchor tags with magnet hrefs
    document.querySelectorAll('a[href^="magnet:"]').forEach((a) => {
      magnetSet.add(a.href.trim());
    });

    // 2. Regex scan over the full HTML for magnet URIs that may not be in <a> tags
    // Improved regex to capture complete magnet URIs, handling URL encoding and special chars
    const magnetRegex = /magnet:\?[^\s"'<>)]+/gi;
    const bodyHTML = document.documentElement.innerHTML;
    const matches = bodyHTML.match(magnetRegex);
    if (matches) {
      matches.forEach((m) => {
        // Clean up the magnet URI - remove trailing punctuation that might have been captured
        let cleaned = m.trim();
        // Remove trailing common punctuation that might have been accidentally captured
        cleaned = cleaned.replace(/[.,;:!?)]+$/, '');
        // Ensure it's a valid magnet URI format
        if (cleaned.includes('xt=')) {
          magnetSet.add(cleaned);
        }
      });
    }

    // Basic deduplication at this level (exact string matches)
    // More sophisticated hash-based deduplication happens in popup.js
    return [...magnetSet];
  }

  // Listen for messages from the popup
  chrome.runtime.onMessage.addListener((request, _sender, sendResponse) => {
    if (request.action === "getMagnets") {
      const magnets = getMagnetLinks();
      sendResponse({ magnets });
    }
    return true; // keep channel open for async response
  });
})();
