
Функция ТелеграмБотСообщение(ТекстСообщения) Экспорт
	
	Соединение = Новый HTTPСоединение("api.telegram.org",443,,,,, Новый ЗащищенноеСоединениеOpenSSL);
	
	СтрокаЗапроса = СтрШаблон("/bot%1/sendMessage", Константы.ВКМ_ТокенУправленияТелеграмБотом.Получить());
	
	ИдентификаторГруппы = Константы.ВКМ_ИдентификаторГруппыДляОповещения.Получить();
	
	ШаблонСообщения = ТекстСообщения;
	
	ТелоОбъекта = Новый Структура;
	ТелоОбъекта.Вставить("chat_id", ИдентификаторГруппы);
	ТелоОбъекта.Вставить("text", ШаблонСообщения);
	
	Запись = Новый ЗаписьJSON;
	Запись.УстановитьСтроку();
	ЗаписатьJSON(Запись, ТелоОбъекта);
	ТелоЗапроса = Запись.Закрыть();
	
	Заголовки = Новый Соответствие;
	Заголовки.Вставить("Content-Type", "application/json");
	
	Запрос = Новый HTTPЗапрос(СтрокаЗапроса, Заголовки);
	Запрос.УстановитьТелоИзСтроки(ТелоЗапроса); 
	
	Ответ = Соединение.ВызватьHTTPМетод("POST", Запрос);
	
	Если Ответ.КодСостояния <> 200 Тогда 
		
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Что-то пошло не так :(";
		Сообщение.Сообщить();
		
	КонецЕсли;
	
	Возврат Ответ.КодСостояния;
	
КонецФункции

Процедура ВКМ_ОтправитьСообщениеБоту() Экспорт 
		
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВКМ_УведомленияТелеграмБоту.Ссылка КАК Ссылка,
		|	ВКМ_УведомленияТелеграмБоту.Наименование КАК Наименование,
		|	ВКМ_УведомленияТелеграмБоту.Текст КАК Текст
		|ИЗ
		|	Справочник.ВКМ_УведомленияТелеграмБоту КАК ВКМ_УведомленияТелеграмБоту";
	
	Выборка = Запрос.Выполнить().Выбрать();
		
	Пока Выборка.Следующий() Цикл

		Наименование = Выборка.Наименование;
		Текст = Выборка.Текст;
		
		ТекстСообщения = СтрШаблон("%1" + Символы.ПС + "%2", Наименование, Текст);
		
		СтатусСообщенияТГ = ВКМ_ОбщегоНазначенияТелеграмСервер.ТелеграмБотСообщение(ТекстСообщения);
		
		Если СтатусСообщенияТГ = 200 Тогда
			
			Выборка.Ссылка.ПолучитьОбъект().Удалить();
			
		КонецЕсли;
				
	КонецЦикла;
	    
КонецПроцедуры //ВКМ_ОтправитьСообщениеБоту


	
