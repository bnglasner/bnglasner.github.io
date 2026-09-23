// Site search (ninja-keys), loaded on first intent.
//
// The ninja-keys web component and its ~30 lit modules plus search-data.js
// used to load on every page view (34 requests, ~57 KB) before anyone searched.
// Now they load on the first search intent: the navbar search button,
// ctrl/cmd+k, or (as a warm-up) hovering or focusing the search button.
// window.searchAssets is set inline by _includes/scripts.liquid.
let searchTheme = determineComputedTheme();
const ninjaKeys = document.querySelector("ninja-keys");

if (searchTheme === "dark") {
  ninjaKeys.classList.add("dark");
} else {
  ninjaKeys.classList.remove("dark");
}

let searchReady = null;
const loadSearch = () => {
  if (searchReady) return searchReady;
  const addScript = (src, type) =>
    new Promise((resolve, reject) => {
      const s = document.createElement("script");
      if (type) s.type = type;
      s.src = src;
      s.onload = resolve;
      s.onerror = reject;
      document.body.appendChild(s);
    });
  searchReady = addScript(window.searchAssets.keys, "module")
    .then(() => customElements.whenDefined("ninja-keys"))
    .then(() => addScript(window.searchAssets.data))
    .catch((err) => {
      searchReady = null; // allow a retry on the next intent
      throw err;
    });
  return searchReady;
};

const openSearchModal = () => {
  // collapse navbarNav if expanded on mobile
  const $navbarNav = $("#navbarNav");
  if ($navbarNav.hasClass("show")) {
    $navbarNav.collapse("hide");
  }
  loadSearch().then(() => ninjaKeys.open());
};

// Until ninja-keys is defined, handle its ctrl/cmd+k shortcut ourselves. Once it
// is defined it registers the same hotkey, so this listener steps aside.
document.addEventListener("keydown", (e) => {
  if (customElements.get("ninja-keys")) return;
  if ((e.ctrlKey || e.metaKey) && !e.altKey && !e.shiftKey && e.key.toLowerCase() === "k") {
    e.preventDefault();
    openSearchModal();
  }
});

const searchToggle = document.getElementById("search-toggle");
if (searchToggle) {
  ["pointerenter", "focus", "touchstart"].forEach((evt) =>
    searchToggle.addEventListener(evt, () => loadSearch().catch(() => {}), { once: true, passive: true })
  );
}
