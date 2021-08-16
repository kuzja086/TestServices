#Область ПрограммныйИнтерфейс
// ВозвращаемоеЗначение:
//	РезультатЗапроса - ТаблицаЗначений - см. Справочник.ТестыHTTPСервисов
Функция ПолучитьДействующиеТесты() Экспорт
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	*
	|ИЗ
	|	Справочник.ТестыHTTPСервисов КАК ТестыHTTPСервисов
	|ГДЕ
	|	ТестыHTTPСервисов.Используется";
	
	РезультатЗапроса = Запрос.Выполнить().Выгрузить();
	
	Возврат РезультатЗапроса;
КонецФункции

// Параметры:
//	Тест - СтрокаТаблицыЗначений - см. ЗапускТестов.ПолучитьДействующиеТесты
Функция ВыполнитьТестовыйЗапрос(Тест) Экспорт
	Если Тест.ТипЗапроса = Перечисления.ТипЗапроса.GET Тогда
		Результат = БОНД_Коннектор.GetJson(Тест.URL);
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

// Сериализует значение в строку JSON
// 
// Параметры:
//  Значение - Произвольный - Значение, которое нужно сериализовать
// 
// Возвращаемое значение:
//  Строка - Сериализованная Строка JSON
Функция СериализоватьРезультат(Значение) Экспорт
	Перем ЗаписьJson;
	Перем JSON;
	ЗаписьJson = Новый ЗаписьJSON();
	ЗаписьJson.УстановитьСтроку();
	СериализаторXDTO.ЗаписатьJSON(ЗаписьJson, Значение);
	JSON = ЗаписьJson.Закрыть();
	Возврат JSON;
КонецФункции

// Сравнивает результат выполнения Запроса с сохранненым эталоном
// 
// Параметры:
//  Результат - Произвольный - Результат выполнения запроса
//  Тест - СправочникСсылка.ТестыHTTPСервисов - Тест в котором сохранен эталон выполнения запроса
Процедура ПроверитьРезультатВыполненияЗапроса(Результат, Тест) Экспорт
	Перем СериализованныйРезультат;
	СериализованныйРезультат = ЗапускТестов.СериализоватьРезультат(Результат);
	
	Если Тест.РезультатЗапроса = СериализованныйРезультат Тогда
		ОбщегоНазначения.СообщитьПользователю("Успех " + Тест.Наименование);
	Иначе
		ОбщегоНазначения.СообщитьПользователю("Ошибка " + Тест.Наименование);
	КонецЕсли;
КонецПроцедуры
#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс
// Код процедур и функций
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
// Код процедур и функций
#КонецОбласти