(() => {
  const STORAGE_KEY = "sj-theme";
  const LABELS = { dark: "☾ dark", light: "☀ light" };

  const currentTheme = () =>
    document.documentElement.getAttribute("data-theme") === "light" ? "light" : "dark";

  const syncToggleLabel = (theme) => {
    const toggle = document.querySelector("[data-theme-toggle]");
    if (toggle) toggle.textContent = LABELS[theme];
  };

  syncToggleLabel(currentTheme());

  document.addEventListener("click", (event) => {
    if (!event.target.closest("[data-theme-toggle]")) return;

    const next = currentTheme() === "dark" ? "light" : "dark";
    document.documentElement.setAttribute("data-theme", next);
    localStorage.setItem(STORAGE_KEY, next);
    syncToggleLabel(next);
  });
})();
