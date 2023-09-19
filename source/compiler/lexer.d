module compiler.lexer;

import std.stdio : writeln;
import std.container : DList;
import std.array : appender;

public struct Operation 
{
  byte optCode;
  byte tCode;
  ubyte[] value;
}

/**
import std;
import std.bitmanip;
import std.range.primitives : empty;
import std.conv : to;
import std.bitmanip : nativeToBigEndian, bigEndianToNative;

void main()
{
    ubyte[] buffer = [49,50];
    writeln(buffer.length); // 7
	  auto ch = cast(char[])buffer;
    int ich = to!int(ch);
    writeln(ich); 
    auto bich = nativeToBigEndian(ich);
    writeln(bich);
    int i = bigEndianToNative!int(bich);
    writeln(i);
}
*/

public enum OptCode : byte {
  Push = 0,
  Pop = 1,
  Swap = 2,
  Jmp = 3,
  Top = 4,
  Dub = 5,
  Add = 7,
  Sub = 8,
  Mul = 9,
  Div = 10,
  Halt = 11,
  Unknown = -1,
}

enum Lexems : ubyte[] {
  Push = [80, 117, 115, 104],
  Add = [65, 100, 100],
  Number = [30, 31, 32, 33, 34, 35, 36, 37, 38, 39],
}

public enum NativeTypes : byte {
  Void = -1,
  Bool = 0,
  Byte = 1,
  UByte = 2,
  Short = 3,
  UShort = 6,
  Int = 7,
  UInt = 8,
  Lont = 9,
  ULong = 10, 
  Cent = 11,
  UCent = 12,
  Float = 13,
  Double = 14,
  Real = 15,
  IFloat = 16,
  IDouble = 17,
  IReal = 18,
  CFloat = 19,
  CDouble = 20,
  CReal = 21,
  Char = 22,
  WChar = 23,
  DChar = 24,
}

public class LineLexer 
{
  // Список созданных экземпляром
  // лексера опрераций
  private DList!Operation operations;
  // Количество созданных лексером операций
  private ulong size;
  
  this()
  {
    // Инициализируем список операций
    operations = DList!Operation();
  }

  @safe private byte getOptCode(ref ubyte[] instruction) {
    // Инициализируем код инструкции
    byte code;
    // Сравниваним значение массива инструкции и 
    // массива лексемы, чтобы получить код
    // операции
    if (instruction == Lexems.Add) 
    {
      // Если массив инструкции совпадает с лексемой
      // инструкции сложения, то присваеваем
      // код добавления
      code = OptCode.Add;
    } 
    else if (instruction == Lexems.Push)
    {
      // Если массив инструкции совпадает с лексемой
      // инструкции добавления в стек, чтобы получить код
      // операции
      code = OptCode.Push;
    } 
    else 
    {
      // Если массив инсрукций не совпадает ни с одним,
      // то присваивается код неизвестной операции
      code = OptCode.Unknown;
    }
    return code;
  }

  @safe public void addOperation(ref ubyte[] instruction, ref ubyte[] value) 
  {
    // Получаем код операции
    auto code = getOptCode(instruction);
    // Получаем операцию
    auto oper = Operation(code, value);
    // Добавляем ее как вершину списка
    operations.insertFront(oper);
    // Увеличиваем количество созданных операций
    // на единицу
    size++;
  }

  @safe public ulong getSize()
  {
    return size; 
  }

  public DList!Operation getOperations() 
  {
    return operations;
  }
}