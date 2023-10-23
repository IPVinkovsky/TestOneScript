#Использовать "gitrunner"
Перем ИмяРепозитория;
Перем ЛокальныйКаталогРепозитория;

Процедура ОпределитьИмяРепозитория()
	ЧтениеJson = Новый ЧтениеJson;
	ЧтениеJson.ОткрытьФайл("src/config.json");
	НастройкиИзJson = ПрочитатьJSON(ЧтениеJson);
	ЧтениеJson.Закрыть();
	ИмяРепозитория = НастройкиИзJson.repositoryName;
	ЛокальныйКаталогРепозитория = НастройкиИзJson.reositoryLocalName;
	ЛокальныйКаталогРепозитория = СтрЗаменить(ЛокальныйКаталогРепозитория,"/","\");
КонецПроцедуры

Процедура ВыполнитьКоммитИОтправитьВетку()

	ГитРепозиторий = Новый ГитРепозиторий();

	

	Если ЗначениеЗаполнено(ЛокальныйКаталогРепозитория) Тогда
		ТекущийКаталогРепозитория = ЛокальныйКаталогРепозитория;
	Иначе
		ТекущийКаталогРепозитория = ТекущийКаталог();
	КонецЕсли;

	ГитРепозиторий.УстановитьРабочийКаталог(ТекущийКаталогРепозитория);
	ТекущаяВетка = ГитРепозиторий.ПолучитьТекущуюВетку();
	ГитРепозиторий.ДобавитьФайлВИндекс(".");
	ГитРепозиторий.Закоммитить("коммит из комндной строки 5");
	ГитРепозиторий.Отправить(ИмяРепозитория, ТекущаяВетка);
	
	
КонецПроцедуры
ОпределитьИмяРепозитория();
Сообщить(ЛокальныйКаталогРепозитория);
ВыполнитьКоммитИОтправитьВетку();
Сообщить("Готово");