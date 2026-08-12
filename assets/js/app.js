(() => {
  const STORAGE_KEY = "sj-theme";
  const isPtBr = document.documentElement.lang === "pt-BR";
  const LABELS = isPtBr
    ? { dark: "☾ escuro", light: "☀ claro" }
    : { dark: "☾ dark", light: "☀ light" };
  const ACTION_LABELS = isPtBr
    ? { dark: "Mudar para tema claro", light: "Mudar para tema escuro" }
    : { dark: "Switch to light theme", light: "Switch to dark theme" };

  const currentTheme = () =>
    document.documentElement.getAttribute("data-theme") === "light" ? "light" : "dark";

  const syncToggleLabel = (theme) => {
    const toggle = document.querySelector("[data-theme-toggle]");
    if (!toggle) return;
    toggle.textContent = LABELS[theme];
    toggle.setAttribute("aria-label", ACTION_LABELS[theme]);
  };

  syncToggleLabel(currentTheme());

  document.addEventListener("click", (event) => {
    if (!event.target.closest("[data-theme-toggle]")) return;

    const next = currentTheme() === "dark" ? "light" : "dark";
    document.documentElement.setAttribute("data-theme", next);
    localStorage.setItem(STORAGE_KEY, next);
    syncToggleLabel(next);
  });

  const LOCALE_COOKIE = "sj-locale";

  document.addEventListener("click", (event) => {
    const toggle = event.target.closest("[data-locale-toggle]");
    if (!toggle) return;

    const next = toggle.getAttribute("data-locale") === "en" ? "pt-br" : "en";
    document.cookie = `${LOCALE_COOKIE}=${next}; path=/; max-age=31536000`;
    location.reload();
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
    btn.setAttribute("aria-label", isPtBr ? "Copiar código" : "Copy code");
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

  const dataEl = document.getElementById("command-menu-data");
  const overlay = document.getElementById("command-menu-overlay");
  const trigger = document.getElementById("command-menu-trigger");
  if (dataEl && overlay && trigger) {
    const items = JSON.parse(dataEl.dataset.items);
    const input = document.getElementById("command-menu-input");
    const list = document.getElementById("command-menu-list");
    let selected = 0;
    let filtered = items.slice();

    const esc = (s) =>
      s.replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));

    const render = () => {
      list.innerHTML = "";
      if (filtered.length === 0) {
        const empty = document.createElement("li");
        empty.className = "cmd-empty";
        empty.textContent = isPtBr ? "Nenhum resultado" : "No results";
        list.appendChild(empty);
        return;
      }
      filtered.forEach((it, i) => {
        const li = document.createElement("li");
        li.className = "cmd-item" + (i === selected ? " is-selected" : "");
        li.setAttribute("role", "option");
        li.innerHTML =
          `<span class="cmd-label">${esc(it.label)}</span>` +
          (it.external ? '<span class="cmd-ext">&#8599;</span>' : "");
        li.addEventListener("click", () => activate(i));
        li.addEventListener("mousemove", () => {
          if (selected !== i) {
            selected = i;
            updateSelected();
          }
        });
        list.appendChild(li);
      });
    };

    const updateSelected = () => {
      const children = list.children;
      for (let i = 0; i < children.length; i++) {
        children[i].classList.toggle("is-selected", i === selected);
      }
      const el = children[selected];
      if (el && el.scrollIntoView) el.scrollIntoView({ block: "nearest" });
    };

    const filter = () => {
      const q = input.value.trim().toLowerCase();
      filtered = items.filter((it) => it.label.toLowerCase().indexOf(q) !== -1);
      selected = 0;
      render();
    };

    const open = () => {
      overlay.hidden = false;
      document.body.style.overflow = "hidden";
      input.value = "";
      filter();
      input.focus();
    };

    const close = () => {
      overlay.hidden = true;
      document.body.style.overflow = "";
    };

    const activate = (i) => {
      const it = filtered[i];
      if (!it) return;
      close();
      if (it.external) window.open(it.url, "_blank", "noopener");
      else window.location.href = it.url;
    };

    document.addEventListener("keydown", (e) => {
      if ((e.metaKey || e.ctrlKey) && (e.key === "p" || e.key === "P")) {
        e.preventDefault();
        if (overlay.hidden) open();
        else close();
      } else if (e.key === "Escape" && !overlay.hidden) {
        close();
      }
    });

    input.addEventListener("keydown", (e) => {
      const down = (e.ctrlKey && (e.key === "j" || e.key === "J")) || e.key === "ArrowDown";
      const up = (e.ctrlKey && (e.key === "k" || e.key === "K")) || e.key === "ArrowUp";
      if (down) {
        e.preventDefault();
        if (filtered.length) {
          selected = (selected + 1) % filtered.length;
          updateSelected();
        }
      } else if (up) {
        e.preventDefault();
        if (filtered.length) {
          selected = (selected - 1 + filtered.length) % filtered.length;
          updateSelected();
        }
      } else if (e.key === "Enter") {
        e.preventDefault();
        activate(selected);
      }
    });

    input.addEventListener("input", filter);
    overlay.addEventListener("click", (e) => {
      if (e.target === overlay) close();
    });
    trigger.addEventListener("click", open);
  }
})();
