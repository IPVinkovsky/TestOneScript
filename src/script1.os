#Использовать "gitrunner"
ГитРепозиторий = Новый ГитРепозиторий();
ГитРепозиторий.УстановитьРабочийКаталог(ТекущийКаталог());
ГитРепозиторий.ДобавитьФайлВИндекс(".");
ГитРепозиторий.Закоммитить("коммит из комндной строки 3");
Сообщить("Тест");