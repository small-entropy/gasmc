module compiler.parser;

import compiler.lexer : LineLexer;
import compiler.symbols : ReservedSymbols;
import std.array : appender;
import std.stdio : writeln, File;

public class Parser 
{
  // Количество обработанных строк
  private ulong numberOfLines;
  // Количество полученных операций
  private ulong numberOfOperations;
  // Экземпляр лексера
  private LineLexer lineLexer;

  this()
  {
    // Задаем начальное значение
    // обработанных строк
    numberOfLines = 0;
    // Задачем начальное значение
    // созданных операций
    numberOfOperations = 0;
    // Создаем экземпляр лексера
    lineLexer = new LineLexer();
  }

  private void parseLine(char[]* line) 
  {
    // Массив байт, который идентифицирует
    // инструкцию
    ubyte[] instruction;
    // Массив байт, который идентифицирует
    // данные
    ubyte[] value;
    // Семафор, который говорит, что
    // значение закончилась инструкуция
    bool endOpt = false;
    // Создаем расширетель массиа байт инструкции
    auto iapp = appender(&instruction);
    // Созщдаем расширитель массива байт данных
    auto vapp = appender(&value);
    // Перебираю байты строки
    foreach (ch; *line)
    {
      // Приводим символ (charset) к байтам
      auto bch = cast(byte)ch;
      // Проверяем значение байта
      if (bch == ReservedSymbols.Comment) {
        // Если символ соответствует коду #,
        // то пропускам обработку строки
        break;
      }
      else
      {
        // Если у меня строка не комментарий
        // то продолжаем проверку
        if (ch == ReservedSymbols.Space) {
          // Если код символа соответствует
          // пробелу, то считаем, что
          // инструкция закончилась
          endOpt = true;
        }
        else
        {
          // Если символ не равено пробелу, то
          // продолжаем проверять поток символов
          if (bch != ReservedSymbols.Carret) {
            // Если символ не равен каретки,
            // то продолжаем проверку
            if (endOpt) {
              // Если инструкция закончилась,
              // то заполняем массив данных
              vapp.put(bch);
            } else {
              // Если инструкция не закончилась,
              // то заполняем массив инструкции
              iapp.put(bch);
            }
          }
        }
      }
    }
    // Проверяем заполнился ли массив инструкции
    if (instruction.length != 0) {
      // Если массиив инструкции заполнился, то
      // создаем новую операцию
      lineLexer.addOperation(instruction, value);
      // Увеличиваем счетчик операций на 1
      numberOfLines++;
      // Получаем текущее количество существующих
      // (созданных) операций
      numberOfOperations = lineLexer.getSize();
    }
  }

  public int parse(ref File file) 
  {
    // Читаем переданный файл
    auto range = file.byLine();
    // Парсим содержание файла
    // по строчно
    foreach (line; range)
    {
      // парсим строку
      parseLine(&line);
    }
    return 1;
  }

  public LineLexer* getLexer() {
    return &lineLexer;
  }

  public ulong getNumberOfOperations()
  {
    return numberOfOperations;
  }

  public ulong getNumberOfLines() 
  {
    return numberOfLines;
  }
}