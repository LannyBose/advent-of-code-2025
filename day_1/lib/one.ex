defmodule One do
  @moduledoc """
  Documentation for `One`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> One.hello()
      :world

  """
  def distance(filename) do
    regex = ~r/(\d+)\s+(\d+)/

    File.stream!(filename)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&Regex.run(regex, &1, capture: :all_but_first))
    |> Stream.map(&string_tuples_to_integers/1)
    |> Enum.reduce([[], []], fn [one, two], [first_list, second_list] ->
      [
        insert_sorted(one, first_list),
        insert_sorted(two, second_list)
      ]
    end)

    # |> Enum.zip_reduce(0, fn [one, two], acc ->
    #   acc + abs(one - two)
    # end)

    # |> Enum.into([])
  end

  defp string_tuples_to_integers([first, second]) do
    [
      String.to_integer(first),
      String.to_integer(second)
    ]
  end

  def insert_sorted(item, []), do: [item]

  def insert_sorted(item, [first | rest]) when item <= first do
    [item | [first | rest]]
  end

  def insert_sorted(item, [first | rest]), do: [first | insert_sorted(item, rest)]

  def frequency(filename) do
    regex = ~r/(\d+)\s+(\d+)/

    File.stream!(filename)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&Regex.run(regex, &1, capture: :all_but_first))
    |> Stream.map(&string_tuples_to_integers/1)
    |> Enum.reduce([[], []], fn [one, two], [first_list, second_list] ->
      [
        insert_sorted(one, first_list),
        insert_sorted(two, second_list)
      ]
    end)
    |> then(fn [first_list, second_list] ->
      Enum.reduce(first_list, 0, fn first_list_item, total_score_so_far ->
        total_score_so_far + tally_single_item_score(first_list_item, second_list)
      end)
    end)

    # |> Enum.into([])
  end

  def tally_single_item_score(_, []), do: 0

  def tally_single_item_score(first_item, [second_item | _rest]) when first_item < second_item,
    do: 0

  def tally_single_item_score(first_item, [second_item | rest]) when first_item == second_item,
    do: first_item + tally_single_item_score(first_item, rest)

  def tally_single_item_score(first_item, [second_item | rest]) when first_item > second_item,
    do: tally_single_item_score(first_item, rest)
end
