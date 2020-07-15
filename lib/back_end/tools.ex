  
defmodule BackEnd.Tools do
  def validate_email(email) do
    Regex.match?(
      ~r/^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/,
      email
    )
  end

  def get_error_message_from_changeset(changeset) do
    errors = changeset.errors

    Enum.reduce(errors, "", fn {_key, {message, _}}, acc ->
      if is_empty?(acc),
        do: message,
        else: acc <> ", #{message}"
    end)
  end

  def is_empty?(value) when value in [nil, "null", "", "undefined", %{}, []], do: true
  def is_empty?(_), do: false

  def to_int(el) when el in [nil, "", "null", "undefined", "", [], %{}], do: 0
  def to_int(el) when is_bitstring(el), do: String.to_integer(el)
  def to_int(el) when is_integer(el), do: el
  def to_int(_), do: 0

  def assoc_loaded?(%Ecto.Association.NotLoaded{}), do: false
  def assoc_loaded?(list) when is_list(list), do: true
  def assoc_loaded?(%{}), do: true
  def assoc_loaded?(%_{}), do: true
  def assoc_loaded?(nil), do: true
end