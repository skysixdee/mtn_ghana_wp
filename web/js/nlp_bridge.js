(function () {
  window.extractIntentAndEntities = function (text) {
    if (!text)
      return JSON.stringify({
        intent: "unknown",
        artist: null,
        relevant: false,
        category: null,
      });

    const lower = text.toLowerCase();
    let artist = null;
    let intent = "unknown";
    let relevant = false;
    let category = null;

    // 1️⃣ Navigation Intents
    const navPatterns = [
      { intent: "navigate_musicbox", keywords: ["music box", "musicbox"] },
      { intent: "navigate_home", keywords: ["home", "main screen", "start screen"] },
      { intent: "navigate_profile", keywords: ["profile", "account", "my details"] },
      { intent: "navigate_faq", keywords: ["faq", "help", "questions", "support"] },
      { intent: "navigate_name_tune", keywords: ["name tune", "nametune"] },
      { intent: "navigate_my_tunes", keywords: ["my tunes", "purchased tunes", "my songs"] },
      { intent: "navigate_my_wishlist", keywords: ["wishlist", "my wishlist", "saved tunes"] },
    ];

    for (const route of navPatterns) {
      for (const kw of route.keywords) {
        const regex = new RegExp(`(go|open|show|take|navigate|view).*${kw}`, "i");
        if (regex.test(lower) || lower.includes(kw)) {
          intent = route.intent;
          relevant = true;
          console.log("🎯 Detected navigation intent:", intent);
          break;
        }
      }
      if (intent !== "unknown") break;
    }

    // 2️⃣ Category detection: "Go to <categoryName>" or "<categoryName> category" etc.
    if (intent === "unknown") {
      const categoryPatterns = [
        /(?:go to|open|take me to|navigate to)\s+([A-Za-z0-9 '&\-]+?)(?:\s+category)?$/i,
        /([A-Za-z0-9 '&\-]+)\s+category$/i,
      ];

      let matched = false;
      for (const pattern of categoryPatterns) {
        const match = text.match(pattern);
        if (match) {
          category = match[1].trim();
          if (category) {
            intent = "navigate_category";
            relevant = true;
            matched = true;
            console.log("🎯 Detected category navigation intent:", category);
            break;
          }
        }
      }
      if (!matched) console.log("🟡 No category detected in user text");
    }

    // 3️⃣ Show Tune Categories Intent
    if (intent === "unknown") {
      const showTuneCategoriesPatterns = [
        /show (all )?(tune|tone|music) categories/i,
        /list (all )?(tune|tone|music) categories/i,
        /show available (tunes|tones|categories)/i,
        /what (tune|tone|music) categories/i,
        /display (tune|tone|music) categories/i,
      ];

      for (const pattern of showTuneCategoriesPatterns) {
        if (pattern.test(lower)) {
          intent = "show_tune_categories";
          relevant = true;
          console.log("🎯 Detected show_tune_categories intent");
          break;
        }
      }
    }

    // 4️⃣ Artist detection (only if no other intent found)
    if (intent === "unknown") {
      // New patterns for "top songs by <artist>"
      const topSongsRegex =
        /(?:(?:can you )?show|give|list|play).*(?:top|best)?\s*(?:songs|tracks|tones|tunes)\s*(?:by|of)\s+(.+)/i;
      const match = text.match(topSongsRegex);

      if (match) {
        artist = match[1]?.trim();
        if (artist) {
          intent = "show_songs_by_artist";
          relevant = true;
          console.log("🎯 Detected show_songs_by_artist intent (new patterns):", artist);
        }
      }

      // fallback to NLP people() if not detected yet
      else if (!artist && window.nlp) {
        const doc = window.nlp(text);
        const people = doc.people().out("array");
        if (people.length > 0) {
          artist = people[0];
          intent = "show_songs_by_artist";
          relevant = true;
          console.log("🎯 Detected by people():", people);
        }
      }

      // last fallback regex
      if (!artist) {
        const byMatch = text.match(
          /(?:show|list|top|songs|tracks|tones|tunes).*by\s+([A-Za-z0-9 '&\-\.]+)|top\s+([A-Za-z0-9 '&\-\.]+)\s+(?:songs|tracks|tones|tunes)|([A-Za-z0-9 '&\-\.]+)\s+top\s+(?:songs|tracks|tones|tunes)/i
        );

        if (byMatch) {
          artist = byMatch[1]
            ? byMatch[1].trim()
            : byMatch[2]
            ? byMatch[2].trim()
            : byMatch[3]
            ? byMatch[3].trim()
            : null;

          if (artist) {
            intent = "show_songs_by_artist";
            relevant = true;
            console.log("🎯 Detected by fallback regex:", artist);
          }
        }
      }
    }

    console.log("🧠 NLP debug:", { text, intent, artist, relevant, category });
    return JSON.stringify({ intent, artist, relevant, category });
  };
})();
