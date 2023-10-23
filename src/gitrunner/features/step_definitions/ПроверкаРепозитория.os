// Реализация шагов BDD-фич/сценариев c помощью фреймворка https://github.com/artbear/1bdd

#Использовать tempfiles

Перем БДД; //контекст фреймворка 1bdd

// Метод выдает список шагов, реализованных в данном файле-шагов
Функция ПолучитьСписокШагов(КонтекстФреймворкаBDD) Экспорт
	БДД = КонтекстФреймворкаBDD;

	ВсеШаги = Новый Массив;

	ВсеШаги.Добавить("ЯПроверяюСуществованиеРепозиторияВоВременномКаталогеИРезультатСохраняюВКонтекст");
	ВсеШаги.Добавить("РезультатРавен");
	
	Возврат ВсеШаги;
КонецФункции

// Реализация шагов

// Процедура выполняется перед запуском каждого сценария
Процедура ПередЗапускомСценария(Знач Узел) Экспорт
	
КонецПроцедуры

// Процедура выполняется после завершения каждого сценария
Процедура ПослеЗапускаСценария(Знач Узел) Экспорт

КонецПроцедуры

//Я проверяю существование репозитория во временном каталоге и результат сохраняю в контекст
Процедура ЯПроверяюСуществованиеРепозиторияВоВременномКаталогеИРезультатСохраняюВКонтекст() Экспорт
	 ГитРепозиторий = БДД.ПолучитьИзКонтекста("ГитРепозиторий");
	 ВременныйКаталог = БДД.ПолучитьИзКонтекста("ВременныйКаталог");
	 ГитРепозиторий.УстановитьРабочийКаталог(ВременныйКаталог);
	 Результат = ГитРепозиторий.ЭтоРепозиторий();
	 БДД.СохранитьВКонтекст("Результат", Результат);
 КонецПроцедуры

 //Результат равен
Процедура РезультатРавен(Знач ОжидаемыйРезультат) Экспорт
	Результат = БДД.ПолучитьИзКонтекста("Результат");
	Ожидаем.Что(Результат).Равно(Булево(ОжидаемыйРезультат));
КонецПроцедуры
 