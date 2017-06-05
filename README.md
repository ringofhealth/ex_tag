[![CircleCI](https://circleci.com/gh/bizneo/taglet/tree/master.svg?style=svg)](https://circleci.com/gh/bizneo/taglet/tree/master)

# Taglet

Taglet allows you to manage tags associated to your records.

It also allows you to specify various contexts 

## Installation

  1. Add `taglet` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:taglet, github: "bizneo/taglet"}]
  end
  ```

  2. Configure Taglet to use your repo in `config/config.exs`:

  ```elixir
  config :taglet, repo: ApplicationName.Repo
  ```

  3. Install your dependencies:

  ```mix deps.get```

  4. Generate the migrations:

  ```mix taglet.install```

  5. Run the migrations:

  ```mix ecto.migrate```

## Include it in your models

Now, you can use the library in your models.

You should add the next line to your taggable model:

`use Taglet.ModelManager, :tag_context_name`

i.e.:

  ```elixir
  defmodule Post do
    use Ecto.Schema
    use Taglet.ModelManager, :tags
    use Taglet.ModelManager, :categories

    import Ecto.Changeset

    schema "posts" do
      field :title, :string
      field :body, :boolean

      timestamps()
    end

    def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, [:title, :body])
      |> validate_required([:title])
    end
  end
  ```
As you can see, we have included two different contexts, tags and
categories

Now we can use a set of metaprogrammed functions:

`Post.add_category(struct, tag)` - Passing a persisted struct will
allow you to associate a new tag

`Post.remove_category(struct, tag)` - Will allow you to remove a tag

`Post.categories_list(struct, tag)` - List all associated tags

`Post.tagged_with_category(tag)` - Search for all tags associated to this context
