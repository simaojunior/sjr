defmodule SjrWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use SjrWeb, :html

  # Embed all files in layouts/* within this module.
  # The default root.html.heex file contains the HTML
  # skeleton of your application, namely HTML headers
  # and other static content.
  embed_templates "layouts/*"

  @doc """
  Renders your app layout.

  This function is typically invoked from every template,
  and it often contains your application menu, sidebar,
  or similar.

  ## Examples

      <Layouts.app flash={@flash}>
        <h1>Content</h1>
      </Layouts.app>

  """
  attr :flash, :map, required: true, doc: "the map of flash messages"

  attr :current_scope, :map,
    default: nil,
    doc: "the current [scope](https://phoenix.hexdocs.pm/scopes.html)"

  slot :inner_block, required: true

  def app(assigns) do
    ~H"""
    {render_slot(@inner_block)}
    <.flash_group flash={@flash} />
    """
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={
          show(".phx-client-error #client-error")
          |> JS.remove_attribute("hidden", to: ".phx-client-error #client-error")
        }
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={
          show(".phx-server-error #server-error")
          |> JS.remove_attribute("hidden", to: ".phx-server-error #server-error")
        }
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end

  @doc "The site header: brand, nav links, theme toggle. Shared across pages."
  attr :locale, :string, default: "en"

  def site_nav(assigns) do
    ~H"""
    <header style="display:flex;align-items:baseline;justify-content:space-between;gap:16px;padding:20px 0 12px;border-bottom:1px solid var(--color-neutral-800);flex-wrap:wrap;">
      <div style="display:flex;align-items:baseline;gap:12px;flex-wrap:wrap;">
        <a
          href="/"
          style="font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:19px;letter-spacing:-0.02em;color:var(--color-neutral-100);text-decoration:none;"
        >
          simaojunior<span style="color:var(--color-accent);">.dev</span>
        </a>
        <span style="font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:11px;color:var(--color-neutral-600);">
          {gettext("hidden leaf branch office · est. 2019")}
        </span>
      </div>
      <nav
        aria-label="Primary"
        style="display:flex;align-items:center;gap:8px;font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:13px;flex-wrap:wrap;white-space:nowrap;"
      >
        <ul style="display:flex;align-items:center;gap:6px;flex-wrap:wrap;list-style:none;margin:0;padding:0;">
          <li>
            <a href="/" class="nav-link" style="color:var(--color-neutral-100);">{gettext("[home]")}</a>
          </li>
          <li><a href="/#writing" class="nav-link">{gettext("[scrolls]")}</a></li>
          <li><a href="/til" class="nav-link">{gettext("[til]")}</a></li>
          <li><a href="/#projects" class="nav-link">{gettext("[bingo book]")}</a></li>
          <li><a href="/#about" class="nav-link">{gettext("[about]")}</a></li>
          <li><a href="/uses" class="nav-link">{gettext("[uses]")}</a></li>
          <li>
            <a href="/cv" class="nav-link" aria-label={gettext("CV page")}>
              {gettext("[cv]")}
            </a>
          </li>
        </ul>
        <button
          type="button"
          data-locale-toggle
          data-locale={@locale}
          aria-label={gettext("Switch language")}
          class="chip-toggle-btn"
          style="font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:11px;letter-spacing:0.08em;text-transform:uppercase;background:transparent;color:var(--color-neutral-400);border:1px solid var(--color-neutral-700);border-radius:var(--radius-sm);padding:5px 9px;cursor:pointer;"
        >
          {String.upcase(@locale)}
        </button>
        <button
          type="button"
          data-theme-toggle
          class="theme-toggle-btn chip-toggle-btn"
          style="font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:11px;letter-spacing:0.08em;text-transform:uppercase;background:transparent;color:var(--color-neutral-400);border:1px solid var(--color-neutral-700);border-radius:var(--radius-sm);padding:5px 9px;cursor:pointer;"
        >
          {gettext("☾ dark")}
        </button>
      </nav>
    </header>
    """
  end

  @doc "The site footer: badges, social links, shinobi number. Shared across pages."
  def site_footer(assigns) do
    ~H"""
    <footer style="margin-top:56px;padding-top:20px;border-top:1px solid var(--color-neutral-800);display:flex;gap:24px;flex-wrap:wrap;align-items:flex-end;">
      <div>
        <div style="display:flex;gap:8px;flex-wrap:wrap;margin-bottom:14px;">
          <span style="display:inline-flex;align-items:center;justify-content:center;width:88px;height:31px;border:1px solid var(--color-neutral-700);background:var(--color-neutral-900);font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:10px;letter-spacing:0.05em;color:var(--color-chakra);text-align:center;">
            {gettext("HAND CODED")}<br />{gettext("NO BUILD STEP")}
          </span>
          <span style="display:inline-flex;align-items:center;justify-content:center;width:88px;height:31px;border:1px solid var(--color-neutral-700);background:var(--color-neutral-900);font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:10px;letter-spacing:0.05em;color:var(--color-neutral-400);text-align:center;">
            RSS<br />{gettext("YES REALLY")}
          </span>
          <span style="display:inline-flex;align-items:center;justify-content:center;width:88px;height:31px;border:1px solid var(--color-neutral-700);background:var(--color-neutral-900);font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:10px;letter-spacing:0.05em;color:var(--color-neutral-400);text-align:center;">
            {gettext("TEAM 7")}<br />{gettext("FOREVER")}
          </span>
          <span style="display:inline-flex;align-items:center;justify-content:center;width:88px;height:31px;border:1px solid var(--color-neutral-700);background:var(--color-neutral-900);font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:10px;letter-spacing:0.05em;color:var(--color-neutral-400);text-align:center;">
            {gettext("BEST VIEWED")}<br />{gettext("ANY BROWSER")}
          </span>
        </div>
        <ul
          aria-label={gettext("Elsewhere")}
          style="display:flex;gap:10px;flex-wrap:wrap;list-style:none;margin:0;padding:0;font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:12px;"
        >
          <li><a href="https://github.com/simaojunior" class="footer-link">github</a></li>
          <li><span class="footer-link-disabled">bluesky</span></li>
          <li><span class="footer-link-disabled">linkedin</span></li>
          <li><span class="footer-link-disabled">rss</span></li>
          <li><a href="mailto:simao.msjr@gmail.com" class="footer-link">email</a></li>
        </ul>
      </div>
      <div style="margin-left:auto;text-align:right;font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:11px;color:var(--color-neutral-600);line-height:1.9;">
        <div>
          {gettext("you are shinobi no.")}
          <span
            title={gettext("visitor count, persisted on a Fly volume")}
            style="display:inline-block;padding:2px 6px;background:var(--color-neutral-900);border:1px solid var(--color-neutral-800);color:var(--color-chakra);letter-spacing:0.22em;"
          >
            {visitor_number()}
          </span>
        </div>
        <div>
          {gettext("member of the")} <span class="footer-link-disabled">{gettext("webring")}</span>
          · <span class="footer-link-disabled">{gettext("← prev")}</span>
          · <span class="footer-link-disabled">{gettext("next →")}</span>
        </div>
        <div>© {current_year()} Simão Júnior · {gettext("no cookies, no trackers, no popups")}</div>
      </div>
    </footer>
    """
  end

  @doc """
  Entries for the ⌘P command menu, ported from the old Zola site.
  Labels are resolved through Gettext for the current request's locale.
  """
  def command_menu_items do
    [
      %{label: gettext("Home"), url: "/", external: false},
      %{label: gettext("Scrolls"), url: "/#writing", external: false},
      %{label: gettext("TIL"), url: "/til", external: false},
      %{label: gettext("Bingo book"), url: "/#projects", external: false},
      %{label: gettext("About"), url: "/#about", external: false},
      %{label: gettext("Uses"), url: "/uses", external: false},
      %{label: gettext("CV"), url: "/cv", external: false},
      %{label: "GitHub", url: "https://github.com/simaojunior", external: true},
      %{label: gettext("Email"), url: "mailto:simao.msjr@gmail.com", external: false}
    ]
  end

  defp current_year, do: Date.utc_today().year

  defp visitor_number do
    Sjr.VisitorCounter.current()
    |> Integer.to_string()
    |> String.pad_leading(3, "0")
  end
end
