#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Элементы.Картинка.Картинка = Элементы.БиблиотекаКартинокУКО_ПредупреждениеВажное.Картинка;
	Элементы.КопироватьИЗакрыть.Картинка = Элементы.БиблиотекаКартинокУКО_КопироватьВБуферОбмена.Картинка;
	
	КодЯзыкаПрограммирования = ОбъектОбработки().УКО_ОбщегоНазначения_КодЯзыкаПрограммирования();
	УКО_ФормыКлиентСервер_Заголовок(ЭтаФорма, НСтр("ru = 'Конструктор строки сохранения данных из отладки'; en = 'Designer lines store data from debug'"));
	
	ТипСписокВыбора = Элементы.Тип.СписокВыбора;
	ТипСписокВыбора.Добавить("Перечисление.УКО_ЭлементыДанных.Запрос", НСтр("ru = 'Запрос'; en = 'Query'"));
	ТипСписокВыбора.Добавить("Перечисление.УКО_ЭлементыДанных.СхемаКомпоновкиДанных", НСтр("ru = 'Схема компоновки данных'; en = 'Data composition schema'"));
	
	ИмяСхемы = НСтр("ru = 'СхемаКомпоновкиДанных'; en = 'DataCompositionSchema'");
	ИмяСхемыСписокВыбора = Элементы.ИмяСхемы.СписокВыбора;
	ИмяСхемыСписокВыбора.Добавить(ИмяСхемы);
	
	ИмяНастроек = НСтр("ru = 'НастройкиКомпоновкиДанных'; en = 'DataCompositionSettings'");
	ИмяНастроекСписокВыбора = Элементы.ИмяНастроек.СписокВыбора;
	ИмяНастроекСписокВыбора.Добавить(ИмяНастроек);
	
	ИмяВнешнихНаборовДанных = НСтр("ru = 'ВнешниеНаборыДанных'; en = 'ExternalDataSets'");
	ИмяВнешнихНаборовДанныхСписокВыбора = Элементы.ИмяВнешнихНаборовДанных.СписокВыбора;
	ИмяВнешнихНаборовДанныхСписокВыбора.Добавить(ИмяВнешнихНаборовДанных);
	
	Тип = "Перечисление.УКО_ЭлементыДанных.Запрос";
	
	СохранятьВСписокВыбора = Элементы.СохранятьВ.СписокВыбора;
	СохранятьВСписокВыбора.Добавить("Перечисление.УКО_ТипыХраненияДанных.Файл", НСтр("ru = 'Файл'; en = 'File'"));
	СохранятьВСписокВыбора.Добавить("Перечисление.УКО_ТипыХраненияДанных.Настройка", НСтр("ru = 'Настройка'; en = 'Settings'"));
	
	СохранятьВ = "Перечисление.УКО_ТипыХраненияДанных.Настройка";
	
	ИмяОбъектаЗапросСписокВыбора = Элементы.ИмяОбъектаЗапрос.СписокВыбора;
	ИмяОбъектаЗапросСписокВыбора.Добавить(НСтр("ru = 'Запрос'; en = 'Query'", КодЯзыкаПрограммирования));
	ИмяОбъектаЗапросСписокВыбора.Добавить(НСтр("ru = 'Список'; en = 'List'", КодЯзыкаПрограммирования));
	ИмяОбъектаЗапросСписокВыбора.Добавить(НСтр("ru = 'ПостроительЗапроса'; en = 'QueryBuilder'", КодЯзыкаПрограммирования));
	ИмяОбъектаЗапросСписокВыбора.Добавить(НСтр("ru = 'ПостроительОтчета'; en = 'ReportBuilder'", КодЯзыкаПрограммирования));
	ИмяОбъектаЗапросСписокВыбора.Добавить(НСтр("ru = 'МакетКомпоновкиДанных'; en = 'DataCompositionTemplate'", КодЯзыкаПрограммирования));
	
	ИмяОбъектаЗапрос = ИмяОбъектаЗапросСписокВыбора[0].Значение;
	
	Элементы.ГруппаПояснениеВключенаЗащитаОтОпасныхДействий.Видимость = УКО_ОбщегоНазначенияКлиентСервер_РежимЗапускаВнешняяОбработка()
						И ПользователиИнформационнойБазы.ТекущийПользователь().ЗащитаОтОпасныхДействий.ПредупреждатьОбОпасныхДействиях;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбновитьЭлементыФормы();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ТипПриИзменении(Элемент)
	
	ОбновитьЭлементыФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура СохранятьВПриИзменении(Элемент)
	
	ОбновитьЭлементыФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура ИмяОбъектаЗапросПриИзменении(Элемент)
	
	ОбновитьЭлементыФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура ПутьПриИзменении(Элемент)
	
	ОбновитьЭлементыФормы();

КонецПроцедуры

&НаКлиенте
Процедура ИмяПриИзменении(Элемент)
	
	ОбновитьЭлементыФормы();

КонецПроцедуры

&НаКлиенте
Процедура ПутьНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ДиалогВыборКаталога = Новый ДиалогВыбораФайла (РежимДиалогаВыбораФайла.ВыборКаталога);
	ДиалогВыборКаталога.Каталог = Путь;
	ДиалогВыборКаталога.Заголовок = НСтр("ru = 'Выбор каталога'; en = 'Select catalog'");
	
	ДиалогВыборКаталога.Показать(Новый ОписаниеОповещения("ВыборКаталогаЗакончен", ЭтотОбъект));
	
КонецПроцедуры

&НаКлиенте
Процедура ИмяСхемыПриИзменении(Элемент)
	
	ОбновитьЭлементыФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура ИмяНастроекПриИзменении(Элемент)
	
	ОбновитьЭлементыФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура ИмяВнешнихНаборовДанныхПриИзменении(Элемент)
	
	ОбновитьЭлементыФормы();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КопироватьИЗакрыть(Команда)
	
	УКО_БуферОбменаКлиент_Копировать(Результат);
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбновитьЭлементыФормы()
	
	СохранятьВФайл = (СохранятьВ = "Перечисление.УКО_ТипыХраненияДанных.Файл");
	СохранятьВНастройки = (СохранятьВ = "Перечисление.УКО_ТипыХраненияДанных.Настройка");
	ЭтоТипЗапрос = (Тип = "Перечисление.УКО_ЭлементыДанных.Запрос");
	ЭтоТипСхемаКомпоновкиДанных = (Тип = "Перечисление.УКО_ЭлементыДанных.СхемаКомпоновкиДанных");
	
	Элементы.Путь.Видимость = СохранятьВФайл; 
	Элементы.Имя.ПодсказкаВвода = СтрШаблон(НСтр("ru = 'По умолчанию: %1'; en = 'Default: %1'"), УКО_ОтложеннаяОтладкаКлиентСервер_ИмяДанных(Тип));
	Элементы.ГруппаЗапрос.Видимость = ЭтоТипЗапрос;
	Элементы.ГруппаСхемаКомпоновкиДанных.Видимость = ЭтоТипСхемаКомпоновкиДанных;
	
	// Генерируем строку для отладки
	ПараметрыФункции = Новый Массив;
	
	Если ЭтоТипЗапрос Тогда
		ИмяОсновногоОбъекта = ИмяОбъектаЗапрос;
	ИначеЕсли ЭтоТипСхемаКомпоновкиДанных Тогда
		ИмяОсновногоОбъекта = ИмяСхемы;
	КонецЕсли;
	ПараметрыФункции.Добавить(ИмяОбъектаЗапрос);
	
	Если СохранятьВФайл Тогда
		ПараметрыФункции.Добавить(УКО_КодНаВстроенномЯзыкеВызовСервера_Значение(Путь));
	КонецЕсли;
		
	Если ЭтоТипСхемаКомпоновкиДанных Тогда
		ПараметрыФункции.Добавить(ИмяНастроек);
		ПараметрыФункции.Добавить(ИмяВнешнихНаборовДанных);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Имя) Тогда
		ПараметрыФункции.Добавить(УКО_КодНаВстроенномЯзыкеВызовСервера_Значение(Имя));
	КонецЕсли;
	
	Если УКО_ОбщегоНазначенияКлиентСервер_РежимЗапускаВнешняяОбработка() Тогда
		ИмяФайлаОбработки = ИмяФайлаОбработки();
	Иначе
		ИмяФайлаОбработки = Неопределено
	КонецЕсли;
	
	Префикс = УКО_ОтложеннаяОтладкаКлиентСервер_Префикс(Тип, ИмяФайлаОбработки);
	ИмяФункции = УКО_ОтложеннаяОтладкаКлиентСервер_ИмяФункции(Тип, СохранятьВ);
	
	Результат = СтрШаблон("%1.%2(%3)", Префикс, ИмяФункции, СтрСоединить(ПараметрыФункции, ","));
	Элементы.Результат.Подсказка = УКО_ОтложеннаяОтладкаКлиентСервер_ПодсказкаОписаниеВызова(Тип, СохранятьВ); 
	
КонецПроцедуры

&НаСервере
Функция ИмяФайлаОбработки()
	
	Возврат РеквизитФормыВЗначение("Объект").ИспользуемоеИмяФайла;
	
КонецФункции

&НаКлиенте
Процедура ВыборКаталогаЗакончен(ВыбранныеКаталоги, ДополнительныеПараметры) Экспорт 
	
	Если ЗначениеЗаполнено(ВыбранныеКаталоги) Тогда
		Путь = ВыбранныеКаталоги[0];
		ОбновитьЭлементыФормы();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти


&НаСервере
Функция ОбъектОбработки()
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции
&НаКлиенте
// Копирует текст в буфер обмена (Через HTML)
//
// Параметры:
//	Текст - Строка - Текст
Процедура УКО_БуферОбменаКлиент_Копировать(Текст) Экспорт
	
    ОбъектHTML = Новый COMОбъект("htmlfile");
    ОбъектHTML.ParentWindow.ClipboardData.Setdata("Text", Текст);
	
КонецПроцедуры
&НаКлиентеНаСервереБезКонтекста
// Возвращает по объекту метаданных доступны ли для него предопределенные элементы
//
// Параметры:
//   ИмяОбъекта - Строка - Имя объекта метаданных
//
// Возвращаемое значение:
//   Булево - Истина, доступны предопределенные элементы
//
Функция УКО_МетаданныеКлиентСервер_ОбъектCПредопределенными(ИмяОбъекта) Экспорт
	
	Возврат ИмяОбъекта = "Справочник" 
				ИЛИ ИмяОбъекта = "Catalog"
				ИЛИ УКО_МетаданныеКлиентСервер_ЭтоОбъектПеречисление(ИмяОбъекта)
				ИЛИ ИмяОбъекта = "ПланВидовХарактеристик"
				ИЛИ ИмяОбъекта = "ChartOfCharacteristicTypes"
				ИЛИ ИмяОбъекта = "ПланСчетов"
				ИЛИ ИмяОбъекта = "ChartOfAccounts"
				ИЛИ ИмяОбъекта = "ПланВидовРасчета"
				ИЛИ ИмяОбъекта = "ChartOfCalculationTypes";

КонецФункции
&НаСервере
// Получает код на встроенном языке для значения
//
// Параметры:
//  Значение  - Произвольный - Произвольное значений
//
// Возвращаемое значение:
//   Строка - Код на встроенном языке для значения
//
Функция УКО_КодНаВстроенномЯзыкеВызовСервера_Значение(Значение) Экспорт
	
	Возврат ОбъектОбработки().УКО_КодНаВстроенномЯзыке_Значение(Значение);
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает строку имя функции
//
// Параметры:
//	Тип - Перечисление.УКО_ЭлементыДанных - Тип элементов
//	ТипХранения - Перечисление.УКО_ТипыХраненияДанных - Тип хранения данных
//
// Возвращаемое значение:
//   Строка - Имя функции
//
Функция УКО_ОтложеннаяОтладкаКлиентСервер_ИмяФункции(Тип, ТипХранения) Экспорт
	
	Результат = "Сохранить";
	Если Тип = "Перечисление.УКО_ЭлементыДанных.СхемаКомпоновкиДанных" Тогда
		Результат = Результат + "СКД";
	КонецЕсли;
	
	Если ТипХранения = "Перечисление.УКО_ТипыХраненияДанных.Файл" Тогда
		Результат = Результат + "ВФайл";
	ИначеЕсли ТипХранения = "Перечисление.УКО_ТипыХраненияДанных.Настройка" Тогда
		Результат = Результат + "ВНастройки";
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Определяет этот объект перечисление
//
// Параметры:
//   ИмяОбъекта - Строка - Объект метаданных
//
// Возвращаемое значение:
//   Булево - Истина, это имя перечисление
//
Функция УКО_МетаданныеКлиентСервер_ЭтоОбъектПеречисление(ИмяОбъекта) Экспорт
	
	Возврат ИмяОбъекта = "Перечисление" 
				ИЛИ ИмяОбъекта = "Enum";

КонецФункции
&НаКлиентеНаСервереБезКонтекста

Функция УКО_СтрокиКлиентСервер_НаборСимволовЦифры()
	
	Возврат "0123456789";
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает код английского языка
// Возвращаемое значение:
//   Строка	- Код английского языка
//
Функция УКО_ОбщегоНазначенияКлиентСервер_КодЯзыкаАнглийский() Экспорт
	Возврат "en";
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает код русского языка
// Возвращаемое значение:
//   Строка	- Код русского языка
//
Функция УКО_ОбщегоНазначенияКлиентСервер_КодЯзыкаРусский() Экспорт
	Возврат "ru";
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Проверяет строка многострочная?
//
// Параметры:
//   Строка - Строка - Проверяемая строка
//
// Возвращаемое значение:
//   Булево - Истина, если строка многострочная
//
Функция УКО_СтрокиКлиентСервер_МногострочнаяСтрока(Строка) Экспорт
	
	Возврат Булево(СтрНайти(Строка, Символы.ПС));
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Чтение идентификатора строки
//
// Параметры:
//   Строка - Строка - Разбираемая строка
//   НачальныйИндекс - Число - Начальный индекс
//   СмещатьИндекс - Булево - Смещать индекс (по умолчанию: Истина)
//
// Возвращаемое значение:
//   Строка	- Прочитанный идентификатор
//
Функция УКО_СтрокиКлиентСервер_РазборПрочитатьИдентификатор(Строка, НачальныйИндекс = 1, СмещатьИндекс = Истина) Экспорт
	
	НаборСимволовИдентификатор = УКО_СтрокиКлиентСервер_НаборСимволовРусскиеЛатинскиеБуквы() + УКО_СтрокиКлиентСервер_НаборСимволовЦифры() + "_";
	НаборСимволовИдентификаторПервыйСимвол = УКО_СтрокиКлиентСервер_НаборСимволовРусскиеЛатинскиеБуквы() + "_";
	
	Для Индекс = НачальныйИндекс По СтрДлина(Строка) Цикл 
		
		Символ = Сред(Строка, Индекс, 1);
		Если Индекс = НачальныйИндекс Тогда
			НаборСимволов = НаборСимволовИдентификаторПервыйСимвол;
		Иначе
			НаборСимволов = НаборСимволовИдентификатор;
		КонецЕсли;
		
		Если Не СтрНайти(НаборСимволов, Символ) Тогда 
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
	Результат = Сред(Строка, НачальныйИндекс, Индекс - НачальныйИндекс); 
	
	Если СмещатьИндекс Тогда
		НачальныйИндекс = Индекс;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает набор символов букв русского и английского языков
// Возвращаемое значение:
//   Строка - Набор символов букв
Функция УКО_СтрокиКлиентСервер_НаборСимволовРусскиеЛатинскиеБуквы()
	
	НаборСимволовРусскиеБуквы = "ЙЦУКЕ" + Символ(1025) + "НГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ"; //1025 - Код символа буквы ежик, елка
	НаборСимволовРусскиеБуквы = НаборСимволовРусскиеБуквы + НРег(НаборСимволовРусскиеБуквы);
	
	Возврат НаборСимволовРусскиеБуквы + УКО_СтрокиКлиентСервер_НаборСимволовЛатинскиеБуквы();
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста

Функция УКО_СтрокиКлиентСервер_НаборСимволовЛатинскиеБуквы()
	
	НаборСимволов = "QWERTYUIOPASDFGHJKLZXCVBNM";
	Возврат НаборСимволов + НРег(НаборСимволов);
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает имя расширения
// Возвращаемое значение:
//   Строка	- Имя расширения
Функция УКО_ОбщегоНазначенияКлиентСервер_ИмяРасширения() Экспорт 
	
	Возврат НСтр("ru = 'Управляемая консоль отчетов'; en = 'Managed reporting console'");
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает Число в виде строки
//
// Параметры:
//   Число - Число - Преобразуемое число
//
// Возвращаемое значение:
//   Строка - Число в виде строки
//
Функция УКО_СтрокиКлиентСервер_ЧислоВСтроку(Число) Экспорт
	
	Возврат Формат(Число, "ЧН=; ЧГ=");
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Определяет, это режим запуска программы
//
// Возвращаемое значение:
//   Булево	- Истина, Режим запуска внешняя обработка
//
Функция УКО_ОбщегоНазначенияКлиентСервер_РежимЗапускаВнешняяОбработка() Экспорт
	
	Возврат Истина;
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает строку имени элемента данных для запроса из отладки
//
// Параметры:
//	Тип - Перечисление.УКО_ЭлементыДанных - Тип элементов
//
// Возвращаемое значение:
//   Строку - Имя данных используемое при загрузке данных из отладки
//
Функция УКО_ОтложеннаяОтладкаКлиентСервер_ИмяДанных(Тип) Экспорт
	
	Если Тип = "Перечисление.УКО_ЭлементыДанных.Запрос" Тогда
		
		Результат = НСтр("ru = 'Запрос (из отладки)'; en = 'Query (from debug)'");
		
	ИначеЕсли Тип = "Перечисление.УКО_ЭлементыДанных.СхемаКомпоновкиДанных" Тогда
		
		Результат = НСтр("ru = 'Схема компоновки данных (из отладки)'; en = 'Data composition schema (from debug)'");
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает строку подсказку к описанию вызова
//
// Параметры:
//	Тип - Перечисление.УКО_ЭлементыДанных - Тип элементов
//	ТипХранения - Перечисление.УКО_ТипыХраненияДанных - Тип хранения данных
//
// Возвращаемое значение:
//   Строка - Подсказка к описанию вызова
//
Функция УКО_ОтложеннаяОтладкаКлиентСервер_ПодсказкаОписаниеВызова(Тип, ТипХранения) Экспорт
	
	Строки = Новый Массив;
	Строки.Добавить(УКО_ОтложеннаяОтладкаКлиентСервер_ИмяФункции(Тип, ТипХранения));
	Строки.Добавить("");
	Строки.Добавить(НСтр("ru = 'Параметры:'; en = 'Parametrs:'"));
	
	Параметры = Новый Массив;
	Если Тип = "Перечисление.УКО_ЭлементыДанных.Запрос" Тогда
		
		Параметры.Добавить(НСтр("ru = 'Объект  - Запрос, ПостроительЗапроса, ПостроительОтчета, ДинамическийСписок, МакетКомпоновкиДанных - Объект';
							|en = 'Object - Query, QueryBuilder, ReportBuilder, DynamicList, DataCompositionTemplate - Object'"));
		
	ИначеЕсли Тип = "Перечисление.УКО_ЭлементыДанных.СхемаКомпоновкиДанных" Тогда
		
		Параметры.Добавить(НСтр("ru = 'Схема  - СхемаКомпоновкиДанных - Схема компоновки данных';
								|en = 'Schema  - DataCompositionSchema - Data composition schema'"));
		
	КонецЕсли;
	
	Если ТипХранения = "Перечисление.УКО_ТипыХраненияДанных.Файл" Тогда
		Параметры.Добавить(НСтр("ru = 'Путь  - Строка - Путь'; en = 'Path - String - Path'"));
	КонецЕсли;
	
	Если Тип = "Перечисление.УКО_ЭлементыДанных.СхемаКомпоновкиДанных" Тогда
		Параметры.Добавить(НСтр("ru = 'Настройки - НастройкиКомпоновкиДанных - Настройки компоновки данных (необязательный)'; en = 'Settings - DataCompositionSettings - Data composition settings (optional)'"));
		Параметры.Добавить(НСтр("ru = 'ВнешниеНаборыДанных - Структура - Внешние наборы данных (необязательный)'; en = 'ExternalDatasets - Structure - External datasets (optional)'"));
	КонецЕсли;
	
	Если ТипХранения = "Перечисление.УКО_ТипыХраненияДанных.Файл" Тогда
		Параметры.Добавить(НСтр("ru = 'ИмяБезРасширения - Строка - Имя файла без расширения (необязательный)'; en = 'BaseName - String - Filename without extension (optional)'"));
	ИначеЕсли ТипХранения = "Перечисление.УКО_ТипыХраненияДанных.Настройка" Тогда
		Параметры.Добавить(НСтр("ru = 'ИмяНастройки - Строка - Имя настройки (необязательный)'; en = 'SettingsName - String - Settings name (optional)'"));
	КонецЕсли;
	
	Для Индекс = 0 По Параметры.ВГраница() Цикл 
		Параметры[Индекс] = "  " + Параметры[Индекс];
	КонецЦикла;
	Строки.Добавить(СтрСоединить(Параметры, Символы.ПС));
	
	Строки.Добавить("");
	Строки.Добавить(НСтр("ru = 'Возвращаемое значение:'; en = 'Return value:'"));
	
	ПояснениеЗначенияВозврата = НСтр("ru = 'Строка - Информация о результате'; en = 'String - Result information'");
	Строки.Добавить(УКО_СтрокиКлиентСервер_ДобавитьТабВМногострочныйТекст(ПояснениеЗначенияВозврата));
	
	Возврат СтрСоединить(Строки, Символы.ПС);
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Добавляет табуляцию в многострочный текст
//
// Параметры:
//   Текст - Строка - Текст
//   ДобавлятьВПервуюСтрока - Булево - Добавлять в первую строку
//   Количество - Число - Количество добавляемых табуляций
//
// Возвращаемое значение:
//   Строка - Текст с добавленной табуляцией
//
Функция УКО_СтрокиКлиентСервер_ДобавитьТабВМногострочныйТекст(Текст, ДобавлятьВПервуюСтрока = Истина, Количество = 1) Экспорт
	
	ВставляемыеСимволы = "";
	Для Счетчик = 1 По Количество Цикл 
		ВставляемыеСимволы = ВставляемыеСимволы + Символы.Таб;
	КонецЦикла;
	
	Результат = СтрЗаменить(Текст, Символы.ПС, Символы.ПС + ВставляемыеСимволы);
	Если ДобавлятьВПервуюСтрока Тогда
		Результат = ВставляемыеСимволы + Результат;
	КонецЕсли;

	Возврат Результат;
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает строку префикс вызова отладки
//
// Параметры:
//	Тип - Перечисление.УКО_ЭлементыДанных - Тип элементов
//	ИмяФайлаОбработки - Строка - Имя файла обработки
//
// Возвращаемое значение:
//   Строка - Префикс вызова отладки
//
Функция УКО_ОтложеннаяОтладкаКлиентСервер_Префикс(Тип, ИмяФайлаОбработки) Экспорт
	
	ЭтоВнешняяОбработка = УКО_ОбщегоНазначенияКлиентСервер_РежимЗапускаВнешняяОбработка();
	Если ЭтоВнешняяОбработка Тогда
		Результат = СтрШаблон("ВнешниеОбработки.Создать(""%1"", Ложь)", ИмяФайлаОбработки);
	Иначе 
		
		Если Тип = "Перечисление.УКО_ЭлементыДанных.Запрос" Тогда
			Результат = "УКО_Запрос";
		ИначеЕсли Тип = "Перечисление.УКО_ЭлементыДанных.СхемаКомпоновкиДанных" Тогда
			Результат = "УКО_СКД";
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Обновляет заголовок формы
//
// Параметры:
//  Форма - Форма - Форма
//  Заголовок - Строка - Заголовок формы
//  Дополнение - Булево - Дополнять заголовок названием расширения
//
Процедура УКО_ФормыКлиентСервер_Заголовок(Форма, Заголовок, Дополнение = Ложь) Экспорт
	
	НовыйЗаголовок = Заголовок;
	
	Если Дополнение Тогда
		НовыйЗаголовок = НовыйЗаголовок + " : " + УКО_ОбщегоНазначенияКлиентСервер_ИмяРасширения();
	КонецЕсли;
	
	Форма.Заголовок = НовыйЗаголовок;
	
КонецПроцедуры
