# Активный гражданин. Блокчейн для проверки результатов голосования #

Репозиторий содержит конфигурацию для запуска блокчейн-ноды на любой системе для просмотра результатов опросов на сайте [Активный гражданин](https://ag.mos.ru/)

!!! ВАЖНО: Данная инструкция предназначена для продвинутых пользователей ПК, обладающих знаниями английского языка и базовым пониманием принципов работы технологии блокчейн. 

## Инструкция по развертыванию Parity UI (используемая реализация блокчейн) ##

**Установка на Windows**

Установка возможна только на компьютер от имени пользователя, имеющего в системе права локального администратора.

1. Скачать и установить [Parity](https://parity-downloads-mirror.parity.io/v1.7.7/x86_64-pc-windows-msvc/InstallParity.exe). (Версия продукта подходит только для 64-х разрядных операционных систем).
2. В трее найти значок Parity, нажать правой клавишей мыши и выбрать Exit. 
3. Найти папку, куда установилась программа `parity.exe` (обычно `C:\Program Files\Parity\Parity`) и перейти в нее.
4. Открыть [ссылку](https://raw.githubusercontent.com/moscow-technologies/ag-blockchain/master/parity/config/chain.json) и сохранить файл, нажав (`Ctrl+S`). В появившемся окне "Сохранить как", выбрать тип файла "Все файлы" поменять наименование файла на `chain.json` произвести сохранение файла в произвольную папку на совем компьютере, например в "Загрузки".
5. Перейти в папку, в которой был сохранен файл и скопировать файл `chain.json` в папку, куда была установлена программа. (см. п. 3 Инструкции). Для сохранения потребуются права адменистратора, в появивишемся окне нажать "Продолжить". 
6. Открыть командную строку (нажать `Windows+R` и напечатать `cmd`, нажать `Выполнить`)
7. Перейти в папку с `parity.exe` введя команду `cd C:\Program Files\Parity\Parity`
8. В командной строке выполнить `parity ui --bootnodes   enode://9076c143a487aa163437a86f7d009f257f405c50bb2316800b9c9cc40e5a38fef5b414a47636ec38fdabc8a1872b563effa8574a7f8f85dc6bde465c368f1bf5@213.79.88.177:30303 --chain chain.json`
9. Откроется веб-интерфейс, дальше выполнить пункты из `Инструкция по просмотру результатов опросов`
10. Убедиться, что в правом нижнем углу веб-страницы, в зеленом прямоуголькике отобразилась надпись `ACTIVECITIZENPROD` - это свидетельствует о том, что подключение к нужному блокчейн прошло успешно.
11. В случае если в зеленом прямоугольнике отобразилась надпись `FOUNDATION`, это свидельствует о том, что какой-то из шагов был выполнен неверно, для этого:
  11.1. Убедиться, что в трее НЕ запущено приложение Parity (шаг №2);
  11.2. Убедиться, что файл сохранен в нужном формате. Для этого нажать на файл `chain.json` правой кнопкой мыши, выбрать `Свойства` и убедиться, что тип файла отображается как `Файл "JSON" (.json)` (шаг №4)
  11.3. Убедиться, что в папке с программой размещен файл `chain.json` (шаг №5).
  Каждое из указанных условий п.11 должно быть выполнено. В случае если какакое-то условие не было выполнено, повторить все последующие шаги инструкции с указанного пункта.


**Установка на MacOS**
1. Открыть терминал и выполнить `brew tap paritytech/paritytech` а затем `brew install parity --v1.7.9`
2. Открыть [ссылку](https://raw.githubusercontent.com/moscow-technologies/ag-blockchain/master/parity/config/chain.json) и сохранить файл `chain.json` (`Ctrl+S`) в произвольную папку (сохранить как: Программный код страницы, оставив в названии файла только chain.json)
3. Перейти в папку с `chain.json` командой в терминале `cd ` и далее путь к файлу, например 
cd /users/nameuser/desktop/parity/
4. Выполнить `parity ui --bootnodes   enode://9076c143a487aa163437a86f7d009f257f405c50bb2316800b9c9cc40e5a38fef5b414a47636ec38fdabc8a1872b563effa8574a7f8f85dc6bde465c368f1bf5@213.79.88.177:30303 --chain chain.json`
5. Откроется веб-интерфейс, дальше выполнить пункты из `Инструкция по просмотру результатов опросов`

ВАЖНО!
Во время установки приложения через терминал, обратите внимания на указания, выдаваемые терминалом, например: необходимость обновить версию самого терминала и т.п.

**Установка в Docker (любая ОС)**

****Предварительно выполнить****

1. Установить и запустить [Docker](https://www.docker.com) (все необходимые требования и инструкции по установке есть на указанном сайте) 
2. Установить git ([Git for Windows](https://git-for-windows.github.io/), [Git for Linux](https://git-scm.com/book/ru/v1/%D0%92%D0%B2%D0%B5%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5-%D0%A3%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-Git)) для того, чтобы скачать необходимую для блокчейн конфигурацию из репозитория.

****Выполняем следующие команды в bash (для Linux и MacOS) или powershell (для Windows, от имени администратора):****

0. Скачиваем конфигурацию из репозитория ```git clone https://github.com/moscow-technologies/ag-blockchain.git```
1. Переходим в каталог с конфигурацией ```cd ag-blockchain```
2. Запускаем parity командой ```docker-compose up -d```
3. Выполняем `docker-compose logs | grep token=` и копируем токен (идет после `token=` примерно такой `Q7J9-ofgq-EEJU-9nVt`) для авторизации в Parity UI 
4. Нода запущена, должна пойти ее синхронизация с блокчейном. 
5. Далее можно зайти в [ее веб-интерфейс](http://localhost:8180) и выолнить его настройку для просмотра результатов опросов
(Система запросит токен, вводим полученный предыдущей командой, вводим его)

## Инструкция по просмотру результатов опросов ##

**Используя Parity UI, можно узнать общую статистику по конкретному опросу, а также как голосовал конкретный пользователь (по его личному UID). Для этого выполняем следующие действия:**

1. Принимаем условия лицензионного соглашения, а также создаем аккаунт в системе (логин и пароль - `user`) 
2. Переходим в раздел [Settings](http://localhost:8180/#/settings/views) и включаем галочку напротив пункта `Contracts`
3. Переходим в раздел [Status](http://localhost:8180/#/status). Должна идти синхронизация блоков (число напротив надписи `Best block` растет быстрее чем на единицу в секунду). Второе число в `Peers` должно быть больше 0 (если синхронизация работает корректно)!
4. Дожидаемся окончания синхронизации надпись `Chain synchronized (yes)`
5. Переходим в раздел [Contracts](http://localhost:8180/#/contracts)
6. Для просмотра адресов смарт-контрактов опросов в блокчейн необходимо добавить в просмотр корневой контракт. 
7. Нажимаем `Watch`, появляется мастер, в нем на первом шаге жмем `Next`
8. На втором шаге в поле `network address` вводдим значение ```0xFDb76DaAF371bf5C7122f6f1104458440454FBB1```, в поле `contract name` пишем `Каталог опросов`, в поле `contract abi` - содержимое файла `conracts/Root.abi` данного репозитория ([Ссылка](https://github.com/moscow-technologies/ag-blockchain/blob/master/contracts/Root.abi)) и нажимаем `Add contract`
9. Заходим в разделе `Contracts` в `Каталог опросов` и в поле под надписью getAddress вставляем идентификатор опроса на [АГ](https://ag.mos.ru/poll/index), жмем `Query`. Получаем адрес смарт-контракта с соответствующим опросом, копируем его в буфер обмена
10. Возвращаемся в раздел `Contracts`, добавляем в просмотр смарт-контракт опроса: нажимаем `Watch`, `Next`, дальше в поле`network address` - адрес из буфера обмена, `contract name` - будущее название контракта в списке (например `Опрос 3196`), `contract abi` - сожержимое файла `contracts/Poll.abi` из репозитория ([Ссылка](https://github.com/moscow-technologies/ag-blockchain/blob/master/contracts/Poll.abi)), нажимаем `AddContract`
11. Заходим в раздел `Contracts` в просмотр смарт-контракта `Опрос 3196`. Здесь хранится соответствие идентификатора вопроса на АГ и адреса смарт-контрактов вопросов (разделы `QuestionIds` и `QuestionsAddress`), копируем адрес. Аналогично, необходимо копировать адреса смарт-контрактов и добавлять в разделе `Contracts` - `Watch` смарт-контракты, хранящие описание, ответы и результаты голосования по конкретному вопросу опроса. В первое поле вставляем адрес, во второе - название (например `Опрос 3195 Вопрос1`), в поле `contract abi` - содержимое файла `contracts/PollQuestion.abi` из репозитория ([Ссылка](https://github.com/moscow-technologies/ag-blockchain/blob/master/contracts/PollQuestion.abi)). Нажимаем `AddContract`
12. Переходим в просмотр вопроса и видим содержимое блокчейн

- Идентификатор `QuestionId` 
- Заголовок вопроса `CurrentVersionTitle` 
- Количество проголосовавших `VoterCount`
- Идентифиторы версий опроса `AllExistingVersions` (каждое изменение опроса ведет к созданию версии, голоса по разным версия считаются отдельно)
- Идентифитор текущей версии `CurrentVersion`
- Количество голосов за каждый из ответов в списке `CurrentVersionResults` (в порядке из идентификаторов, совпадает с порядком на сайте АГ)
- Запрос `_versions` c указанием идентификатора версии возвращает название вопроса и список ответов с идентификаторами (формат JSON) в указанной версии 
- Запрос `AnswerIdsByVersion` c указанием идентификатора версии возвращает список идентификаторов ответов с портала АГ в указанной версии
- Запрос `AnswersByVersion` c указанием идентификатора версии возвращает список ответов с идентификаторами (формат JSON) в указанной версии 
- Запрос `ResultsByVersion` c указанием идентификатора версии возвращает количество голосов за каждый из ответов в указанной версии
- Запрос `VoteOfUser` с указанием UID пользователя на сайте АГ возвращает номер ответа за который голосовал пользователь `result` и хэш ответа, если пользователь вводил текст ответа `value1`, `value2`
