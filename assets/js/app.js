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

  const COPY_ICON =
    '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"/><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/></svg>';
  const CHECK_ICON =
    '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg>';

  document.querySelectorAll("pre.lumis").forEach((pre) => {
    if (pre.parentElement.classList.contains("code-wrapper")) return;

    const wrapper = document.createElement("div");
    wrapper.className = "code-wrapper";
    pre.parentNode.insertBefore(wrapper, pre);
    wrapper.appendChild(pre);

    const btn = document.createElement("button");
    btn.type = "button";
    btn.className = "copy-btn";
    btn.setAttribute("aria-label", "Copy code");
    btn.innerHTML = COPY_ICON;

    btn.addEventListener("click", () => {
      const code = pre.querySelector("code").textContent;
      navigator.clipboard.writeText(code).then(() => {
        btn.innerHTML = CHECK_ICON;
        btn.classList.add("copied");
        setTimeout(() => {
          btn.innerHTML = COPY_ICON;
          btn.classList.remove("copied");
        }, 1500);
      });
    });

    wrapper.appendChild(btn);
  });
})();
