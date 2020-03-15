defmodule HelloWeb.AbsintheHelpers do
  def query_skeleton(query, query_name) do
    %{
      "operationName" => "#{query_name}",
      "query" => "query #{query_name} #{query}",
      "variables" => "{}"
    }
  end


  def mutation_skeleton(mutation, variables) do
    %{
      "operationName" => "",
      "query" => "#{mutation}",
      "variables" => variables
    }
  end
end
