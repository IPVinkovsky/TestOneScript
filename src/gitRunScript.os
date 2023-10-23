#Использовать "gitrunner"
Перем ИмяРепозитория;
Перем ЛокальныйКаталогРепозитория;

Процедура ОпределитьНастройки()
	ЧтениеJson = Новый ЧтениеJson;
	ЧтениеJson.ОткрытьФайл("src/config.json");
	НастройкиИзJson = ПрочитатьJSON(ЧтениеJson);
	ЧтениеJson.Закрыть();
	ИмяРепозитория = НастройкиИзJson.repositoryName;
	ЛокальныйКаталогРепозитория = НастройкиИзJson.reositoryLocalName;
	ЛокальныйКаталогРепозитория = СтрЗаменить(ЛокальныйКаталогРепозитория,"/","\");
КонецПроцедуры

Процедура ЗаписатьКоммитИОтправитьВетку()

	ГитРепозиторий = Новый ГитРепозиторий();

	

	Если ЗначениеЗаполнено(ЛокальныйКаталогРепозитория) Тогда
		ТекущийКаталогРепозитория = ЛокальныйКаталогРепозитория;
	Иначе
		ТекущийКаталогРепозитория = ТекущийКаталог();
	КонецЕсли;

	ГитРепозиторий.УстановитьРабочийКаталог(ТекущийКаталогРепозитория);
	ТекущаяВетка = ГитРепозиторий.ПолучитьТекущуюВетку();
	ГитРепозиторий.ДобавитьФайлВИндекс(".");
	ГитРепозиторий.Закоммитить("коммит из комндной строки "+СокрЛП(ТекущаяДата()),,,,,,ТекущаяДата());
	ГитРепозиторий.Отправить(ИмяРепозитория, ТекущаяВетка);
	
	
КонецПроцедуры
ОпределитьНастройки();
ЗаписатьКоммитИОтправитьВетку();
Сообщить("Готово");