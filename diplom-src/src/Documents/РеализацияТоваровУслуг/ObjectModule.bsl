
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Ответственный = Пользователи.ТекущийПользователь();
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ЗаказПокупателя") Тогда
		ЗаполнитьНаОснованииЗаказаПокупателя(ДанныеЗаполнения);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	СуммаДокумента = Товары.Итог("Сумма") + Услуги.Итог("Сумма");
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, Режим)

	Движения.ОбработкаЗаказов.Записывать = Истина;
	Движения.ОстаткиТоваров.Записывать = Истина;
	
	Движение = Движения.ОбработкаЗаказов.Добавить();
	Движение.Период = Дата;
	Движение.Контрагент = Контрагент;
	Движение.Договор = Договор;
	Движение.Заказ = Основание;
	Движение.СуммаОтгрузки = СуммаДокумента;

	Для Каждого ТекСтрокаТовары Из Товары Цикл
		Движение = Движения.ОстаткиТоваров.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Период = Дата;
		Движение.Контрагент = Контрагент;
		Движение.Номенклатура = ТекСтрокаТовары.Номенклатура;
		Движение.Сумма = ТекСтрокаТовары.Сумма;
		Движение.Количество = ТекСтрокаТовары.Количество;
	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// repin_pv 16.11.23 {{{
Процедура ВыполнитьАвтозаполнение() Экспорт 
	
	НачалоПериода = НачалоМесяца(ТекущаяДатаСеанса());
	КонецПериода = КонецМесяца(ТекущаяДатаСеанса());
	Клиент = ЭтотОбъект.Контрагент;
	
	НоменклатураАбонентскаяПлата = Константы.ВКМ_НоменклатураАбонентскаяПлата.Получить();
	НоменклатураРаботыСпециалиста = Константы.ВКМ_НоменклатураРаботыСпециалиста.Получить();
		
	Если НЕ ЗначениеЗаполнено(Константы.ВКМ_НоменклатураАбонентскаяПлата.Получить()) 
		ИЛИ НЕ ЗначениеЗаполнено(Константы.ВКМ_НоменклатураРаботыСпециалиста.Получить()) Тогда 
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Заполните константы");
		ЭтотОбъект.Услуги.Очистить();
		Возврат
		
	Иначе 
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВКМ_ВыполненныеКлиентуРаботыОстаткиИОбороты.ВКМ_Клиент КАК Клиент,
		|	ВКМ_ВыполненныеКлиентуРаботыОстаткиИОбороты.ВКМ_Договор.ВКМ_СуммаАбонентскойПлаты КАК АбонентскаяПлата,
		|	ВКМ_ВыполненныеКлиентуРаботыОстаткиИОбороты.ВКМ_Договор.ВКМ_СтоимостьЧасаРаботы КАК СтоимостьЧасаРаботы,
		|	ВКМ_ВыполненныеКлиентуРаботыОстаткиИОбороты.КоличествоЧасовПриход КАК ВсегоЧасов,
		|	ВКМ_ВыполненныеКлиентуРаботыОстаткиИОбороты.СуммаКОплатеПриход КАК СуммаКОплате
		|ИЗ
		|	РегистрНакопления.ВКМ_ВыполненныеКлиентуРаботы.ОстаткиИОбороты(&НачалоПериода, &КонецПериода, , ДвиженияИГраницыПериода, ) КАК ВКМ_ВыполненныеКлиентуРаботыОстаткиИОбороты
		|ГДЕ
		|	ВКМ_ВыполненныеКлиентуРаботыОстаткиИОбороты.ВКМ_Клиент.Ссылка = &Клиент";
		
		Запрос.УстановитьПараметр("КонецПериода", КонецПериода);
		Запрос.УстановитьПараметр("НачалоПериода", НачалоПериода);
		Запрос.УстановитьПараметр("Клиент", Клиент);
		
		Выборка = Запрос.Выполнить().Выбрать();
		
		Пока Выборка.Следующий() Цикл
			
			Если Выборка.АбонентскаяПлата > 0 Тогда
				
				ЭтотОбъект.Услуги.Очистить();				
				СтрокаСостава = ЭтотОбъект.Услуги.Добавить();
				СтрокаСостава.Номенклатура = НоменклатураАбонентскаяПлата;
				СтрокаСостава.Количество = 1;
				СтрокаСостава.Цена = Выборка.АбонентскаяПлата;
				СтрокаСостава.Сумма = Выборка.АбонентскаяПлата;
				
			Иначе 
				
				ЭтотОбъект.Услуги.Очистить();
				СтрокаСостава = ЭтотОбъект.Услуги.Добавить();
				СтрокаСостава.Номенклатура = НоменклатураРаботыСпециалиста;
				СтрокаСостава.Количество = Выборка.ВсегоЧасов;
				СтрокаСостава.Цена = Выборка.СтоимостьЧасаРаботы;
				СтрокаСостава.Сумма = Выборка.СуммаКОплате;
								
			КонецЕсли;
						
		КонецЦикла;
				
	КонецЕсли;
	
КонецПроцедуры
// }}} repin_pv 16.11.23 

Процедура ЗаполнитьНаОснованииЗаказаПокупателя(ДанныеЗаполнения)
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ЗаказПокупателя.Организация КАК Организация,
	               |	ЗаказПокупателя.Контрагент КАК Контрагент,
	               |	ЗаказПокупателя.Договор КАК Договор,
	               |	ЗаказПокупателя.СуммаДокумента КАК СуммаДокумента,
	               |	ЗаказПокупателя.Товары.(
	               |		Ссылка КАК Ссылка,
	               |		НомерСтроки КАК НомерСтроки,
	               |		Номенклатура КАК Номенклатура,
	               |		Количество КАК Количество,
	               |		Цена КАК Цена,
	               |		Сумма КАК Сумма
	               |	) КАК Товары,
	               |	ЗаказПокупателя.Услуги.(
	               |		Ссылка КАК Ссылка,
	               |		НомерСтроки КАК НомерСтроки,
	               |		Номенклатура КАК Номенклатура,
	               |		Количество КАК Количество,
	               |		Цена КАК Цена,
	               |		Сумма КАК Сумма
	               |	) КАК Услуги
	               |ИЗ
	               |	Документ.ЗаказПокупателя КАК ЗаказПокупателя
	               |ГДЕ
	               |	ЗаказПокупателя.Ссылка = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", ДанныеЗаполнения);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Не Выборка.Следующий() Тогда
		Возврат;
	КонецЕсли;
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, Выборка);
	
	ТоварыОснования = Выборка.Товары.Выбрать();
	Пока ТоварыОснования.Следующий() Цикл
		ЗаполнитьЗначенияСвойств(Товары.Добавить(), ТоварыОснования);
	КонецЦикла;
	
	УслугиОснования = Выборка.Услуги.Выбрать();
	Пока ТоварыОснования.Следующий() Цикл
		ЗаполнитьЗначенияСвойств(Услуги.Добавить(), УслугиОснования);
	КонецЦикла;
	
	Основание = ДанныеЗаполнения;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
