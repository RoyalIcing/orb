defmodule Orb.Ops do
  @moduledoc false

  # See: https://webassembly.github.io/spec/core/syntax/instructions.html#numeric-instructions
  @i_unary_ops ~w(clz ctz popcnt)a
  @i_binary_ops ~w(add sub mul div_u div_s rem_u rem_s and or xor shl shr_u shr_s rotl rotr)a
  @i_test_ops ~w(eqz)a
  @i_relative_ops ~w(eq ne lt_u lt_s gt_u gt_s le_u le_s ge_u ge_s)a
  # https://developer.mozilla.org/en-US/docs/WebAssembly/Reference/Memory/Load
  @i_load_ops ~w(load load8_u load8_s load16_s load16_u)a
  # https://developer.mozilla.org/en-US/docs/WebAssembly/Reference/Memory/Store
  @i_store_ops ~w(store store8 store16)a
  # https://developer.mozilla.org/en-US/docs/WebAssembly/Reference/Numeric/Truncate_float_to_int
  @i_trunc_ops ~w(trunc_f32_s trunc_f32_u trunc_f64_s trunc_f64_u)a

  @i32_ops_1 @i_unary_ops ++ @i_test_ops ++ @i_trunc_ops
  @i32_ops_2 @i_binary_ops ++ @i_relative_ops
  @i32_ops_all @i32_ops_1 ++ @i32_ops_2 ++ @i_load_ops ++ @i_store_ops

  @f32_ops_1 ~w(convert_i32_s convert_i32_u)a
  @f32_ops_2 ~w(mul)a

  defmacro i32(arity_or_type)
  defmacro i32(1), do: @i32_ops_1 |> Macro.escape()
  defmacro i32(2), do: @i32_ops_2 |> Macro.escape()
  defmacro i32(:load), do: @i_load_ops |> Macro.escape()
  defmacro i32(:store), do: @i_store_ops |> Macro.escape()
  defmacro i32(:all), do: @i32_ops_all |> Macro.escape()

  defmacro f32(arity_or_type)
  defmacro f32(1), do: @f32_ops_1 |> Macro.escape()
  defmacro f32(2), do: @f32_ops_2 |> Macro.escape()
end
