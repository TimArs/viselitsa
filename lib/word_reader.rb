# encoding: utf-8

# Класс, отвечающий за ввод данных в программу "Виселица"

require "unicode_utils/upcase"

class WordReader

  # Сохраним старую возможность читать слово из аргументов командной строки.
  # В качестве отедльного метода для обратной совместимости.
  def read_from_args
    UnicodeUtils.upcase(ARGV[0])
  end

  # Метод, возвращающий случайное слово, прочитанное из файла,
  # имя файла передается как аргумент метода
  def read_from_file(file_name)
    # проверка, если файла не существует, сразу возвращаем nil
    return unless File.exist?(file_name)
    
    f = File.new(file_name, "r:UTF-8") # открываем файл, явно указывая его кодировку
    lines = f.readlines   # читаем все строки в массив
    f.close # закрываем файл
    UnicodeUtils.upcase(lines.sample.chomp)
    # возвращаем случайную строчку из прочитанного массива,
    # не забывая удалить в конце символ перевода строки методом chomp
  end
end
