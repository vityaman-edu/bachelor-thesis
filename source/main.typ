#import "itmo-bachelor-thesis.typ": itmo-bachelor-thesis, structural-element, chapter, term

#show: itmo-bachelor-thesis.with(
  faculty: "Факультет программной инженерии и компьютерной техники",
  program: "Системное и прикладное программное обеспечение",
  specialty: "Программно-информационные системы",
  title: "Реализация модуля контекcтно-зависимого
  автодополнения запросов на YQL",
  author: "Смирнов Виктор Игоревич",
  mentor: "Осипов Святослав Владимирович",
  consultant: "Мясников Алексей Сергеевич",
  year: 2025,
)

#heading(numbering: none, outlined: false)[Задание]

#lorem(50)

#lorem(25)

#heading(numbering: none, outlined: false)[Аннотация]

#lorem(50)

#lorem(25)

#structural-element("Содержание", outlined: false)
#outline(title: none)

#structural-element("Cписок сокращений и условных обозначений")

#term([СУБД], [система управления базами данных])

#term([CLI], [command-line interface])

#structural-element("Термины и определения")

#term([YDB], [распределённая отказоустойчивая Distributed SQL СУБД])

#term([YQL], [универсальный декларативный язык запросов к YDB, диалект SQL])

#term([ANTLR4], [генератор парсеров])

#term([antlr4-c3], [библиотека для автодополнения])

#structural-element("Введение")

#lorem(50)

#lorem(25)

#structural-element("Глава 1. Обзор предметной области")

== СУБД YDB и клиентское приложение YDB CLI

#lorem(50)

#lorem(25)

== Язык запросов YQL

#lorem(50)

#lorem(25)

== Генератор парсеров ANTLR4

#lorem(50)

#lorem(25)

== Существующие решения

#lorem(50)

#lorem(25)

== Библиотека для автодополнения antlr4-c3

#lorem(50)

#lorem(25)

#structural-element("Глава 2. Проектирование программного модуля")

== Требования

#lorem(50)

#lorem(25)

== Архитектура

#lorem(50)

#lorem(25)

#structural-element("Глава 3. Реализация локального анализа запроса")

== Подготовка библиотеки antlr4-c3

#lorem(50)

#lorem(25)

== Использование библиотеки antlr4-c3

#lorem(50)

#lorem(25)

== Получение ключевых слов

#lorem(50)

#lorem(25)

== Обнаружение встроенных имен

#lorem(50)

#lorem(25)

== Обнаружение имен объектов БД

#lorem(50)

#lorem(25)

#structural-element("Глава 4. Реализация сервиса имен")

== Интерфейс сервиса имен

#lorem(50)

#lorem(25)

== Сервис встроенных имен

#lorem(50)

#lorem(25)

== Алгоритм ранжирования кандидатов

#lorem(50)

#lorem(25)

== Сервис имен объектов БД

#lorem(50)

#lorem(25)

== Декораторы сервисов имен

#lorem(50)

#lorem(25)

#structural-element("Глава 5. Реализация глобального анализа запроса (МБ НЕ БУДЕТ)")

== Обнаружение кластера

#lorem(50)

#lorem(25)

== Вывод схемы источника данных

#lorem(50)

#lorem(25)

== Автодополение имен колонок

#lorem(50)

#lorem(25)

#structural-element("Глава 6. Тестирование и внедрение решения")

== Модульное тестирование

#lorem(50)

#lorem(25)

== Внедрение в YDB CLI

#lorem(50)

#lorem(25)

== Внедрение в YQL Service (МБ НЕ БУДЕТ)

#lorem(50)

#lorem(25)

#structural-element("Заключение")

#lorem(50)

#lorem(25)

#structural-element("Cписок использованных источников")

#bibliography(
  "bibliography.yml",
  title: none,
  full: true,
)
