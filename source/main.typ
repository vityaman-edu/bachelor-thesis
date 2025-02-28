#import "itmo-bachelor-thesis.typ": itmo-bachelor-thesis, structural-element, chapter

#show: itmo-bachelor-thesis.with(
  title: "Реализация модуля контекcтно-зависимого автодополнения запросов на YQL",
  author: "Смирнов Виктор Игоревич",
)

#heading(numbering: none, outlined: false)[Задание]

#lorem(50)

#heading(numbering: none, outlined: false)[Аннотация]

#lorem(50)

#structural-element("Содержание", outlined: false)
#outline(title: none)

#structural-element("Cписок сокращений и условных обозначений")

#lorem(50)

#structural-element("Термины и определения")

#lorem(50)

#structural-element("Введение")

#lorem(50)

#chapter("Формальные языки")

== Генерация языка

Рассмотрим формулу генерации языка

$ L(G) = { w in Sigma^* | S =>^* w } $

где,

- $L(G)$ — язык, порождаемый грамматикой $G$.

- $Sigma^*$ — множество всех строк над $Sigma^*$.

- $S =>^* w$ означает, что ww может быть получено из стартового символа $S$ с помощью нуля или более шагов вывода.

#lorem(25)

== Обзор СУБД YDB

Давайте лучше разберемся в том, как пользователь взаимодействует с YDB. @ydb-interact иллюстрирует взаимодействие пользователя с YDB через консольный клиент YDB CLI.

#figure(
  image("image/ydb.png", width: 65%),
  caption: [Схема взаимодейтвия пользователя с YDB],
) <ydb-interact>

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
    [*Identifier*], "#001188", "#74b0df"
  ),
  caption: [Связь единиц подсветки, тем и цветов]
) <yql-highlight>

#lorem(25)

#chapter(lorem(4))

#lorem(25)

#lorem(25)

#structural-element("Заключение")

#lorem(50)

#structural-element("Cписок использованных источников")

#lorem(50)

#structural-element("Приложение")

#lorem(50)
