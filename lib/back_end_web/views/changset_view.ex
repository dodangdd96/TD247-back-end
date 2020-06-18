defmodule BackEndWeb.ChangesetView do
    use BackEndWeb, :view
  
    @doc """
    Traverses and translates changeset errors.
  
    See `Ecto.Changeset.traverse_errors/2` and
    `BackEnd.ErrorHelpers.translate_error/1` for more details.
    """
    def translate_errors(%Ecto.Changeset{} = changeset) do
      Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
    end
  
    # def translate_errors(string) when is_bitstring(string) do
    #   string
    # end
  
    def translate_errors(error), do: error
  
    def render("error.json", %{changeset: %{message: message}}) do
      # When encoded, the changeset returns its errors
      # as a JSON object. So we just pass it forward.
      %{success: false, message: message}
    end
  
    def render("error.json", %{changeset: changeset}) do
      # When encoded, the changeset returns its errors
      # as a JSON object. So we just pass it forward.
      %{success: false, errors: to_json(changeset)}
    end
  
    def to_json(%Ecto.Changeset{} = changeset) do
      translate_errors(changeset)
    end
  
    def to_json(errors) when is_list(errors), do: errors
  
    def to_json(%{} = map) do
      Enum.reduce(map, %{}, fn {key, changeset}, acc ->
        acc |> Map.put(key, translate_errors(changeset))
      end)
    end
  end
  