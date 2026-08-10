defmodule SjrWeb.BlogHTML do
  @moduledoc """
  This module contains pages rendered by BlogController.

  See the `blog_html` directory for all templates available.
  """
  use SjrWeb, :html

  embed_templates "blog_html/*"

  attr :icon, :string, default: nil

  def post_cover(assigns) do
    ~H"""
    <div style="margin:24px 0 0;height:140px;border-radius:var(--radius-md);background:linear-gradient(140deg,var(--color-section),var(--color-section-glow));border:1px solid var(--color-section-ghost);display:flex;align-items:center;justify-content:center;">
      <svg
        viewBox="0 0 24 24"
        width="56"
        height="56"
        fill="none"
        stroke="var(--color-chakra)"
        stroke-width="1.5"
        stroke-linecap="round"
        stroke-linejoin="round"
      >
        {icon_path(@icon)}
      </svg>
    </div>
    """
  end

  defp icon_path("key") do
    assigns = %{}

    ~H"""
    <circle cx="8" cy="8" r="4" />
    <path d="M11 11L20 20M15 15L17 13M17 17L19 15" />
    """
  end

  defp icon_path("queue") do
    assigns = %{}

    ~H"""
    <ellipse cx="12" cy="5" rx="7" ry="3" />
    <path d="M5 5v6c0 1.7 3.1 3 7 3s7-1.3 7-3V5" />
    <path d="M5 11v6c0 1.7 3.1 3 7 3s7-1.3 7-3v-6" />
    """
  end

  defp icon_path("rocket") do
    assigns = %{}

    ~H"""
    <path d="M12 2c3 3 4 7 4 10 0 2-1 4-2 5l-2 2-2-2c-1-1-2-3-2-5 0-3 1-7 4-10z" />
    <circle cx="12" cy="10" r="1.5" />
    <path d="M8 15l-3 3M16 15l3 3M10 19l-1 3M14 19l1 3" />
    """
  end

  defp icon_path("gear") do
    assigns = %{}

    ~H"""
    <circle cx="12" cy="12" r="3" />
    <circle cx="12" cy="12" r="8" stroke-dasharray="2 3" />
    """
  end

  defp icon_path("layers") do
    assigns = %{}

    ~H"""
    <path d="M12 3l9 5-9 5-9-5 9-5z" />
    <path d="M3 13l9 5 9-5" />
    """
  end

  defp icon_path("bell") do
    assigns = %{}

    ~H"""
    <path d="M12 3a5 5 0 0 0-5 5v3l-2 4h14l-2-4V8a5 5 0 0 0-5-5z" />
    <path d="M10 19a2 2 0 0 0 4 0" />
    """
  end

  defp icon_path("fingerprint") do
    assigns = %{}

    ~H"""
    <path d="M12 3a9 9 0 0 1 9 9" />
    <path d="M12 6a6 6 0 0 1 6 6" />
    <path d="M12 9a3 3 0 0 1 3 3" />
    <path d="M3 12a9 9 0 0 1 9-9" />
    <path d="M6 12a6 6 0 0 1 6-6" />
    """
  end

  defp icon_path(_shuriken) do
    assigns = %{}

    ~H"""
    <path d="M12 2l3 7-3 3-3-3 3-7zM22 12l-7 3-3-3 3-3 7 3zM12 22l-3-7 3-3 3 3-3 7zM2 12l7-3 3 3-3 3-7-3z" />
    """
  end
end
