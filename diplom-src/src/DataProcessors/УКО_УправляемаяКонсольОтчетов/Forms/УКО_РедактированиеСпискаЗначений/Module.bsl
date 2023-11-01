#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	
	// Получение переданных данных
	ТекстЗаголовка = Параметры.Заголовок;
	ОписаниеТипов = Параметры.ОписаниеТипов;
	
	Если Параметры.Свойство("Значение") Тогда
		
		// Заполнение списка
		Для Каждого ЭлементСписка Из Параметры.Значение Цикл
			НоваяСтрока = Список.Добавить();
			НоваяСтрока.Значение = ЭлементСписка.Значение;
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбновитьЗаголовок();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	НайденныеСтроки = Список.НайтиСтроки(Новый Структура("Значение", ВыбранноеЗначение));
	
	Если НайденныеСтроки.Количество() = 0 Тогда
		
		НоваяСтрока = Список.Добавить();
		НоваяСтрока.Значение = ВыбранноеЗначение;
		
		ТекстОповещения = СтрШаблон(НСтр("ru = 'В список добавлено: %1'; en = 'Added to list: %1'"), ВыбранноеЗначение);
		ПоказатьОповещениеПользователя(УКО_ОбщегоНазначенияКлиентСервер_ИмяРасширения(),,ТекстОповещения);
		
		ОбновитьЗаголовок();
		
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПриИзменении(Элемент)
	
	Модифицированность = Истина;
	ОбновитьЗаголовок();
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	ТекущиеДанные = Элемент.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	УКО_ФормыКлиент_АктивизацияСтрокиЗначенияПараметраВФорме(Элементы.СписокЗначение, ТекущиеДанные.Значение, ОписаниеТипов, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	Если НоваяСтрока Тогда
		УКО_ФормыКлиент_АктивизацияСтрокиЗначенияПараметраВФорме(Элементы.Список.ТекущийЭлемент, Элементы.Список.ТекущиеДанные.Значение, ОписаниеТипов, Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	ОбновитьЗаголовок();
	
КонецПроцедуры

&НаКлиенте
Процедура СписокЗначениеОчистка(Элемент, СтандартнаяОбработка)
	
	УКО_ФормыКлиент_ОчисткаЗначенияПараметраВФорме(Элемент, СтандартнаяОбработка);
	УКО_ФормыКлиент_АктивизацияСтрокиЗначенияПараметраВФорме(Элемент, Неопределено, ОписаниеТипов, Истина);

КонецПроцедуры

&НаКлиенте
Процедура СписокЗначениеОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	УКО_ФормыКлиент_ОбработкаВыбораЗначенияПараметраВФорме(Элемент, ВыбранноеЗначение, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура СписокЗначениеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	ЗначениеПараметра = ТекущиеДанные.Значение;
	
	ДополнительныеПараметры = Новый Структура;
	ОписаниеОповещенияЗавершение = Новый ОписаниеОповещения("ВводЗначенияПараметраЗавершен", ЭтотОбъект, ДополнительныеПараметры);
	УКО_ФормыКлиент_ВводЗначенияПараметраВФорме(НСтр("ru = 'Элемент списка'; en = 'List item'"), Элемент, ЗначениеПараметра, ОписаниеТипов,
													СтандартнаяОбработка, ОписаниеОповещенияЗавершение, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура СписокЗначениеАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	
	УКО_ФормыКлиент_АвтоПодборЗначенияВФорме(Текст, ОписаниеТипов, ДанныеВыбора, СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СохранитьИЗакрыть(Команда)

	НовоеЗначение = Новый СписокЗначений;
	Для Каждого Строка Из Список Цикл
		НовоеЗначение.Добавить(Строка.Значение);
	КонецЦикла;
	
	Закрыть(НовоеЗначение);
	
КонецПроцедуры

&НаКлиенте
Процедура Подбор(Команда)
	
	Если ОписаниеТипов.СодержитТип(Тип("Тип")) Тогда
		
		ОписаниеОповещенияОЗавершении = Новый ОписаниеОповещения("ПодбораТипаБезОбработки", ЭтотОбъект, Новый Структура);
		
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("ЗакрыватьПриВыборе", Ложь);
		ДополнительныеПараметры.Вставить("Заголовок", НСтр("ru = 'подбор'; en = 'selection'"));
		
		УКО_ФормыКлиент_ОткрытьРедактированиеТипаЗначения(ЭтаФорма, "Перечисление.УКО_РежимРедактированияТипаЗначения.РедактированиеТипа",
																Неопределено, ОписаниеОповещенияОЗавершении, ДополнительныеПараметры);
		
	Иначе 
		
		КоличествоСсылочныхТипов = УКО_ОбщегоНазначенияКлиентСервер_КоличествоСсылочныхТипов(ОписаниеТипов);
		
		Если КоличествоСсылочныхТипов = 0 Тогда //Нет типов для подбора
			
			ПоказатьПредупреждение(, НСтр("ru = 'Для данного типа значений подбор недоступен'; en = 'Selection is not available for this type of value'"),,УКО_ОбщегоНазначенияКлиентСервер_ИмяРасширения());
			
		ИначеЕсли КоличествоСсылочныхТипов = 1 Тогда //один тип, сразу открываем форму подбора
			
			ОткрытьФормуДляПодбора (УКО_ОбщегоНазначенияКлиентСервер_ПервыйСсылочныйТипОписание(ОписаниеТипов));
			
		Иначе //несколько типов нужно выбрать
			
			ОписаниеОповещенияОЗавершении = Новый ОписаниеОповещения("ПослеВыбораТипаДляПодбора", ЭтотОбъект, Новый Структура);
			
			ДополнительныеПараметры = Новый Структура;
			ДополнительныеПараметры.Вставить("Заголовок", НСтр("ru = 'подбора'; en = 'selection'"));
			УКО_ФормыКлиент_ОткрытьРедактированиеТипаЗначения(ЭтаФорма, "Перечисление.УКО_РежимРедактированияТипаЗначения.ВыборТипа",
																	УКО_ОбщегоНазначенияКлиентСервер_СсылочныеТипы(ОписаниеТипов), ОписаниеОповещенияОЗавершении, ДополнительныеПараметры);
			
		КонецЕсли;
		
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбновитьЗаголовок()
	
	УКО_ФормыКлиентСервер_Заголовок(ЭтаФорма, СтрШаблон(НСтр("ru = 'Редактирование списка значений %1: (%2)'; en = 'Editing the list of %1 values: (%2)'"),
														ТекстЗаголовка, Список.Количество()));
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуДляПодбора (ОписаниеТипов)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ЗакрыватьПриВыборе", Ложь);
	ПараметрыФормы.Вставить("ВыборГруппИЭлементов", ИспользованиеГруппИЭлементов.ГруппыИЭлементы);

	ОткрытьФорму(ПолучитьИмяФормыВыбора(Новый (УКО_ОбщегоНазначенияКлиентСервер_ПервыйСсылочныйТип(ОписаниеТипов))),ПараметрыФормы, ЭтаФорма,,,,,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыбораТипаДляПодбора(Результат, ДополнительныеПараметры) Экспорт
	
	Если ЗначениеЗаполнено(Результат) Тогда
		ОткрытьФормуДляПодбора (Результат);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПодбораТипаБезОбработки(Результат, ДополнительныеПараметры) Экспорт
	
	НичегоНеДелаем = Истина;

КонецПроцедуры

&НаКлиенте
Процедура ВводЗначенияПараметраЗавершен(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Модифицированность = Истина;
	
	Если ДополнительныеПараметры.ВыборТипа Тогда
		
		ЭлементЗначениеПараметра = Элементы.Список.ТекущийЭлемент;
		ЭлементЗначениеПараметра.ОграничениеТипа = Результат;
		ЭлементЗначениеПараметра.ВыбиратьТип = Ложь;
		
		НовоеЗначение = Результат.ПривестиЗначение(Неопределено);
		
		УКО_ФормыКлиент_АктивизацияСтрокиЗначенияПараметраВФорме(Элементы.СписокЗначение, НовоеЗначение, ОписаниеТипов, Истина);
		
	Иначе
		
		НовоеЗначение = Результат;
		
	КонецЕсли;
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	ТекущиеДанные.Значение = НовоеЗначение;

КонецПроцедуры

&НаСервере
Функция ПолучитьИмяФормыВыбора(Ссылка)
    Возврат Ссылка.Метаданные().ПолноеИмя() + ".ФормаВыбора";
КонецФункции

#КонецОбласти


&НаСервере
Функция ОбъектОбработки()
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает имя расширения
// Возвращаемое значение:
//   Строка	- Имя расширения
Функция УКО_ОбщегоНазначенияКлиентСервер_ИмяРасширения() Экспорт 
	
	Возврат НСтр("ru = 'Управляемая консоль отчетов'; en = 'Managed reporting console'");
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает первый ссылочный тип описание содержащийся в описании типов
//
// Параметры:
//   ОписаниеТипов - ОписаниеТипов - Описание типов
//
// Возвращаемое значение:
//   ОписаниеТипов - Описание первый ссылочный тип
//
Функция УКО_ОбщегоНазначенияКлиентСервер_ПервыйСсылочныйТипОписание(ОписаниеТипов) Экспорт 
	
	Количество = 0;
	Для Каждого Тип Из ОписаниеТипов.Типы() Цикл 
		
		Если Не УКО_ОбщегоНазначенияКлиентСервер_ЭтоПростойТип(Тип) Тогда
			
			Типы = Новый Массив;
			Типы.Добавить(Тип);
			
			Возврат Новый ОписаниеТипов(Типы); 
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает первый ссылочный тип содержащийся в описании типов
//
// Параметры:
//   ОписаниеТипов - ОписаниеТипов - Описание типов
//
// Возвращаемое значение:
//   Тип - Первый ссылочный тип
//
Функция УКО_ОбщегоНазначенияКлиентСервер_ПервыйСсылочныйТип(ОписаниеТипов) Экспорт 
	
	Количество = 0;
	Для Каждого Тип Из ОписаниеТипов.Типы() Цикл 
		
		Если Не УКО_ОбщегоНазначенияКлиентСервер_ЭтоПростойТип(Тип) Тогда
			Возврат Тип; 
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции
&НаКлиенте
// Обработка активизации строки параметра в форме
//
// Параметры:
//	Элемент - ЭлементФормы - Элемент формы
//	Значение - Произвольный - Значение параметра
//	ОписаниеТипов - ОписаниеТипов - Описание типов параметра
//	РедактированиеСписка - Булево - Редактирование производится в списке
//
Процедура УКО_ФормыКлиент_АктивизацияСтрокиЗначенияПараметраВФорме(Элемент, Значение, Знач ОписаниеТипов, РедактированиеСписка = Ложь) Экспорт
	
	РедактированиеТекста = Ложь;
	КнопкаВыбора = Истина;
	КнопкаОчистки = Истина;
	КнопкаВыпадающегоСписка = Ложь;
	ОграничениеТипа = Ложь;
	Элемент.СписокВыбора.Очистить();
	
	ЗначениеСписок = (ТипЗнч(Значение) = Тип("СписокЗначений"));
	СложноеЗначение = (ТипЗнч(Значение) = Тип("Структура"));
	Если ТипЗнч(ОписаниеТипов) = Тип("ОписаниеТипов") Тогда
		СоставнойТип = ОписаниеТипов.Типы().Количество() <> 1;
	Иначе
		СоставнойТип = Ложь;
	КонецЕсли;
	
	ПроверяемоеЗначение = УКО_ФормыКлиент_ПроверяемоеЗначениеПараметра(Значение, ОписаниеТипов);
	
	Если СоставнойТип Тогда
		ВыбиратьТип = (ПроверяемоеЗначение = Неопределено) И НЕ ЗначениеСписок;
	Иначе
		ВыбиратьТип = Ложь;
	КонецЕсли;
	
	Если ТипЗнч(ПроверяемоеЗначение) = Тип("МоментВремени") Тогда
		
		Элемент.ОграничениеТипа = УКО_ОбщегоНазначенияКлиентСервер_ОписаниеТиповСтрока();
		
	ИначеЕсли ТипЗнч(ПроверяемоеЗначение) = Тип("Граница") Тогда
		
		Элемент.ОграничениеТипа = УКО_ОбщегоНазначенияКлиентСервер_ОписаниеТиповСтрока();
		
	ИначеЕсли ТипЗнч(ПроверяемоеЗначение) = Тип("Тип") Тогда
		
		Элемент.ОграничениеТипа = УКО_ОбщегоНазначенияКлиентСервер_ОписаниеТиповСтрока();
		КнопкаОчистки = Ложь;
		
	ИначеЕсли ТипЗнч(ПроверяемоеЗначение) = Тип("УникальныйИдентификатор") Тогда
		
		КнопкаОчистки = Ложь;
		ОграничениеТипа = Истина;
		
	ИначеЕсли ТипЗнч(ПроверяемоеЗначение) = Тип("Булево")
			ИЛИ ТипЗнч(ПроверяемоеЗначение) = Тип("ВидДвиженияНакопления")
			ИЛИ ТипЗнч(ПроверяемоеЗначение) = Тип("ВидДвиженияБухгалтерии")
			ИЛИ ТипЗнч(ПроверяемоеЗначение) = Тип("ВидСчета") Тогда
		
		КнопкаОчистки = Ложь;
		КнопкаВыбора = Ложь;
		КнопкаВыпадающегоСписка = Истина;
		ОграничениеТипа = Истина;
		
	ИначеЕсли ТипЗнч(ПроверяемоеЗначение) = Тип("Строка")
			ИЛИ ТипЗнч(ПроверяемоеЗначение) = Тип("Число") Тогда
		
		РедактированиеТекста = Истина;
		ОграничениеТипа = Истина;
		КнопкаВыбора = Ложь;
		КнопкаВыпадающегоСписка = Ложь;
		
	ИначеЕсли ТипЗнч(ПроверяемоеЗначение) = Тип("Дата") Тогда
		
		ОграничениеТипа = Истина;
		РедактированиеТекста = Истина;
		КнопкаВыпадающегоСписка = Истина;
		
		Если Не ЗначениеСписок Тогда
			Элемент.СписокВыбора.Добавить(Новый Структура("Тип", "ТекущаяДата"), СтрШаблон(НСтр("ru = 'Текущая дата, время (%1 ..)'; en = 'Current date, time (%1 ..)'"), Формат(ТекущаяДата(), "ДЛФ=D")));
		КонецЕсли;
		
	ИначеЕсли СложноеЗначение Тогда
		
		КнопкаОчистки = Ложь;
		
	Иначе
		
		ОграничениеТипа = Истина;
		РедактированиеТекста = Истина;
		КнопкаВыпадающегоСписка = Не ВыбиратьТип;
		
	КонецЕсли;
	
	Если ВыбиратьТип И ПроверяемоеЗначение = Неопределено Тогда
		КнопкаОчистки = Ложь;
	Иначе
		КнопкаОчистки = КнопкаОчистки ИЛИ СоставнойТип;
	КонецЕсли;
		
	Элемент.КнопкаОчистки = КнопкаОчистки;
	Элемент.КнопкаВыбора = КнопкаВыбора;
	Элемент.КнопкаВыпадающегоСписка = КнопкаВыпадающегоСписка;
	Элемент.РедактированиеТекста = РедактированиеТекста;
	Элемент.ВыбиратьТип = ВыбиратьТип;
	
	Если ВыбиратьТип Тогда
		Элемент.КартинкаКнопкиВыбора = Элементы.БиблиотекаКартинокУКО_ТипТип.Картинка;
	Иначе
		Элемент.КартинкаКнопкиВыбора = Новый Картинка;
	КонецЕсли;
	
	Если ОграничениеТипа Тогда
		Элемент.ОграничениеТипа = ОписаниеТипов;
	КонецЕсли;
	
КонецПроцедуры
&НаКлиентеНаСервереБезКонтекста
// Возвращает количество ссылочных типов содержащихся в описании типов
//
// Параметры:
//   ОписаниеТипов - ОписаниеТипов - Описание типов
//
// Возвращаемое значение:
//   Число - Количество ссылочных типов 
//
Функция УКО_ОбщегоНазначенияКлиентСервер_КоличествоСсылочныхТипов(ОписаниеТипов) Экспорт 
	
	Количество = 0;
	Для Каждого Тип Из ОписаниеТипов.Типы() Цикл 
		
		Если Не УКО_ОбщегоНазначенияКлиентСервер_ЭтоПростойТип(Тип) Тогда
			Количество = Количество + 1;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Количество;
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Проверяет это простой тип
//
// Параметры:
//   Тип - Тип - Тип
//
// Возвращаемое значение:
//   Булево - Если тип простой
//
Функция УКО_ОбщегоНазначенияКлиентСервер_ЭтоПростойТип(Тип)
	
	Результат = Тип = Тип("Null") ИЛИ Тип = Тип("Неопределено") ИЛИ Тип = Тип("Число") ИЛИ Тип = Тип("Строка") ИЛИ Тип = Тип("Дата") ИЛИ Тип = Тип("Булево") 
				ИЛИ Тип = Тип("УникальныйИдентификатор") ИЛИ Тип = Тип("ХранилищеЗначения") ИЛИ Тип = Тип("Тип") ИЛИ Тип = Тип("МоментВремени") 
				ИЛИ Тип = Тип("Структура") ИЛИ Тип = Тип("ОписаниеТипов") ИЛИ Тип = Тип("ВидДвиженияБухгалтерии") ИЛИ Тип = Тип("ВидДвиженияНакопления")
				ИЛИ Тип = Тип("ВидСчета") ИЛИ Строка(Тип) = "НеизвестныйОбъект";
				
	#Если Сервер Тогда
		Результат = Результат ИЛИ Тип = Тип("РезультатЗапроса");
	#КонецЕсли
	
	Возврат Результат;
	
КонецФункции
&НаКлиенте
// Открывает форму редактирования Уникального идентификатора
//
// Параметры:
//	Заголовок - Строка - Заголовок
//	Значение - УникальныйИдентификатор - Уникальный идентификатор
//	Владелец - Форма/Элемент - Владелец
//	ОписаниеОповещенияЗавершение - ОписаниеОповещения - Описание оповещения при завершении
//
Процедура УКО_ФормыКлиент_ОткрытьРедактированиеУникальногоИдентификатора(Заголовок, Значение, Владелец, ОписаниеОповещенияЗавершение) Экспорт
	
	ПараметрыФормы = Новый Структура("Заголовок, Значение", Заголовок, Значение);
	УКО_ФормыКлиент_ОткрытьДополнительную("РедактированиеУникальногоИдентификатора", ПараметрыФормы, Владелец,, ОписаниеОповещенияЗавершение);
	
КонецПроцедуры
&НаКлиенте
// Обработка очистки значения параметра в форме
//
// Параметры:
//	Элемент - ЭлементФормы - Элемент формы
//	СтандартнаяОбработка - Булево - Стандартная обработка
//
Процедура УКО_ФормыКлиент_ОчисткаЗначенияПараметраВФорме(Элемент, СтандартнаяОбработка) Экспорт
	
	Если Элемент.КнопкаОчистки = Ложь Тогда
		Элемент.ВыбиратьТип = Истина;
		СтандартнаяОбработка = Ложь;
		Возврат;
	КонецЕсли;
	
КонецПроцедуры
&НаКлиентеНаСервереБезКонтекста
// Возвращает ссылочные типы
//
// Параметры:
//   ОписаниеТипов - ОписаниеТипов - Описание типов
//
// Возвращаемое значение:
//   Массив - Ссылочные типы
//
Функция УКО_ОбщегоНазначенияКлиентСервер_СсылочныеТипы(ОписаниеТипов) Экспорт
	
	Типы = Новый Массив;
	Для Каждого Тип Из ОписаниеТипов.Типы() Цикл 
		
		Если Не УКО_ОбщегоНазначенияКлиентСервер_ЭтоПростойТип(Тип) Тогда
			Типы.Добавить(Тип); 
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Новый ОписаниеТипов(Типы);
	
КонецФункции
&НаКлиенте
// Обработка выбора значения параметра в форме
//
// Параметры:
//	Заголовок - Строка - Заголовок
//	Элемент - Элемент - Элемент
//	Значение - Произвольный - Значение параметра
//	ОписаниеТипов - ОписаниеТипов - Описание типов параметра
//	СтандартнаяОбработка - Булево - Стандартная обработка
//	ОписаниеОповещенияЗавершение - ОписаниеОповещения - Описание оповещения (завершение)
//	РедактированиеСписка - Булево - Редактирование списка
//
Процедура УКО_ФормыКлиент_ВводЗначенияПараметраВФорме(Заголовок, Элемент, Значение, ОписаниеТипов, СтандартнаяОбработка, ОписаниеОповещенияЗавершение, РедактированиеСписка = Ложь) Экспорт
	
	Если ТипЗнч(Значение) = Тип("СписокЗначений") Тогда
		Возврат;
	КонецЕсли;
	
	ПроверяемоеЗначение = УКО_ФормыКлиент_ПроверяемоеЗначениеПараметра(Значение, ОписаниеТипов);
	
	Если ТипЗнч(ПроверяемоеЗначение) = Тип("Тип") Тогда
		
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("Заголовок", Заголовок);
		УКО_ФормыКлиент_ОткрытьРедактированиеТипаЗначения(Элемент, "Перечисление.УКО_РежимРедактированияТипаЗначения.РедактированиеТипа",
											Значение, ОписаниеОповещенияЗавершение, ДополнительныеПараметры);

	ИначеЕсли ТипЗнч(ПроверяемоеЗначение) = Тип("УникальныйИдентификатор") Тогда
		
		УКО_ФормыКлиент_ОткрытьРедактированиеУникальногоИдентификатора(Заголовок, Значение, Элемент, ОписаниеОповещенияЗавершение);
		
	ИначеЕсли Элемент.ВыбиратьТип Тогда
		
		СтандартнаяОбработка = Ложь;
		
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("Заголовок", Заголовок);
		Если РедактированиеСписка Тогда
			ДополнительныеПараметры.Вставить("ИсключаемыеТипы", "Граница,МоментВремени");
		КонецЕсли;
		
		УКО_ФормыКлиент_ОткрытьРедактированиеТипаЗначения(Элемент, "Перечисление.УКО_РежимРедактированияТипаЗначения.ВыборТипа",
											ОписаниеТипов, ОписаниеОповещенияЗавершение, ДополнительныеПараметры);
		
	КонецЕсли;

КонецПроцедуры
&НаКлиенте
// Открывает дополнительную/вспомогательную форму
//
// Параметры:
//	Имя - Строка - Имя формы
//	Параметры - Структура - Параметры формы (необязательный)
//	Владелец - Форма - Форма владелец
//	Уникальность - Произвольный - Уникальность (необязательный)
//	ОписаниеОповещенияОЗакрытии - ОписаниеОповещения - Описание оповещения о закрытии (необязательный)
//
Процедура УКО_ФормыКлиент_ОткрытьДополнительную(Имя, Параметры = Неопределено, Владелец = Неопределено, Уникальность = Неопределено, ОписаниеОповещенияОЗакрытии = Неопределено) Экспорт
	
	Если УКО_ОбщегоНазначенияКлиентСервер_РежимЗапускаВнешняяОбработка() Тогда
		ОбъектФорм = СтрШаблон("ВнешняяОбработка.%1%2.Форма.", УКО_ОбщегоНазначенияКлиентСервер_ПрефиксРасширения(), УКО_ОбщегоНазначенияКлиентСервер_ИдентификаторРасширения());
	Иначе
		ОбъектФорм = "ОбщаяФорма";
	КонецЕсли;
	
	ПолноеИмяФормы = СтрШаблон("%1.%2%3", ОбъектФорм, УКО_ОбщегоНазначенияКлиентСервер_ПрефиксРасширения(), Имя);
	
	Если Владелец = Неопределено Тогда
		РежимОткрытия = Неопределено;
	Иначе 
		РежимОткрытия = РежимОткрытияОкнаФормы.БлокироватьОкноВладельца;
	КонецЕсли;
	
	ОткрытьФорму(ПолноеИмяФормы, Параметры, Владелец, Уникальность,,,ОписаниеОповещенияОЗакрытии, РежимОткрытия);
	
КонецПроцедуры
&НаКлиенте
// Открывает форму редактирования типа значения
//
// Параметры:
//	Владелец - Форма/Элемент - Владелец
//	РежимРедактирования - Перечисление.УКО_РежимРедактированияТипаЗначения - Режим редактирования типа значения
//	Значение - Произвольный/ОписаниеТипов - Значение
//	ОписаниеОповещенияЗавершение - ОписаниеОповещения - Описание оповещения при завершении
//	ДополнительныеПараметры - Структура - Дополнительные параметры
//	 *Заголовок - Строка - Заголовок
//	 *ЗакрыватьПриВыборе - Булево - Закрывать при выборе
//	 *ИсключаемыеТипы - Строка - Исключаемые типы через запятую
//
Процедура УКО_ФормыКлиент_ОткрытьРедактированиеТипаЗначения(Владелец, РежимРедактирования, Значение, ОписаниеОповещенияЗавершение, ДополнительныеПараметры = Неопределено) Экспорт
	
	Если ДополнительныеПараметры = Неопределено Тогда
		ДополнительныеПараметры = Новый Структура;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Значение", Значение);
	ПараметрыФормы.Вставить("Режим", РежимРедактирования);
	
	ПараметрыФормы.Вставить("Заголовок", УКО_ОбщегоНазначенияКлиентСервер_ЗначениеСвойстваСтруктуры(ДополнительныеПараметры, "Заголовок", ""));
	ПараметрыФормы.Вставить("ЗакрыватьПриВыборе", УКО_ОбщегоНазначенияКлиентСервер_ЗначениеСвойстваСтруктуры(ДополнительныеПараметры, "ЗакрыватьПриВыборе", Истина));
	ПараметрыФормы.Вставить("ИсключаемыеТипы", УКО_ОбщегоНазначенияКлиентСервер_ЗначениеСвойстваСтруктуры(ДополнительныеПараметры, "ИсключаемыеТипы", ""));
	
	ВыборТипа = (РежимРедактирования = "Перечисление.УКО_РежимРедактированияТипаЗначения.ВыборТипа");
	ОписаниеОповещенияЗавершение.ДополнительныеПараметры.Вставить("ВыборТипа", ВыборТипа);
	
	УКО_ФормыКлиент_ОткрытьДополнительную("РедактированиеТипаЗначения", ПараметрыФормы, Владелец,, ОписаниеОповещенияЗавершение);
	
КонецПроцедуры
&НаКлиентеНаСервереБезКонтекста
// Возвращает идентификатор расширения
// Возвращаемое значение:
//   Строка	- Идентификатор расширения
Функция УКО_ОбщегоНазначенияКлиентСервер_ИдентификаторРасширения() Экспорт 
	
	Возврат "УправляемаяКонсольОтчетов";
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает префикс объектов расширения
// Возвращаемое значение:
//   Строка	- Префикс объектов расширения
Функция УКО_ОбщегоНазначенияКлиентСервер_ПрефиксРасширения() Экспорт 
	
	Возврат "УКО_";
	
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
// Получает значение свойства структуры
// Параметры:
//   Структура - Структура - Структура
//   Имя - Строка - Имя свойства
//   ЗначениеПоУмолчанию - Произвольный - Значение по умолчанию, когда в данной структуре нет этого свойства
// Возвращаемое значение:
//   Произвольный - Значение свойства структуры
Функция УКО_ОбщегоНазначенияКлиентСервер_ЗначениеСвойстваСтруктуры(Структура = Неопределено, Имя = Неопределено, ЗначениеПоУмолчанию = Неопределено) Экспорт
	
	Значение = ЗначениеПоУмолчанию;
	
	Если (ТипЗнч(Структура) = Тип("Структура")
				ИЛИ ТипЗнч(Структура) = Тип("ДанныеФормыСтруктура"))
			И Структура.Свойство(Имя) Тогда
		
		Значение = Структура[Имя];
		
	КонецЕсли;
	
	Возврат Значение;
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает Описание типов строка)
// Параметры:
//   ДлинаСтроки - Число - Длина строки
// Возвращаемое значение:
//   ОписаниеТипов - Описание типов строка
Функция УКО_ОбщегоНазначенияКлиентСервер_ОписаниеТиповСтрока(ДлинаСтроки = 0) Экспорт
	
	Возврат Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(ДлинаСтроки));
	
КонецФункции
&НаКлиенте

Функция УКО_ФормыКлиент_ПроверяемоеЗначениеПараметра(Значение, ОписаниеТипов)
	
	Если ТипЗнч(Значение) = Тип("Структура")
			ИЛИ ТипЗнч(Значение) = Тип("МоментВремени")
			ИЛИ ТипЗнч(Значение) = Тип("Граница")
			ИЛИ ОписаниеТипов = "Перечисление.УКО_СложныйПараметрЗапроса.ТаблицаЗначений" Тогда
		Результат = Значение;
	Иначе
		Результат = ОписаниеТипов.ПривестиЗначение(Значение);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции
&НаКлиенте
// Обработка выбора значения параметра в форме
//
// Параметры:
//	Элемент - ЭлементФормы - Элемент формы
//	ВыбранноеЗначение - Произвольный - Выбранное значение
//	СтандартнаяОбработка - Булево - Стандартная обработка
//
Процедура УКО_ФормыКлиент_ОбработкаВыбораЗначенияПараметраВФорме(Элемент, ВыбранноеЗначение, СтандартнаяОбработка) Экспорт
	
	Если ТипЗнч(ВыбранноеЗначение) = Тип("Структура") Тогда
		
		Если ВыбранноеЗначение.Тип = "ТекущаяДата" Тогда
			
			ВыбранноеЗначение = ТекущаяДата();
			
		ИначеЕсли ВыбранноеЗначение.Тип = "ОсобаяСсылка" Тогда
			
			ВыбранноеЗначение = ВыбранноеЗначение.Ссылка;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры
&НаКлиенте
// Обработка автоподбора значения в форме
//
// Параметры:
//	Текст - Строка - Текст
//	ТипЗначения - ОписаниеТипов, Строка - Тип значения параметра
//	ДанныеВыбора - Неопределено, СписокЗначений - ДанныеВыбора
//	СтандартнаяОбработка - Булево - Стандартная обработка
//
Процедура УКО_ФормыКлиент_АвтоПодборЗначенияВФорме(Текст, ТипЗначения, ДанныеВыбора, СтандартнаяОбработка) Экспорт
	
	Если УКО_СтрокиКлиентСервер_ЭтоUID(Текст)
		ИЛИ УКО_СтрокиКлиентСервер_ЭтоПредставлениеБитаяСсылка(Текст) Тогда
		
		СтандартнаяОбработка = Ложь;
		УКО_ФормыВызовСервера_АвтоПодборЗначения(Текст, ТипЗначения, ДанныеВыбора);
		
	КонецЕсли;
	
КонецПроцедуры
&НаКлиентеНаСервереБезКонтекста
// Проверяет является ли строка UID
//
// Параметры:
//   ПроверяемаяСтрока - Строка - Проверяемая строка
//
// Возвращаемое значение:
//   Булево - Истина, это UID
//
Функция УКО_СтрокиКлиентСервер_ЭтоUID(ПроверяемаяСтрока) Экспорт
	
	Попытка
		УникальныйИдентификатор = Новый УникальныйИдентификатор(ПроверяемаяСтрока);
		Результат = Истина;
	Исключение
		Результат = Ложь;
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Проверяет является ли строка представление битой ссылки
//
// Параметры:
//   ПроверяемаяСтрока - Строка - Проверяемая строка
//
// Возвращаемое значение:
//   Булево - Истина, представление битой ссылки
//
Функция УКО_СтрокиКлиентСервер_ЭтоПредставлениеБитаяСсылка(ПроверяемаяСтрока) Экспорт
	
	Возврат СтрНачинаетсяС(ПроверяемаяСтрока, НСтр("ru = '<Объект не найден>'; en = '<Object not found>'"));
	
КонецФункции
&НаСервере
// Обработка автоподбора значения в форме
//
// Параметры:
//	Текст - Строка - Текст
//	ТипЗначения - ОписаниеТипов, Строка - Тип значения параметра
//	ДанныеВыбора - Неопределено, СписокЗначений - ДанныеВыбора
//
Процедура УКО_ФормыВызовСервера_АвтоПодборЗначения(Текст, ТипЗначения, ДанныеВыбора) Экспорт
	
	Если ТипЗнч(ТипЗначения) = Тип("ОписаниеТипов")
		И ЗначениеЗаполнено(ТипЗначения.Типы()) Тогда
		
		Тип = ТипЗначения.Типы()[0];
		Если УКО_ОбщегоНазначенияКлиентСервер_ЭтоСсылочныйТип(Тип) Тогда
			
			Если УКО_СтрокиКлиентСервер_ЭтоПредставлениеБитаяСсылка(Текст) Тогда
				
				// Получение UID битой ссылки
				Индекс = СтрНайти(Текст, ":");
				Если ЗначениеЗаполнено(Индекс) Тогда
					
					UIDБитойСсылки = УКО_СтрокиКлиентСервер_РазборПрочитатьШестнадцатеричноеЧисло(Текст, Индекс + 1);
					Ссылка = ОбъектОбработки().УКО_ОбщегоНазначения_СсылкаПоВнутреннемуUID(UIDБитойСсылки, Тип);
					
					УКО_ФормыВызовСервера_ВставкаОсобойСсылкиВДанныеВыбора(ДанныеВыбора, Ссылка, Текст);
					
				КонецЕсли;
				
			ИначеЕсли УКО_СтрокиКлиентСервер_ЭтоUID(Текст) Тогда
				
				УникальныйИдентификаторСсылки = Новый УникальныйИдентификатор(Текст);
				Ссылка = ОбъектОбработки().УКО_ОбщегоНазначения_СсылкаПоУникальномуИдентификатору(УникальныйИдентификаторСсылки, Тип);
					
				УКО_ФормыВызовСервера_ВставкаОсобойСсылкиВДанныеВыбора(ДанныеВыбора, Ссылка, СтрШаблон("%1 (%2)", Ссылка, Текст));
				
			КонецЕсли;

		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры
&НаКлиентеНаСервереБезКонтекста
// Возвращает пустой UID "00000000000000000000000000000000"
//
// Возвращаемое значение:
//   Строка - Пустой UID
//
Функция УКО_СтрокиКлиентСервер_ПустойUID() Экспорт
	
	Возврат "00000000000000000000000000000000";
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Проверяет это ссылочный тип
//
// Параметры:
//  Тип  - Тип - Тип
//  ИсключаяПеречисления  - Булево - Исключать перечисление из ссылочных типов
//
// Возвращаемое значение:
//   Булево - Истина, ссылочный тип
//
Функция УКО_ОбщегоНазначенияКлиентСервер_ЭтоСсылочныйТип(Тип, ИсключаяПеречисления = Ложь) Экспорт
	
	ПростойТип = УКО_ОбщегоНазначенияКлиентСервер_ЭтоПростойТип(Тип);
	Результат = Не ПростойТип;
	Если ИсключаяПеречисления Тогда 
		
		#Если Сервер Тогда
			
			Если Перечисления.ТипВсеСсылки().СодержитТип(Тип) Тогда
				Результат = Ложь;  
			КонецЕсли;
			
		#КонецЕсли
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Чтение шестнадцатеричного числа из строки
//
// Параметры:
//   Строка - Строка - Разбираемая строка
//   НачальныйИндекс - Число - Начальный индекс
//   СмещатьИндекс - Булево - Смещать индекс (по умолчанию: Истина)
//
// Возвращаемое значение:
//   Число	- Прочитанное целое число
//
Функция УКО_СтрокиКлиентСервер_РазборПрочитатьШестнадцатеричноеЧисло(Строка, НачальныйИндекс = Неопределено, СмещатьИндекс = Истина) Экспорт
	
	Если НачальныйИндекс = Неопределено Тогда
		НачальныйИндекс = 1;
	КонецЕсли;
	
	Для Индекс = НачальныйИндекс По СтрДлина(Строка) Цикл 
		
		Если Не СтрНайти(УКО_СтрокиКлиентСервер_НаборСимволовШестнадцатеричныеЦифры(), Сред(Строка, Индекс, 1)) Тогда 
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

Функция УКО_СтрокиКлиентСервер_НаборСимволовШестнадцатеричныеЦифры()
	
	Возврат "0123456789ABCDEFabcdef";
	
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
&НаСервере

Процедура УКО_ФормыВызовСервера_ВставкаОсобойСсылкиВДанныеВыбора(ДанныеВыбора, Ссылка, Текст)
	
	Если ЗначениеЗаполнено(Ссылка) Тогда
		
		ДанныеСсылки = Новый Структура();
		ДанныеСсылки.Вставить("Тип", "ОсобаяСсылка");
		ДанныеСсылки.Вставить("Ссылка", Ссылка);
		
		ДанныеВыбора = Новый СписокЗначений;
		ДанныеВыбора.Добавить(ДанныеСсылки, Текст);
		
	КонецЕсли;
	
КонецПроцедуры
