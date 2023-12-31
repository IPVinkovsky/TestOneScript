
Перем Статус;
Перем ТаблицаСостоянийФайлов;
Перем ОписаниеСостояния;

Процедура ПриСозданииОбъекта(ВыводКоманды) Экспорт
	Статус = ВыводКоманды;
	ЗаполнитьТаблицу();
КонецПроцедуры

#Область ПрограммныйИнтерфейс

Функция Получить() Экспорт
	Возврат Статус;
КонецФункции

Функция ТаблицаИзменений() Экспорт
	Возврат ТаблицаСостоянийФайлов;
КонецФункции

Функция КДобавлению(КромеИзмененныхВДереве = Ложь) Экспорт
	Массив = Новый Массив();
	Для каждого Стр Из ТаблицаСостоянийФайлов Цикл
		Если СтрНайти("AMURC", Стр.СостояниеВИндексе) > 0 Тогда
			Если КромеИзмененныхВДереве И НЕ ПустаяСтрока(Стр.СостояниеВДереве) Тогда
				Продолжить;
			КонецЕсли;
			Массив.Добавить(Стр.ИмяФайла);
		КонецЕсли; 
	КонецЦикла;
	Возврат Массив;
КонецФункции

Функция КУдалению(УчитыватьПереименование=Истина) Экспорт
	Массив = Новый Массив();
	Для каждого Стр Из ТаблицаСостоянийФайлов Цикл
		Если СтрНайти("D", Стр.СостояниеВИндексе) > 0 Тогда
			Массив.Добавить(Стр.ИмяФайла);
		ИначеЕсли СтрНайти("R", Стр.СостояниеВИндексе) > 0 
			И УчитыватьПереименование Тогда
			Массив.Добавить(Стр.СтароеИмяФайла);
		КонецЕсли; 
	КонецЦикла;
	Возврат Массив;
КонецФункции

Функция ВнеИндекса() Экспорт
	Массив = Новый Массив();
	Для каждого Стр Из ТаблицаСостоянийФайлов Цикл
		Если ПустаяСтрока(Стр.СостояниеВДереве) Тогда
			Продолжить;
		КонецЕсли;
		Массив.Добавить(Стр.ИмяФайла);
	КонецЦикла;
	Возврат Массив;
КонецФункции

Функция НеОтслеживаются() Экспорт
	Массив = Новый Массив();
	Для каждого Стр Из ТаблицаСостоянийФайлов Цикл
		Если СтрНайти("?", Стр.СостояниеВИндексе) > 0 
			Или СтрНайти("?", Стр.СостояниеВИндексе) > 0  Тогда
			Массив.Добавить(Стр.ИмяФайла);
		КонецЕсли; 
	КонецЦикла;
	Возврат Массив;
КонецФункции

#КонецОбласти

Процедура ЗаполнитьТаблицу()

	Для НомерСтроки = 1 По СтрЧислоСтрок(Статус) Цикл
		СтрокаСтатуса = СтрПолучитьСтроку(Статус, НомерСтроки);
		Если ПустаяСтрока(СтрокаСтатуса) Тогда
			Продолжить;
		КонецЕсли;

		Стр = ТаблицаСостоянийФайлов.Добавить();
		Стр.СостояниеВИндексе = Сред(СтрокаСтатуса, 1, 1);
		Стр.СостояниеВДереве = Сред(СтрокаСтатуса, 2, 1);

		ИмяФайла = Сред(СтрокаСтатуса, 4);
		Поз = СтрНайти(ИмяФайла, " -> ");
		Если Поз = 0 Тогда
			Стр.СтароеИмяФайла = "";
			Стр.ИмяФайла = СокрЛП(ИмяФайла);
		Иначе
			Стр.СтароеИмяФайла = СокрЛП(Лев(ИмяФайла, Поз - 1));
			Стр.ИмяФайла = СокрЛП(Сред(ИмяФайла, Поз + 4));
		КонецЕсли;
		
		Стр.ИмяФайла = УбратьКавычки(Стр.ИмяФайла);
		Стр.СтароеИмяФайла = УбратьКавычки(Стр.СтароеИмяФайла);
		
		Стр.ОписаниеСостоянияВИндексе = ОписаниеСостояния[Стр.СостояниеВИндексе];
		Стр.ОписаниеСостоянияВДереве  = ОписаниеСостояния[Стр.СостояниеВДереве];
		
	КонецЦикла;
	
КонецПроцедуры

Функция УбратьКавычки(Знач Строка)
	Если Лев(Строка, 1) = """" И Прав(Строка, 1) = """" Тогда
		Возврат Сред(Строка, 2, СтрДлина(Строка) - 2);
	Иначе
		Возврат Строка;
	КонецЕсли;
КонецФункции

Процедура Инициализация()
	
	ТаблицаСостоянийФайлов = Новый ТаблицаЗначений();
	ТаблицаСостоянийФайлов.Колонки.Добавить("ИмяФайла");
	ТаблицаСостоянийФайлов.Колонки.Добавить("СтароеИмяФайла");
	ТаблицаСостоянийФайлов.Колонки.Добавить("СостояниеВИндексе");
	ТаблицаСостоянийФайлов.Колонки.Добавить("СостояниеВДереве");
	ТаблицаСостоянийФайлов.Колонки.Добавить("ОписаниеСостоянияВИндексе");
	ТаблицаСостоянийФайлов.Колонки.Добавить("ОписаниеСостоянияВДереве");
	
	// Описание состояний 

	//  M        [ MD]   updated in index
	//  A        [ MD]   added to index
	//  D                deleted from index
	//  R        [ MD]   renamed in index
	//  C        [ MD]   copied in index
	//  [MARC]           index and work tree matches
	//  [ MARC]     M    work tree changed since index
	//  [ MARC]     D    deleted in work tree
	//  [ D]        R    renamed in work tree
	//  [ D]        C    copied in work tree
	//  -------------------------------------------------
	//  D           D    unmerged, both deleted
	//  A           U    unmerged, added by us
	//  U           D    unmerged, deleted by them
	//  U           A    unmerged, added by them
	//  D           U    unmerged, deleted by us
	//  A           A    unmerged, both added
	//  U           U    unmerged, both modified
	//  -------------------------------------------------
	//  ?           ?    untracked
	//  !           !    ignored

	ОписаниеСостояния = Новый Соответствие();
	ОписаниеСостояния.Вставить("M", "модифицирован");
	ОписаниеСостояния.Вставить("A", "добавлен");
	ОписаниеСостояния.Вставить("D", "удален");
	ОписаниеСостояния.Вставить("R", "переименован");
	ОписаниеСостояния.Вставить("C", "скопирован");
	ОписаниеСостояния.Вставить("U", "обновлен");
	ОписаниеСостояния.Вставить("?", "не отслеживается");
	ОписаниеСостояния.Вставить("!", "игнорируется");

КонецПроцедуры

Инициализация();