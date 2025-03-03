defmodule ArtistWeb.CategoryHTML do
  use ArtistWeb, :html

  embed_templates "category_html/*"

  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def category_form(assigns)
end
