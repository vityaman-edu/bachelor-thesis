#import "itmo-bachelor-thesis.typ": itmo-bachelor-thesis, structural-element, chapter, term

#show: itmo-bachelor-thesis.with(
  title: "Реализация модуля контекcтно-зависимого автодополнения запросов на YQL",
  author: "Смирнов Виктор Игоревич",
)

#heading(numbering: none, outlined: false)[Задание]

#lorem(50)

#lorem(25)

#heading(numbering: none, outlined: false)[Аннотация]

#lorem(50)

#lorem(25)

#structural-element("Содержание", outlined: false)
#outline(title: none)

#structural-element("Cписок сокращений
и условных обозначений")

#term([СУБД], [система управления базами данных])
#term([YDB], [распределённая отказоустойчивая Distributed SQL СУБД])
#term([YQL], [универсальный декларативный язык запросов к YDB, диалект SQL])
#term([CLI], [command-line interface])

#structural-element("Термины и определения")

#term([Highlighting Unit], [query text substring to be highlighted])
#term([Token], [token name from the _YQL Grammar_])
#term([Rule], [production rule name from the _YQL Grammar_])
#term(
  [YQL],
  [YQL formal grammar represented in ANTLR4 format, this is the single source of truth about the language syntax],
)
#term([Theme], [mapping from _Highlighting Unit_ to a _Color_])
#term([Color], [RGB-equivalent HEX])

#structural-element("Введение")

Тема работы --- реализация модуля контекcтно-зависимого автодополнения запросов на YQL.

Цель работы --- повышение качества автодополнения запросов на YQL в YDB CLI.

Техническое задание --- реализация модуля контекстно-зависимого автодополнения YQL в YDB CLI исключающего неподходящих по семантическому контексту кандидатов.

Исходные данные к работе
- Документация к проекту YDB
- Задачи в проектах YDB
- Репозитории исходных кодов проектов YDB и antlr4-c3

Задачи работы
- Адаптация библиотеки автодополнения antl4-c3 для использования в проекте YDB
- Проектирование алгоритма контекстно-зависимого автодополнения YQL
- Валидация алгоритма контекстно-зависимого автодополнения YQL
- Проектирование модуля контекстно-зависимого автодополнения YQL
- Разработка модуля контекстно-зависимого автодополнения YQL
- Верификация модуля контекстно-зависимого автодополнения YQL

Перечень подлежащих разработке вопросов
- Синтаксический анализ программного кода
- Формальные грамматики
- Семантический анализ программы
- Автодополнение программного кода
- SQL

#chapter("Формальные языки")

== Генерация языка

Рассмотрим формулу генерации языка

#math.equation($L(G) = { w in Sigma^* | S =>^* w },$)

где $L(G)$ — язык, порождаемый грамматикой $G$, $Sigma^*$ — множество всех строк над $Sigma^*$, $S =>^* w$ означает, что $w$ может быть получено из стартового символа $S$ с помощью нуля или более шагов вывода.

#lorem(25)

== Обзор СУБД YDB

Давайте лучше разберемся в том, как пользователь взаимодействует с YDB. @ydb-interact иллюстрирует взаимодействие пользователя с YDB через консольный клиент YDB CLI.

#figure(
  image("image/ydb.png", width: 65%),
  caption: [Схема взаимодейтвия пользователя с YDB],
) <ydb-interact>

#lorem(25)

К преимуществам YDB относят:
- отказоустойчивость,
- высокую пропусную способность на OLTP нагрузках.

Общие принципы заданий:
+ решение должно быть собрано при помощи CMake, но по желанию студента возможно использование другой системы сборки по согласованию с преподавателем (например, Bazel, Ya Tool, …),
+ Решение должно быть реализованы на языке C++ с использованием возможностей современного стандарта (не ниже C++20).

#lorem(25)

Именно в этот момент внимательный читатель заметит, что у YQL есть фирменная тема для раскраски в редакторах кода. @yql-highlight показывает, в какой цвет окрашивается каждая единица подсветки в зависимости от используемой темы.

#figure(
  table(
    columns: (auto, auto, auto),
    align: horizon,
    table.header(
      [*Единица подсветки*],
      [*Monaco Light*],
      [*Monaco Dark*],
    ),

    [*Keyword*], "#0000ff", "#569cd6",
    [*Punctuation*], "#000000", "#d4d4d4",
    [*Identifier*], "#001188", "#74b0df",
  ),
  caption: [Связь единиц подсветки, тем и цветов],
) <yql-highlight>

#lorem(25)

#chapter("Автодополнение YQL")

#lorem(25)

#lorem(25)

#structural-element("Заключение")

#lorem(50)

#structural-element("Cписок использованных источников")

#bibliography(
  "bibliography.yml",
  title: none,
  full: true,
)

#structural-element("Приложение")

#lorem(50)
