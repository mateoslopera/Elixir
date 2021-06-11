defmodule PracticaTest do
  use ExUnit.Case
  doctest Practica

  test "greets the world" do
    assert Practica.hello() == :world
  end
end
