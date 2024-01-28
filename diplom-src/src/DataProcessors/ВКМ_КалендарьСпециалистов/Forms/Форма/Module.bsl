
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	НачалоПериода = НачалоНедели(ТекущаяДата());
	КонецПериода = КонецНедели(ТекущаяДата());
	
	Планировщик.ТекущиеПериодыОтображения.Очистить();
	Планировщик.ТекущиеПериодыОтображения.Добавить(НачалоПериода, КонецПериода);
	
	ОбслуживаниеКлиентов = Документы.ВКМ_ОбслуживаниеКлиента.Выбрать(НачалоПериода, КонецПериода);
	ОбновитьНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПланировщикПередСозданием(Элемент, Начало, Конец, ЗначенияИзмерений, Текст, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ЗначенияЗаполнения = Новый Структура;
	ЗначенияЗаполнения.Вставить("ВКМ_ДатаПроведенияРабот", Начало);
	ЗначенияЗаполнения.Вставить("ВКМ_ВремяНачалаРабот", Начало);
	ЗначенияЗаполнения.Вставить("ВКМ_ВремяОкончанияРабот", Конец);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ЗначенияЗаполнения", ЗначенияЗаполнения);
	ОткрытьФорму("Документ.ВКМ_ОбслуживаниеКлиента.ФормаОбъекта", ПараметрыФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_ВКМ_ОбслуживаниеКлиента" Тогда
		
		ОбновитьНаСервере(); 
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьНаСервере()
		
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ВКМ_ОбслуживаниеКлиента.Ссылка КАК Ссылка,
	|	ВКМ_ОбслуживаниеКлиента.ВКМ_ДатаПроведенияРабот КАК ДатаРабот,
	|	ВКМ_ОбслуживаниеКлиента.ВКМ_ВремяНачалаРабот КАК ВремяС,
	|	ВКМ_ОбслуживаниеКлиента.ВКМ_ВремяОкончанияРабот КАК ВремяПо,
	|	ВКМ_ОбслуживаниеКлиента.ВКМ_Клиент КАК Клиент,
	|	ВКМ_ОбслуживаниеКлиента.Номер КАК Номер,
	|	ВКМ_ОбслуживаниеКлиента.ВКМ_Специалист КАК Специалист
	|ИЗ
	|	Документ.ВКМ_ОбслуживаниеКлиента КАК ВКМ_ОбслуживаниеКлиента
	|ГДЕ
	|	ВКМ_ОбслуживаниеКлиента.ПометкаУдаления = ЛОЖЬ
	|	И ВКМ_ОбслуживаниеКлиента.Проведен = ИСТИНА";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Планировщик.Элементы.Очистить();
	
	Пока Выборка.Следующий() Цикл
		
		ДатаНачала = СоединитьДатуИВремя(Выборка.ДатаРабот, Выборка.ВремяС);
		ДатаКонца = СоединитьДатуИВремя(Выборка.ДатаРабот, Выборка.ВремяПо);
		
		Текст = СтрШаблон("Заказ %1, клиент %2, кому %3", Выборка.Номер, Выборка.Клиент, Выборка.Специалист);
				
		ЭлементПланировщика = Планировщик.Элементы.Добавить(ДатаНачала, ДатаКонца);
		ЭлементПланировщика.Значение = Выборка.Ссылка;
		ЭлементПланировщика.Текст = Текст;
		
	КонецЦикла;	
	
КонецПроцедуры

&НаКлиенте
Процедура Обновить(Команда)
	ОбновитьНаСервере();
КонецПроцедуры

&НаСервереБезКонтекста
Функция СоединитьДатуИВремя(Дата, Время) Экспорт
	
	ДатаСтрока = Формат(Дата, "ДФ=""ггггММдд""");
	ВремяСтрока = Формат(Время, "ДФ=""ЧЧммсс""");
	ДатаВремя = Дата(ДатаСтрока + ВремяСтрока);
	
	Возврат ДатаВремя;
	
КонецФункции  



