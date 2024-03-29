defmodule Taglet.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "tags" do
    field(:name, :string)

    has_many(:taggings, Taglet.Tagging)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required(:name)
    |> unique_constraint(:name, message: "tag already imported")
  end
end
