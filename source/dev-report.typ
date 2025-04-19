#import "itmo-bachelor-thesis.typ": itmo-bachelor-thesis, term, structural-element, chapter

#show: itmo-bachelor-thesis.with(
  faculty: "Факультет программной инженерии и компьютерной техники",
  program: "Системное и прикладное программное обеспечение",
  specialty: "Программно-информационные системы",
  title: [
    Отчет \
    о производственной, технологической практике \
    по теме "Разработка модуля \
    контекстно-зависимого автодополнения \ запросов на YQL"
  ],
  author: "Смирнов Виктор Игоревич, P34131",
  mentor: [
    \ Маркина Татьяна Анатольевна, старший преподаватель
  ],
  consultant: [
    \ Логинов Иван Павлович, генеральный директор \ ООО "Специальные Средства Программирования"
  ],
  year: 2025,
)

#structural-element("Содержание", outlined: false)
#outline(title: none)

#structural-element("Cписок сокращений и 
условных обозначений")

#term([СУБД], [система управления базами данных])
#term([YDB], [распределённая отказоустойчивая Distributed SQL СУБД])
#term([SQL], [декларативный язык программирования для получения, создания, модификации
и управления данными в реляционной базе данных])
#term([YQL], [универсальный декларативный язык запросов к YDB, диалект SQL])
#term([CLI], [command-line interface])
#term([ANTLR], [генератор парсеров по грамматике])
#term([GitHub], [веб-сервис для хостинга IT-проектов и их совместной разработки])

#structural-element("Характеристика организации")

Основным видом деятельности общества с ограниченной ответственностью "Специальные Средства Программирования" являются научные исследования и разработки в области естественных и технических наук.

#structural-element("Введение")

Целью практики по теме "Разработка модуля контекстно-зависимого автодополнения запросов на YQL" является повышение качества автодополнения запросов на YQL в YDB CLI. 

Изначально автодополнение в данном клиентском приложении практически отсутствовало. 
Необходимо было сперва подготовить индивидуальное задание на практику, собрать и проанализировать требования к будущему решению, поставить задачу, выбрать подходящие технологии для реализации, разобраться в процессе разработки (сборка проекта, интеграция с другими модулями, наладить взаимодействие со смежными командами), а далее инкременатально решать поставленную задачу.

#chapter("Сбор и анализ требований")

Первый этап разработки включал в себя сбор и анализ требований к модулю автодополнения YQL и их представление в текстовом виде. 
Критерием выполнения являлось создание задач в сервисе GitHub в проектах YDB и YQL и описание требований в комментариях.

На данном этапе были налажена связь с представителями команды разработки YDB SDK, которые отвечают за YDB CLI. 
У них не было конкретных сформулированных требований, так что их пришлось выяснять в процессе переговоров.

== Требования к пользовательскому интерфейсу

Были выделены следующие требования к пользовательскому интерфейсу:

- (UIR1) в интерактивном режиме YDB CLI должно осуществляться автодополнение запросов на YQL;

- (UIR2) по нажатию на клавишу TAB на экране должен быть отображен список кандидатов на автодополнение.

== Функциональные требования

Были выделены следующие функциональные требования:

- (FR1) автодополнение должно исключать кандидатов, не подходящих по синтаксическому контексту;

- (FR2) автодополнение должно предлагать именованные объекты базы данных.

== Технические требования

Были выделены следующие технические требования:

- (TR1) модуль автодополнения должен быть реализован на языке программирования C++;

- (TR2) сборка модуля автодополнения должена осуществляться при помощи системы Yatool;

- (TR3) автодополнение должно завершать работу не более чем за 0.5 секунд.

Приведенные выше требования были описаны в комментариях к задачам.
Как только требования были согласованы, можно было продолжить работу в заданном направлении.

#chapter("Реализация автодополнения ключевых слов")

Данный этап включает в себя реализацию автодополнения ключевых слов в модуле автодополнения YQL и интеграция модуля в приложение YDB CLI.
Критерием выполнения данного этапа является создание модуля автодопонения YQL, реализованный алгоритм возвращающий ключевые слова в качестве кандидатов на автодополнение, автодополнение ключевых слов в YDB CLI в интерактивном режиме.

В качестве основы автодополнения была выбрана библиотека antlr4-c3. 
Она принимает на вход текст и грамматику языка в формате ANTLR4, а возвращает список лексем, которые ожидает парсер в заданной позиции.

Конечно, необходимо было скрыть библиотеку за интерфейсом движка автодополнения.

#figure([
  ```cpp
  struct TCompletionInput {
    TStringBuf Text;
    size_t CursorPosition = Text.length();
  };

  enum class ECandidateKind {
    Keyword,
    ...
  };

  struct TCandidate {
    ECandidateKind Kind;
    TString Content;
    ...
  };

  struct TCompletion {
    ...
    TVector<TCandidate> Candidates;
  };

  class ISqlCompletionEngine {
  public:
    ...
    virtual TCompletion Complete(TCompletionInput input) = 0;
    ...
  };
  ```
], caption: [Интерфейс движка автодополнения])

Для выдачи ключевых слов достаточно было удалить лексемы, соответствующие, например, числам и именам. Кроме того, antlr4-c3 выдает сразу последовательности лексем, если последовательность однозначна.

#figure([
  ```cpp
  TLocalSyntaxContext::TKeywords SiftedKeywords(
    const TC3Candidates& candidates) {
    const auto& vocabulary = Grammar->GetVocabulary();
    const auto& keywordTokens = Grammar->GetKeywordTokens();

    TLocalSyntaxContext::TKeywords keywords;
    for (const auto& token : candidates.Tokens) {
      if (keywordTokens.contains(token.Number)) {
        auto display = Display(vocabulary, token.Number);
        auto& following = keywords[std::move(display)];
        for (auto next : token.Following) {
          following.emplace_back(Display(vocabulary, next));
        }
      }
    }
    return keywords;
  }
  ```
], caption: [Просеивание ключевых слов])

Также необходимо было решить следующую проблему. 
Дело в том, что в SQL ключевые слова не являются полностью зарезервированными, из-за чего могут являться корректными именами, что отражено в грамматике и из-за чего antlr4-c3 возвращал почти все ключевые слова в каждой позциции, где ожидалось имя. 
Проблема была решена правильной настройкой antlr4-c3 -- игнорированием некоторых правил вывода.

#figure([
  ```cpp
  const TVector<TRuleId> KeywordRules = {
    RULE(Keyword),
    RULE(Keyword_expr_uncompat),
    RULE(Keyword_table_uncompat),
    RULE(Keyword_select_uncompat),
    RULE(Keyword_alter_uncompat),
    RULE(Keyword_in_uncompat),
    RULE(Keyword_window_uncompat),
    RULE(Keyword_hint_uncompat),
    RULE(Keyword_as_compat),
    RULE(Keyword_compat),
  };
  ```
], caption: [Правила вывода, подлежащие игнорированию])

Далее модуль автодополнения был внедрен в YDB CLI. В качестве цвета для ключевых слов был выбран синий (в соответствии с темой Monaco).
Сделать это было не очень сложно, ведь для реализации интерактивного решения в клиентском приложении используется библиотека Replxx, предоставляющая интерфейс для интеграции автодополнения и подсветки.

#figure([
  ```cpp
  TCompletions Apply(
    const std::string& prefix, int& /* contextLen */) override {
    auto completion = Engine->Complete({
      .Text = prefix,
      .CursorPosition = prefix.length(),
    });

    replxx::Replxx::completions_t entries;
    for (auto& candidate : completion.Candidates) {
      const auto back = candidate.Content.back();
      if (
        !IsLeftPunct(back) && back != '<' 
        || IsQuotation(back)) {
        candidate.Content += ' ';
      }

      entries.emplace_back(
        std::move(candidate.Content),
        ReplxxColorOf(candidate.Kind));
    }
    return entries;
  }
  ```
], caption: [Использование API Replxx])

Весь код доступен для чтения в репозитории проекта YDB на GitHub.

#chapter("Проектирование интерфейса 
источника имен объектов БД")

Автодополнение ключевых слов уже заметно повысило пользовательский опыт разработки запросов на YQL в YDB CLI, но этого не достаточно для удобной работы.
В любой удобной IDE реализованы подсказки также и имен различных сущностей, что очень ценят программисты, так как имена могут быть длинные, из-за чего их долго набирать, причем высок риск появления опечаток, а еще такие имена часто забываются.

Автодополнение имен является непростой задачей, так как требует также реализацию методов семантического анализа запроса с целью определния типа имени, требуемого в заданной позиции. Кроме того, необходим некоторый реестр имен.

Этот этап был посвящен проектированию интерфейса источника имен объектов БД для их получения в модуле автодополнения. Критерием выполнения была готовность спроектированного программного интерфейса источника имен объектов БД для модуля автодополнения YQL, разработана in-memory реализация, служащая заглушкой.

К интерфейсу источника имен были выдвинуты следующие требования:

- Источник имен должен допускать реализацию через вызов удаленной процедуры;

- Источник имен должен поддерживать фильтрацию имен по заданным ограничениям;

- Источник имен должен поддерживать фильтрацию имен по содержимому;

- Источник имен должен ограничивать размер списка имен;

- Источник имен должен выдавать отсортированные по релевантности имена.

#figure([
  ```cpp
  ...
  using TGenericName = std::variant<
    TKeyword,
    TPragmaName,
    TTypeName,
    ...>;

  struct TNameRequest {
    TVector<TString> Keywords;
    struct {
      TMaybe<TPragmaName::TConstraints> Pragma;
      TMaybe<TTypeName::TConstraints> Type;
      ...
    } Constraints;
    TString Prefix = "";
    size_t Limit = 128;
    ...
  }

  struct TNameResponse {
    TVector<TGenericName> RankedNames;
  };

  class INameService {
  public:
    ...
    virtual TFuture<TNameResponse> Lookup(
      TNameRequest request) = 0;
    ...
  };
  ...
  ```
], caption: [Интерфейс сервиса имен])

Для модульного тестирования данного интерфейса также была разработана заглушка со списком имен, представленном прямо в коде.

Весь код доступен для чтения в репозитории проекта YDB на GitHub.

#chapter("Реализация автодополнения имен объектов БД")

В рамках данного этапа необходимо было подготовить пригодную для использования в YDB CLI реализацию сервиса имен, а также добавить элементы семантического анализа для определения типа имен и их последующей выдачи в списке кандидатов.

Более формально -- реализация автодополнения имен объектов БД в модуле автодополнения. Критерий выполнения: разработан алгоритм возвращающий имена объектов БД в качестве кандидатов на автодополнение, автодополнение имен наиболее важных типов объектов БД, установленных на этапе анализа требований, в YDB CLI в интерактивном режиме. 

Представитель команды YQL очень помог мне с данной задачей, предоставив данные о частоте использования конструкций языка, а также списки имен функций, типов, прагм и прочего в файлах формата JSON.

Была реализована загрузка частот из JSON в следующую структуру.

#figure([
  ```cpp
  struct TFrequencyData {
    THashMap<TString, size_t> Keywords;
    THashMap<TString, size_t> Pragmas;
    THashMap<TString, size_t> Types;
    THashMap<TString, size_t> Functions;
    THashMap<TString, size_t> Hints;
  };
  ```
], caption: [Структура данных с частотами имен])

Далее с ее помощью реализован интерфейс стратегии ранжирования.

#figure([
  ```cpp
  class IRanking {
  public:
    ...
    virtual void CropToSortedPrefix(
      TVector<TGenericName>& names, size_t limit) = 0;
    ...
  };
  ```
], caption: [Интерфейс стратегии ранжирования])

Ранжирование не только сортирует список, но и оставляет только первые k элементов. Это сделано, чтобы воспользоваться преимуществами алгоритма `std::parial_sort`.

#figure([
  ```cpp
  ...
  void CropToSortedPrefix(TVector<TGenericName>& names, size_t limit) override {
    limit = std::min(limit, names.size());
    ...
    ::PartialSort(
      std::begin(rows), std::begin(rows) + limit, std::end(rows),
      [this](const TRow& lhs, const TRow& rhs) {
        const size_t lhs_weight = ReversedWeight(lhs.Weight);
        const auto lhs_content = ContentView(lhs.Name);

        const size_t rhs_weight = ReversedWeight(rhs.Weight);
        const auto rhs_content = ContentView(rhs.Name);

        return std::tie(lhs_weight, lhs_content) <
             std::tie(rhs_weight, rhs_content);
    });
    ...
    names.crop(limit);
    ...
  }
  ...
  ```
], caption: [Реализация алгоритма ранжирования])

Сами же имена были загружены из JSON в следующую структуру данных.

#figure([
  ```cpp
  struct NameSet {
    TVector<TString> Pragmas;
    TVector<TString> Types;
    TVector<TString> Functions;
    THashMap<EStatementKind, TVector<TString>> Hints;
  };
  ```
], caption: [Структура данных с множеством имен])

Далее необходимо было научиться распознавать типы имен в запросе. Реализовать это было не очень сложно, ведь, грубо говоря, antlr4-c3 можно сконфигурировать так, чтобы он возвращал parser call stack при нахождении имени. 

#figure([
  ```cpp

  bool IsLikelyPragmaStack(const TParserCallStack& stack);
  bool IsLikelyTypeStack(const TParserCallStack& stack);
  bool IsLikelyFunctionStack(const TParserCallStack& stack);
  bool IsLikelyHintStack(const TParserCallStack& stack);
  ...
  bool IsLikelyFunctionStack(const TParserCallStack& stack) {
    return EndsWith({
      RULE(Unary_casual_subexpr), 
      RULE(Id_expr)
    }, stack) || EndsWith({
      RULE(Unary_casual_subexpr),
      RULE(Atom_expr),
      RULE(An_id_or_type)
    }, stack) || EndsWith({
      RULE(Atom_expr), 
      RULE(Id_or_type)
    }, stack);
  }
  ...
  ```
], caption: [Распознавание имени функции по parser call stack])

Достаточно интересным было распознавание имени пользовательской функции YQL. Дело в том, что оно состоит из пространства имен и непосредственно имени функции. Конечно, при набранном пространстве имен, движок должен предлагать только название функции.

#figure([
  ```cpp
  TMaybe<TLocalSyntaxContext::TFunction> FunctionMatch(
    const NSQLTranslation::TParsedTokenList& tokens, 
    const TC3Candidates& candidates) {
    if (!AnyOf(candidates.Rules, IsLikelyFunctionStack)) {
      return Nothing();
    }

    TLocalSyntaxContext::TFunction function;
    if (EndsWith(tokens, {"ID_PLAIN", "NAMESPACE"})) {
      function.Namespace = tokens[tokens.size() - 2].Content;
    } else if (EndsWith(tokens, {"ID_PLAIN", "NAMESPACE", ""})) {
      function.Namespace = tokens[tokens.size() - 3].Content;
    }
    return function;
  }
  ```
], caption: [Обработка имени функции])

#structural-element("Заключение")



#structural-element("Cписок использованных источников")

#bibliography(
  "bibliography.yml",
  title: none,
  full: true,
)
