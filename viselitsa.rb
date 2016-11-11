# encoding: utf-8

# Популярная детская игра, версия 3 - с чтением данных из внешних файлов
# https://ru.wikipedia.org/wiki/Виселица_(игра)

# вставляем наши классы, теперь с правильным расположением
# (см. объяснение в исходника и видео прошлого урока)

current_path = "./" + File.dirname(__FILE__)

require current_path + "/lib/game.rb"
require current_path + "/lib/result_printer.rb"
require current_path + "/lib/word_reader.rb"

VERSION = "Игра виселица. Версия 4.\n\n"

# создаем объект, отвечающий за ввод слова в игру
word_reader = WordReader.new

words_file_name = current_path + "/data/words.txt"

# создаем объект типа Game, в конструкторе передаем загаданное слово из word_reader-а
game = Game.new(word_reader.read_from_file(words_file_name))

game.version = VERSION
# создаем объект, печатающий результаты
printer = ResultPrinter.new

# основной цикл программы, в котором развивается игра
# выходим из цикла, когда объект игры сообщит нам, c пом. метода status
while game.in_progress? do
  # выводим статус игры
  printer.print_status(game)
  # просим угадать следующую букву
  game.ask_next_letter
end

printer.print_status(game)

# Обратите внимание насколько короче, проще и элегантнее стал основной код программы.
# В этом и заключается сила объектно-ориентированного подхода.

