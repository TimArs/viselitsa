# encoding: utf-8

# Класса, отвечающий за ввод данных в программу "виселица"

require "unicode_utils/upcase"

class WordReader

  # Сохраним старую возможность читать слово из аргументов командной строки.
  # В качестве отедльного метода для обратной совместимости.
  def read_from_args
    string = ARGV[0]
    string = UnicodeUtils.upcase(string)
    return string
  end

  # Метод, возвращающий случайное слово, прочитанное из файла,
  # имя файла передается как аргумент метода
  def read_from_file(file_name)
    # проверка, если файла не существует, сразу возвращаем nil
    if !File.exist?(file_name)
      return nil
    end

    f = File.new(file_name, "r:UTF-8") # открываем файл, явно указывая его кодировку
    lines = f.readlines   # читаем все строки в массив
    f.close # закрываем файл
    return UnicodeUtils.upcase(lines.sample.chomp)
    # возвращаем случайную строчку из прочитанного массива,
    # не забывая удалить в конце символ перевода строки методом chomp
  end
end
