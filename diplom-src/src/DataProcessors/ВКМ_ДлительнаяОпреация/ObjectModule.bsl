
//Процедура СоздатьДокументыНаСервере(НачалоПериода, КонецПериода) Экспорт  
//	 
//	 Запрос = Новый Запрос;
//	 Запрос.Текст = 
//	 "ВЫБРАТЬ
//	 |	ДоговорыКонтрагентов.Ссылка КАК Договор
//	 |ПОМЕСТИТЬ втДоговоры
//	 |ИЗ
//	 |	Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
//	 |ГДЕ
//	 |	ДоговорыКонтрагентов.ВидДоговора = &ВидДоговора
//	 |;
//	 |
//	 |////////////////////////////////////////////////////////////////////////////////
//	 |ВЫБРАТЬ
//	 |	РеализацияТоваровУслуг.Договор.Ссылка КАК Реализации
//	 |ПОМЕСТИТЬ втРеализации
//	 |ИЗ
//	 |	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
//	 |ГДЕ
//	 |	РеализацияТоваровУслуг.Договор.ВидДоговора = &ВидДоговора
//	 |	И РеализацияТоваровУслуг.Дата МЕЖДУ &НачалоПериода И &КонецПериода
//	 |;
//	 |
//	 |////////////////////////////////////////////////////////////////////////////////
//	 |ВЫБРАТЬ
//	 |	втДоговоры.Договор.Ссылка КАК ДоговорСсылка
//	 |ИЗ
//	 |	втДоговоры КАК втДоговоры
//	 |		ЛЕВОЕ СОЕДИНЕНИЕ втРеализации КАК втРеализации
//	 |		ПО (втРеализации.Реализации.Ссылка = втДоговоры.Договор.Ссылка)
//	 |ГДЕ
//	 |	втРеализации.Реализации.Ссылка ЕСТЬ NULL";
//	 
//	 Запрос.УстановитьПараметр("ВидДоговора", ПредопределенноеЗначение("Перечисление.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание"));
//	 Запрос.УстановитьПараметр("НачалоПериода", НачалоПериода);
//	 Запрос.УстановитьПараметр("КонецПериода", КонецПериода);
//	 
//	 Результат = Запрос.Выполнить().Выгрузить();
//	 
//	 Если НЕ Запрос.Выполнить().Пустой() Тогда 
//		 
//		 Для каждого ЭлементРезультата Из Результат Цикл
//			 
//			 Попытка
//				 
//				 НовыйДокумент = Документы.РеализацияТоваровУслуг.СоздатьДокумент();
//				 НовыйДокумент.Контрагент = ЭлементРезультата.ДоговорСсылка.Владелец;
//				 НовыйДокумент.Договор	 = ЭлементРезультата.ДоговорСсылка.Ссылка;
//				 НовыйДокумент.Организация = ЭлементРезультата.ДоговорСсылка.Организация;
//				 НовыйДокумент.Ответственный = ПараметрыСеанса.ТекущийПользователь;
//				 НовыйДокумент.Дата		 = ТекущаяДата();
//				 НовыйДокумент.ВыполнитьАвтозаполнение();
//				 НовыйДокумент.Записать(РежимЗаписиДокумента.Проведение,РежимПроведенияДокумента.Оперативный);
//				 
//				 тчДокументы = ЭтотОбъект.Документы.Добавить();
//				 тчДокументы.Договор = НовыйДокумент.Договор.Ссылка;
//				 тчДокументы.Реализация = НовыйДокумент.Ссылка; 
//				 
//			 Исключение
//				 
//				 ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Не удалось создать документ по договору: " + ЭлементРезультата.ДоговорСсылка.Ссылка);
//				 
//			 КонецПопытки;
//			 
//		 КонецЦикла;
//		 
//	 Иначе
//		 
//		 ОбщегоНазначенияКлиентСервер.СообщитьПользователю("За указанный период документы уже созданы");
//		 
//	 КонецЕсли;
//	 
// КонецПроцедуры 
 
Функция ВыполнитьРасчетНеВфоне(Параметры)Экспорт 
	 
	 Параметр1 = Параметры.Параметр1;
	 Параметр2 = Параметры.Параметр2; 
	 Результат = Параметр1+ Параметр2;
	 
	 Возврат Результат;
	 
КонецФункции
 
Процедура ВыполнитьРасчетВФоне(Параметры, АдресРезультата) Экспорт
	 
	 Результат = ВыполнитьРасчетНеВфоне(Параметры);    
	 ПоместитьВоВременноеХранилище(Результат, АдресРезультата);
	 
КонецПроцедуры