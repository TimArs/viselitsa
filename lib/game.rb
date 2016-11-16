# encoding: utf-8

# Основной класс игры. Хранит состояние игры и предоставляет функции
# для развития игры (ввод новых букв, подсчет кол-ва ошибок и т. п.)
#
# За основу взяты методы из первой версии этой игры (подробные комментарии смотрите в прошлых
# уроках).
require "unicode_utils/upcase"

class Game
  attr_reader :errors, :letters, :good_letters, :bad_letters, :status

  attr_accessor :version

  MAX_ERRORS = 7
  # конструктор - вызывается всегда при создании объекта данного класса
  # имеет один параметр, в него нужно передавать при создании загаданное слово
  def initialize(slovo)
    # инициализируем данные как поля класса
    @letters = get_letters(slovo)

    # переменная-индикатор кол-ва ошибок, всего можно сделать не более 7 ошибок
    @errors = 0

    # массивы, хранящие угаданные и неугаданные буквы
    @good_letters = []
    @bad_letters = []

    # спец. поле индикатор состояния игры (см. метод get_status)
    @status = :in_progress # :won :lost
  end

  # Метод, который возвращает массив букв загаданного слова
  def get_letters(slovo)
    if (slovo == nil || slovo == "")
      abort "Задано пустое слово, не о чем играть. Закрываемся."
    else
      slovo = slovo.encode("UTF-8")
    end

    return slovo.split("")
  end

  def max_errors
    MAX_ERRORS
  end

  def errors_left
    MAX_ERRORS - @errors
  end

  #Метод возвращает true, если пользователь ввел одну из особых букв

  def is_good?(letter)
      letters.include?(letter) ||
      (letter == "е" && letters.include?("ё")) ||
      (letter == "ё" && letters.include?("е")) ||
      (letter == "и" && letters.include?("й")) ||
      (letter == "й" && letters.include?("и"))
  end

  def add_letter_to(letters,letter)
    letters << letter # запишем её в число "правильных" буква

    case letters
      when 'И' then letters << 'Й'
      when 'Й' then letters << 'И'
      when 'Е' then letters << 'Ё'
      when 'Ё' then letters << 'Е'
    end
  end

  def solved?
    (@letters - @good_letters).empty?
  end

  def repeated?
    @good_letters.include?(letter) || @bad_letters.include?(letter)
  end

  def lost?
    @status ==:lost || @errors >= MAX_ERRORS
  end

  def won?
    @status ==:won
  end

  def in_progress?
    @status == :in_progress
  end
  # Основной метод игры "сделать следующий шаг"
  # В качестве параметра принимает букву
  # Основная логика взята из метода check_letter (см. первую версию программы)
  def next_step(letter)
    letter = Unicode.upcase(letter)
    # Предварительная проверка: если статус игры равен 1 или -1, значит игра закончена,
    # нет смысла дальше делать шаг

    return  if @status == :lost || @status == :won

    # если введенная буква уже есть в списке "правильных" или "ошибочных" букв,
    # то ничего не изменилось, выходим из метода
    if repeated?
      return
    end

    if is_good?(letter)
      add_letter_to(@good_letters,letter)
      @status = :won if solved?
    else # если в слове нет введенной буквы
      add_letter_to(@bad_letters,letter)
      @errors += 1
      @status = :lost if lost?
    end
  end

  # Метод, спрашивающий юзера букву и возвращающий ее как результат.
  # В идеале этот метод лучше вынести в другой класс, потому что он относится не только
  # к состоянию игры, но и к вводу данных.
  def ask_next_letter
    puts "\nВведите следующую букву"
    letter = ""
    while letter == "" do
      letter = STDIN.gets.encode("UTF-8").chomp
    end
    # после получения ввода, передаем управление в основной метод игры
    next_step(letter)
  end
end
