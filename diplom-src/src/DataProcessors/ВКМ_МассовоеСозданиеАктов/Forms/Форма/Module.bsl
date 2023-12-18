
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
	
	// repin_pv 02.12.23 {{{
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ДоговорыКонтрагентов.Ссылка КАК Договор
	|ПОМЕСТИТЬ втДоговоры
	|ИЗ
	|	Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
	|ГДЕ
	|	ДоговорыКонтрагентов.ВидДоговора = &ВидДоговора
	|	И &ДатаЗапроса МЕЖДУ ДоговорыКонтрагентов.ВКМ_ДатаНачалаДействияДоговора И ДоговорыКонтрагентов.ВКМ_ДатаОкончанияДействияДоговора
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
	|	И РеализацияТоваровУслуг.ПометкаУдаления = ЛОЖЬ
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
	Запрос.УстановитьПараметр("ДатаЗапроса", НачалоПериода);
	
	Результат = Запрос.Выполнить().Выгрузить();
	
	Если НЕ Запрос.Выполнить().Пустой() Тогда 
		
		Для каждого ЭлементРезультата Из Результат Цикл
			
			НовыйДокумент = Документы.РеализацияТоваровУслуг.СоздатьДокумент();
			НовыйДокумент.Контрагент = ЭлементРезультата.ДоговорСсылка.Владелец;
			НовыйДокумент.Договор	 = ЭлементРезультата.ДоговорСсылка.Ссылка;
			НовыйДокумент.Организация = ЭлементРезультата.ДоговорСсылка.Организация;
			НовыйДокумент.Ответственный = ПараметрыСеанса.ТекущийПользователь;
			НовыйДокумент.Дата		 = КонецПериода;
			НовыйДокумент.ВыполнитьАвтозаполнение();
			
			Если ЗначениеЗаполнено(НовыйДокумент.Услуги) Тогда
				
				НовыйДокумент.Записать(РежимЗаписиДокумента.Проведение,РежимПроведенияДокумента.Неоперативный);
				тчДокументы = Объект.Документы.Добавить();
				тчДокументы.Договор = НовыйДокумент.Договор.Ссылка;
				тчДокументы.Реализация = НовыйДокумент.Ссылка;
				
			Иначе 
				Клиент = НовыйДокумент.Контрагент;
				Договор = НовыйДокумент.Договор;
				ТекстСообщения = СтрШаблон("Клиенту %1 по договору %2 за %3 услуг не предоставлялось",
												Клиент, Договор, Формат(КонецПериода, "ДФ='MMMM yyyy'"));
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
				
			КонецЕсли;
			
		КонецЦикла;
		
	Иначе
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю("За указанный период документы уже созданы");
		
	КонецЕсли;
	// }}} repin_pv 02.12.23 
	
КонецПроцедуры

&НаКлиенте
Процедура Создать(Команда)
	СоздатьНаСервере();
КонецПроцедуры

