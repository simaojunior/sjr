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
  def site_nav(assigns) do
    ~H"""
    <div style="display:flex;align-items:baseline;justify-content:space-between;gap:16px;padding:20px 0 12px;border-bottom:1px solid var(--color-neutral-800);flex-wrap:wrap;">
      <div style="display:flex;align-items:baseline;gap:12px;flex-wrap:wrap;">
        <a
          href="/"
          style="font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:19px;letter-spacing:-0.02em;color:var(--color-neutral-100);text-decoration:none;"
        >
          simaojunior<span style="color:var(--color-accent);">.dev</span>
        </a>
        <span style="font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:11px;color:var(--color-neutral-600);">
          hidden leaf branch office · est. 2019
        </span>
      </div>
      <div style="display:flex;align-items:center;gap:14px;font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:13px;flex-wrap:wrap;white-space:nowrap;">
        <a href="/" style="color:var(--color-neutral-100);">[home]</a>
        <a href="/#writing">[scrolls]</a>
        <a href="/#projects">[bingo book]</a>
        <a href="/#about">[about]</a>
        <a href="#">[uses]</a>
        <a href="#">[guestbook]</a>
        <button
          type="button"
          data-theme-toggle
          class="theme-toggle-btn"
          style="font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:11px;letter-spacing:0.08em;text-transform:uppercase;background:transparent;color:var(--color-neutral-400);border:1px solid var(--color-neutral-700);border-radius:var(--radius-sm);padding:5px 9px;cursor:pointer;"
        >
          ☾ dark
        </button>
      </div>
    </div>
    """
  end

  @doc "The site footer: badges, social links, shinobi number. Shared across pages."
  def site_footer(assigns) do
    ~H"""
    <div style="margin-top:56px;padding-top:20px;border-top:1px solid var(--color-neutral-800);display:flex;justify-content:space-between;gap:24px;flex-wrap:wrap;align-items:flex-end;">
      <div>
        <div style="display:flex;gap:8px;flex-wrap:wrap;margin-bottom:14px;">
          <span style="display:inline-flex;align-items:center;justify-content:center;width:88px;height:31px;border:1px solid var(--color-neutral-700);background:var(--color-neutral-900);font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:10px;letter-spacing:0.05em;color:var(--color-chakra);text-align:center;">
            HAND CODED<br />NO BUILD STEP
          </span>
          <span style="display:inline-flex;align-items:center;justify-content:center;width:88px;height:31px;border:1px solid var(--color-neutral-700);background:var(--color-neutral-900);font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:10px;letter-spacing:0.05em;color:var(--color-neutral-400);text-align:center;">
            RSS<br />YES REALLY
          </span>
          <span style="display:inline-flex;align-items:center;justify-content:center;width:88px;height:31px;border:1px solid var(--color-neutral-700);background:var(--color-neutral-900);font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:10px;letter-spacing:0.05em;color:var(--color-neutral-400);text-align:center;">
            TEAM 7<br />FOREVER
          </span>
          <span style="display:inline-flex;align-items:center;justify-content:center;width:88px;height:31px;border:1px solid var(--color-neutral-700);background:var(--color-neutral-900);font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:10px;letter-spacing:0.05em;color:var(--color-neutral-400);text-align:center;">
            BEST VIEWED<br />IN ANY BROWSER
          </span>
        </div>
        <div style="display:flex;gap:14px;font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:12px;flex-wrap:wrap;">
          <a href="https://github.com/simaojunior">github</a><a href="#">bluesky</a><a href="#">linkedin</a><a href="#">rss</a><a href="mailto:simao.msjr@gmail.com">email</a>
        </div>
      </div>
      <div style="text-align:right;font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,monospace;font-size:11px;color:var(--color-neutral-600);line-height:1.9;">
        <div>
          you are shinobi no.
          <span style="display:inline-block;padding:2px 6px;background:var(--color-neutral-900);border:1px solid var(--color-neutral-800);color:var(--color-chakra);letter-spacing:0.22em;">0042871</span>
        </div>
        <div>
          member of the <a href="#">webring</a> · <a href="#">← prev</a> · <a href="#">next →</a>
        </div>
        <div>© {current_year()} Simão Júnior · no cookies, no trackers, no popups</div>
      </div>
    </div>
    """
  end

  defp current_year, do: Date.utc_today().year
end
