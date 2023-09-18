package compiler

import (
	"bytes"
	"encoding/binary"
	"errors"
	"log"
	"os"

	"gitflic.ru/project/oldnerd88/gasm-compiler/internal/operation"
	"gitflic.ru/project/oldnerd88/gasm-compiler/pkg/codes"
	"gitflic.ru/project/oldnerd88/gasm-compiler/pkg/parser"
)

// Compiler
// структура (объект) компилятора в байткод
type Compiler struct {
	SourcePath string
	ResultPath string
}

// Convert
// функция конвертирует массив операций в байт-код
func (c *Compiler) Convert(operations []operation.Operation) ([]byte, error) {
	var err error       // инициализируем ошибку
	var byteCode []byte // инициализируем массив байт-кода
	var optCode byte    // инициализируем код операции

	// Проверяем массив операций
	if len(operations) == 0 {
		// если массив операций имеет длину равную 0, то
		// создаем новый экземпляр ошибки
		err = errors.New("operations list is empty")
	} else {
		// Перебираем массив операций
		for _, o := range operations {
			// пытаемся получить код операции
			if optCode, err = o.GetOptCode(); err == nil {
				// если удалось получить код операции, то
				// собираем байт-код для операнда
				byteCode = append(byteCode, codes.NLByteCode) // добавляем символ начала нового операнда
				byteCode = append(byteCode, optCode)          // добавляем код операнда
				byteCode = append(byteCode, codes.VByteCode)  // добавляем разделитель операнд/значение
				byteCode = append(byteCode, o.Value...)       // добавляем значение
			} else {
				break
			}
		}
	}

	return byteCode, err
}

// Read
// функция чтения файла-источника по пути (сохранен в компилятор)
func (c *Compiler) Read() ([]byte, error) {
	return os.ReadFile(c.SourcePath)
}

// Write
// функция записи байт-кода в файл-получатель
func (c *Compiler) Write(byteCode []byte) error {
	file, err := os.Create(c.ResultPath)
	defer file.Close()

	if err != nil {
		log.Fatal(err)
	}

	buf := bytes.NewBuffer([]byte{})
	binary.Write(buf, binary.BigEndian, byteCode)
	file.Write(buf.Bytes())
	return err
}

// Compile
// функция компиляции данных из файла-источника в байт-код, который
// записывается в файл-получатель
func (c *Compiler) Compile() error {
	var err error       // инициализируем ошибку
	var data []byte     // инициализируем данные источника
	var byteCode []byte // инициализируем байт-код (данные получателя)

	// Читаем данные из файла
	if data, err = c.Read(); err == nil {
		// пытаемся получить байт-код из полученных даных
		if byteCode, err = c.ByteCode(data); err == nil {
			// если удалось получить байт-код, то
			// пытаемся записть его в файл
			err = c.Write(byteCode)
		}
	}

	return err
}

// ByteCode
// функция компиляции данных в байт-код
func (c *Compiler) ByteCode(data []byte) ([]byte, error) {
	var err error       // инициализируем ошибку
	var byteCode []byte // инициализируем байт-код (данные получателя)
	// Создаем экземпляр парсера
	p := parser.Parser{}
	// Пытаемся получить массив операций
	var operations []operation.Operation
	if operations, err = p.Parse(data); err == nil {
		// если удалось получить массив операций при разборе
		// данных-источника, то пытаемся перевести их в байт-код
		byteCode, err = c.Convert(operations)
	}

	return byteCode, err
}
