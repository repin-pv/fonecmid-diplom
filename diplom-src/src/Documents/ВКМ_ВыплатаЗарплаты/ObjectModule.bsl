
Процедура ОбработкаПроведения(Отказ, Режим)

	// регистр ВКМ_ВзаиморасчетыССотрудниками Расход
	Движения.ВКМ_ВзаиморасчетыССотрудниками.Записывать = Истина;
	Для Каждого ТекСтрокаВыплаты Из Выплаты Цикл
		Движение = Движения.ВКМ_ВзаиморасчетыССотрудниками.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Период = Дата;
		Движение.Сотрудник = ТекСтрокаВыплаты.Сотрудник;
		Движение.Сумма = ТекСтрокаВыплаты.Сумма;
	КонецЦикла;

	
КонецПроцедуры
