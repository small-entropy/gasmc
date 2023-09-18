module test.gasm_compiler;

import compiler.gasm : GasmCompiler;

@("Создание экземпляра компилятора (без параметров)")
unittest
{
  auto gc = new GasmCompiler();
  assert(*gc.getPathIn() == null);
  assert(*gc.getPathOut() == null);
}

@("Создание экземпляра компилятора (с параметрами)")
unittest
{
  string pathIn = "D:/Repositories/Github/gasmc/examples/example_add.gasm";
  string pathOut = "D:/Trash/gasm/example_add.gin";
  auto gc = new GasmCompiler(pathIn, pathOut);
  assert(*gc.getPathIn() == pathIn);
  assert(*gc.getPathOut() == pathOut);
}

@("Чтение входящего файла")
unittest
{
  string pathIn = "D:/Repositories/Github/gasmc/examples/example_add.gasm";
  string pathOut = "D:/Trash/gasm/example_add.gin";
  auto gc = new GasmCompiler(pathIn, pathOut);
  gc.read();
  assert(*gc.getPathIn() == pathIn);
  assert(*gc.getPathOut() == pathOut);
}