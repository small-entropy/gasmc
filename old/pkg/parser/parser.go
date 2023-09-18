package parser

import (
	"errors"

	"gitflic.ru/project/oldnerd88/gasm-compiler/internal/operation"
	"gitflic.ru/project/oldnerd88/gasm-compiler/pkg/codes"
)

// Parser
// парсер данных
type Parser struct {
	NumberOfLines      int // количество строк кода
	NumberOfOperations int // количество операций
}

// getOperations
// функция получения операций из строк
func (p *Parser) getOperations(lines [][]byte) ([]operation.Operation, error) {
	var err error                        // инициализируем ошибку
	var operations []operation.Operation // инициализируем массив операций

	// Проверяем длину массива
	if len(lines) == 0 {
		// если длина массива больше, то
		// создаем экземпляр новой ошибки
		err = errors.New("emty data lines for parse to operations")
	} else {
		// Перебираем строки кода
		for _, line := range lines {
			op := operation.Operation{} // инициализируем операцию
			endIntruction := false      // инициализируем семафор конца операции

			// Перебираем по байтам символы строки
			for _, b := range line {
				switch b { // проверяем символ
				case codes.SPCode:
					// если символ - пробел, то
					// взводим флаг окончания инструкции
					endIntruction = true
				default:
					// если символ не проблем, то
					// продолжаем проверку
					if b != codes.CRCode {
						// Если символ не является кареткой,
						// то заполняем массив
						if endIntruction {
							// если инструкция не закончилась, то
							// добавляем символ к ней
							op.Instruction = append(op.Instruction, b)
						} else {
							// если инструкция закончилась, то
							// добавляем символ к значению
							op.Value = append(op.Value, b)
						}
					}
				}
			}
		}
	}
	return operations, err
}

// getLines
// функция получения строк из массива байт
func (p *Parser) getLines(data []byte) ([][]byte, error) {
	var err error // инициализируем ошибку

	lines := [][]byte{} // инициализируем массив строк кода
	line := []byte{}    // инициализируем массив символов

	itComment := false // инициализируем семафор комментария в состоянии "ЛОЖЬ"

	// Проверяем длину массива данных для анализа
	if len(data) == 0 {
		// Если длина равна 0, то собираем новый
		// экземпляр ошибки
		err = errors.New("empty data for parse to lines")
	} else {
		// Перебираем данные по байтам
		for _, b := range data {
			// проверяем значение байта
			if b == codes.CCode {
				// если байт соответствует символу "комментария", то
				// взводим семафор в значение "ИСТИНА"
				itComment = true
			} else {
				// если байт не соотвествует символу "комментария", то
				// продолжаем проерку
				if !itComment {
					if b != codes.EOLCode && b != codes.NLCode {
						// если не соответствует концу файла или
						// новой строке, то добавляем байт в строку кода
						line = append(line, b)
					} else {
						// если соотвествует концу файла и/или новой строке, то
						// добавялеем строку в массив строк кода и создаем пустой
						// экземпляр строки
						lines = append(lines, line)
						line = []byte{}
					}
				}
			}
		}
	}
	return lines, err
}

// Parse
// функция получения массива операций из массива байт
func (p *Parser) Parse(data []byte) ([]operation.Operation, error) {
	var err error                        // инициализируем ошибку
	var operations []operation.Operation // инициализируем массив операций

	var lines [][]byte // инициализируем массив строк

	// Перебираем входящие данные, формируем строки
	if lines, err = p.getLines(data); err == nil {
		// Получаем количество строк и записываем
		p.NumberOfLines = len(lines)
		// Получаем массив операций
		operations, err = p.getOperations(lines)
		// Получаем количество операций и записываем
		p.NumberOfOperations = len(operations)
	}

	return operations, err
}
