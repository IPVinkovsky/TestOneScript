#Использовать "gitrunner"
ГитРепозиторий = Новый ГитРепозиторий();
ГитРепозиторий.УстановитьРабочийКаталог(ТекущийКаталог());
ГитРепозиторий.ДобавитьФайлВИндекс(".");
ГитРепозиторий.Закоммитить("коммит из комндной строки 3");
ГитРепозиторий.Отправить("https://github.com/IPVinkovsky/TestOneScript", "Change1");
Сообщить("Тест");