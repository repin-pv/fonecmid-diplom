#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Добавляем реквизиты
	ДобавляемыеРеквизиты = Новый Массив;
	Для Каждого ЭлементДанных Из Параметры.Данные Цикл 
		
		НоваяСтрока = Данные.Добавить();
		НоваяСтрока.Имя = ЭлементДанных.Ключ;
		НоваяСтрока.Значение = ЭлементДанных.Значение;

	КонецЦикла;
	
	Заголовок = СтрШаблон(НСтр("ru = 'Расшифровка данных строки № %1'; en = 'String data decryption № %1'"), Параметры.НомерСтроки);
	
	РезультатыОбработки = ПолучитьИзВременногоХранилища(Параметры.АдресРезультатов);
	ОписаниеРезультата = РезультатыОбработки[Параметры.НомерСтроки];
	
	// Добавляем сообщения
	ПоказыватьСообщения = (ОписаниеРезультата <> Неопределено);
	Элементы.Сообщения.Видимость = ПоказыватьСообщения;
	Если ПоказыватьСообщения И ОписаниеРезультата.Свойство("Сообщения") Тогда
		
		Для Каждого Сообщение Из ОписаниеРезультата.Сообщения Цикл 
			
			НоваяСтрока = Сообщения.Добавить();
			НоваяСтрока.Текст = Сообщение;
			
		КонецЦикла;
		
	КонецЕсли;
	
	Ошибка = УКО_ОбщегоНазначенияКлиентСервер_ЗначениеСвойстваСтруктуры(ОписаниеРезультата, "Ошибка", "");
	ОписаниеОшибки = УКО_ЗапросКлиентСервер_ИнформацияООшибке(Ошибка);
	
	Элементы.Ошибка.Видимость = ЗначениеЗаполнено(Ошибка);
	Элементы.ПерейтиКМестуОшибкиЗакрыть.Видимость = Параметры.ОбработкаЗавершения И (ТипЗнч(ОписаниеОшибки) = Тип("Структура"));
	
	Если ЗначениеЗаполнено(Параметры.АктивнаяСтраница) Тогда
		ТекущийЭлемент = Элементы["Страница" + Параметры.АктивнаяСтраница];
	КонецЕсли;
	
	ДанныеКоличество = Данные.Количество();
	СообщенияКоличество = Сообщения.Количество();
	
КонецПроцедуры

&НаКлиенте
Процедура ДанныеЗначениеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;

КонецПроцедуры

&НаКлиенте
Процедура ДанныеЗначениеОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСообщения

&НаКлиенте
Процедура СообщенияТекстОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура СообщенияТекстОткрытие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПерейтиКМестуОшибкиЗакрыть(Команда)
	
	ОписаниеОшибки = УКО_ЗапросКлиентСервер_ИнформацияООшибке(Ошибка);
	Закрыть(ОписаниеОшибки);

КонецПроцедуры

#КонецОбласти

&НаСервере
Функция ОбъектОбработки()
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции
&НаКлиентеНаСервереБезКонтекста

Функция УКО_СтрокиКлиентСервер_РазборПропуститьСимвол(Строка, Символ, НачальныйИндекс, СмещатьИндекс = Истина)
	
	Результат = "";
	
	Если Сред(Строка, НачальныйИндекс, 1) = Символ Тогда
		
		Результат = Символ;
		
		Если СмещатьИндекс Тогда
			НачальныйИндекс = НачальныйИндекс + 1;
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Чтение набора символов
//
// Параметры:
//   Строка - Строка - Разбираемая строка
//   НаборСимволов - Строка - Набор символов
//   НачальныйИндекс - Число - Начальный индекс
//   СмещатьИндекс - Булево - Смещать индекс (по умолчанию: Истина)
//
// Возвращаемое значение:
//   Строка	- Прочитанная строка
//
Функция УКО_СтрокиКлиентСервер_РазборПропуститьНаборСимволов(Строка, НаборСимволов, НачальныйИндекс = 1, СмещатьИндекс = Истина) Экспорт
	
	Результат = "";
	
	Для Индекс = 1 По СтрДлина(НаборСимволов) Цикл 
		Результат = Результат + УКО_СтрокиКлиентСервер_РазборПропуститьСимвол (Строка, Сред(НаборСимволов, Индекс, 1), НачальныйИндекс, СмещатьИндекс);
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Возвращает информацию о ошибке в тексте запрос
//
// Параметры:
//   ТекстОшибки - Строка - Текст ошибки вида //{(1, 1)}: Ожидается ВЫБРАТЬ
//   АнализируетсяПланЗапроса - Булево - Анализируется план запроса (присутствуют маркировочные запросы)
//
// Возвращаемое значение:
//   Структура - Информация о ошибке
//   	*Текст - Строка - Текст ошибки
//   	*НомерСтроки - Число - Номер строки
//   	*НомерСтолбца - Число - Номер столбцы
Функция УКО_ЗапросКлиентСервер_ИнформацияООшибке(ТекстОшибки, АнализируетсяПланЗапроса = Ложь) Экспорт
	
	// Разбирает строку ошибки запроса
	// Например: {(19, 2)}: Синтаксическая ошибка "Справочник.Товары"
	// <<?>>Справочник.Товары КАК Товары	
	
	Если ПустаяСтрока(ТекстОшибки) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Индекс = 1;
	Если УКО_СтрокиКлиентСервер_РазборПрочитатьСимвол(ТекстОшибки, Индекс) = "{" Тогда
		
		УКО_СтрокиКлиентСервер_РазборПропуститьНаборСимволов(ТекстОшибки, "(", Индекс);
		НомерСтроки = УКО_СтрокиКлиентСервер_РазборПрочитатьЦелоеЧисло(ТекстОшибки, Индекс);
		УКО_СтрокиКлиентСервер_РазборПропуститьНаборСимволов(ТекстОшибки, ", ", Индекс);
		НомерСтолбца = УКО_СтрокиКлиентСервер_РазборПрочитатьЦелоеЧисло(ТекстОшибки, Индекс);
		УКО_СтрокиКлиентСервер_РазборПропуститьНаборСимволов(ТекстОшибки, ")}: ", Индекс);
		Текст = УКО_СтрокиКлиентСервер_РазборПрочитатьДоСимвола(ТекстОшибки, "", Индекс);
		
		Если АнализируетсяПланЗапроса Тогда
			НомерСтроки = НомерСтроки - 1;
		КонецЕсли;
		
	Иначе 
		
		Текст = ТекстОшибки;
		НомерСтроки = 1; НомерСтолбца = 1;
		
	КонецЕсли;
	
	Ошибка = Новый Структура;
	Ошибка.Вставить("Текст", Текст);
	Ошибка.Вставить("НомерСтроки", НомерСтроки);
	Ошибка.Вставить("НомерСтолбца", НомерСтолбца);
	
	Возврат Ошибка;
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Чтение целого число из строки
//
// Параметры:
//   Строка - Строка - Разбираемая строка
//   НачальныйИндекс - Число - Начальный индекс
//   Направление - НаправлениеПоиска - Направление поиска (по умолчанию: НаправлениеПоиска.СНачала)
//   СмещатьИндекс - Булево - Смещать индекс (по умолчанию: Истина)
//
// Возвращаемое значение:
//   Число	- Прочитанное целое число
//
Функция УКО_СтрокиКлиентСервер_РазборПрочитатьЦелоеЧисло(Строка, НачальныйИндекс = Неопределено, Направление = Неопределено, СмещатьИндекс = Истина) Экспорт
	
	Если Направление = НаправлениеПоиска.СКонца Тогда
		
		Если НачальныйИндекс = Неопределено Тогда
			НачальныйИндекс = СтрДлина(Строка);
		КонецЕсли;
		
		Индекс = НачальныйИндекс;
		Пока Индекс > 0 Цикл 
			
			Если Не СтрНайти(УКО_СтрокиКлиентСервер_НаборСимволовЦифры(), Сред(Строка, Индекс, 1)) Тогда 
				Прервать;
			КонецЕсли;
			
			Индекс = Индекс - 1;
		КонецЦикла;
		
		Результат = Сред(Строка, Индекс + 1, НачальныйИндекс - Индекс); 
		
	Иначе
		
		Если НачальныйИндекс = Неопределено Тогда
			НачальныйИндекс = 1;
		КонецЕсли;
		
		Для Индекс = НачальныйИндекс По СтрДлина(Строка) Цикл 
			
			Если Не СтрНайти(УКО_СтрокиКлиентСервер_НаборСимволовЦифры(), Сред(Строка, Индекс, 1)) Тогда 
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
		
		Результат = Сред(Строка, НачальныйИндекс, Индекс - НачальныйИндекс); 
		
	КонецЕсли;
	
	Если СмещатьИндекс Тогда
		НачальныйИндекс = Индекс;
	КонецЕсли;
	
	Возврат Число(Результат);
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста

Функция УКО_СтрокиКлиентСервер_НаборСимволовЦифры()
	
	Возврат "0123456789";
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Чтение символа
//
// Параметры:
//   Строка - Строка - Разбираемая строка
//   НачальныйИндекс - Число - Начальный индекс
//   СмещатьИндекс - Булево - Смещать индекс (по умолчанию: Истина)
//
// Возвращаемое значение:
//   Строка	- Прочитанный символ
//
Функция УКО_СтрокиКлиентСервер_РазборПрочитатьСимвол(Строка, НачальныйИндекс = 1, СмещатьИндекс = Истина) Экспорт
	
	Результат = Сред(Строка, НачальныйИндекс, 1);
	
	Если СмещатьИндекс Тогда
		НачальныйИндекс = НачальныйИндекс + 1;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Чтение строки до символа
//
// Параметры:
//   Строка - Строка - Разбираемая строка
//   Символ - Строка - Стоп символ
//   НачальныйИндекс - Число - Начальный индекс
//   Направление - НаправлениеПоиска - Направление поиска (по умолчанию: НаправлениеПоиска.СНачала)
//   СмещатьИндекс - Булево - Смещать индекс (по умолчанию: Истина)
//
// Возвращаемое значение:
//   Строка	- Прочитанная строка до стоп символа
//
Функция УКО_СтрокиКлиентСервер_РазборПрочитатьДоСимвола(Строка, Символ, НачальныйИндекс = Неопределено, Направление = Неопределено, СмещатьИндекс = Истина) Экспорт
	
	Если Направление = Неопределено Тогда
		Индекс = СтрНайти(Строка, Символ, , НачальныйИндекс);
	Иначе
		Индекс = СтрНайти(Строка, Символ, Направление, НачальныйИндекс);
	КонецЕсли;
	
	Если Направление = НаправлениеПоиска.СКонца Тогда
		
		Если НачальныйИндекс = Неопределено Тогда
			НачальныйИндекс = СтрДлина(Строка);
		КонецЕсли;
		
		Результат = Сред(Строка, Индекс + 1, НачальныйИндекс - Индекс); 
		
	Иначе
		
		Если НачальныйИндекс = Неопределено Тогда
			НачальныйИндекс = 1;
		КонецЕсли;
		
		Результат = Сред(Строка, НачальныйИндекс, Индекс - НачальныйИндекс); 
		
	КонецЕсли;
	
	Если СмещатьИндекс Тогда
		НачальныйИндекс = Индекс;
	КонецЕсли;
	
	Возврат Результат;
	
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
