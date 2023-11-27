
&НаСервере
Процедура СоздатьНаСервере()
	
	// repin_pv 25.11.23 {{{ Ранний возврат - если не указан ПЕРИОД
	Если Объект.Период = Дата("01.01.0001 0:00:00") Тогда 
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Не указан МЕСЯЦ");
		Возврат;
		
	КонецЕсли;
	// }}} repin_pv 25.11.23 
		
	НачалоПериода = НачалоМесяца(Дата(Объект.Период));
	КонецПериода = КонецМесяца(Дата(Объект.Период));
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ДоговорыКонтрагентов.Ссылка КАК Договор
	|ПОМЕСТИТЬ втДоговоры
	|ИЗ
	|	Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
	|ГДЕ
	|	ДоговорыКонтрагентов.ВидДоговора = &ВидДоговора
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	РеализацияТоваровУслуг.Договор.Ссылка КАК Реализации
	|ПОМЕСТИТЬ втРеализации
	|ИЗ
	|	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
	|ГДЕ
	|	РеализацияТоваровУслуг.Договор.ВидДоговора = &ВидДоговора
	|	И РеализацияТоваровУслуг.Дата МЕЖДУ &НачалоПериода И &КонецПериода
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	втДоговоры.Договор.Ссылка КАК ДоговорСсылка
	|ИЗ
	|	втДоговоры КАК втДоговоры
	|		ЛЕВОЕ СОЕДИНЕНИЕ втРеализации КАК втРеализации
	|		ПО (втРеализации.Реализации.Ссылка = втДоговоры.Договор.Ссылка)
	|ГДЕ
	|	втРеализации.Реализации.Ссылка ЕСТЬ NULL";
	
	Запрос.УстановитьПараметр("ВидДоговора", ПредопределенноеЗначение("Перечисление.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание"));
	Запрос.УстановитьПараметр("НачалоПериода", НачалоПериода);
	Запрос.УстановитьПараметр("КонецПериода", КонецПериода);
	
	Результат = Запрос.Выполнить().Выгрузить();
	
	Если НЕ Запрос.Выполнить().Пустой() Тогда 
		
		Для каждого ЭлементРезультата Из Результат Цикл
			
			Попытка
				
				НовыйДокумент = Документы.РеализацияТоваровУслуг.СоздатьДокумент();
				НовыйДокумент.Контрагент = ЭлементРезультата.ДоговорСсылка.Владелец;
				НовыйДокумент.Договор	 = ЭлементРезультата.ДоговорСсылка.Ссылка;
				НовыйДокумент.Организация = ЭлементРезультата.ДоговорСсылка.Организация;
				НовыйДокумент.Ответственный = ПараметрыСеанса.ТекущийПользователь;
				НовыйДокумент.Дата		 = ТекущаяДата();
				НовыйДокумент.ВыполнитьАвтозаполнение();
				НовыйДокумент.Записать(РежимЗаписиДокумента.Проведение,РежимПроведенияДокумента.Оперативный);
				
				тчДокументы = Объект.Документы.Добавить();
				тчДокументы.Договор = НовыйДокумент.Договор.Ссылка;
				тчДокументы.Реализация = НовыйДокумент.Ссылка; 
				
			Исключение
				
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Не удалось создать документ по договору: " + ЭлементРезультата.ДоговорСсылка.Ссылка);
				
			КонецПопытки;
			
		КонецЦикла;
		
	Иначе
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю("За указанный период документы уже созданы");
		
	КонецЕсли;
    
КонецПроцедуры

&НаКлиенте
Процедура Создать(Команда)
	СоздатьНаСервере();
КонецПроцедуры

