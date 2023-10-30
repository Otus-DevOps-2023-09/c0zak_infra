# c0zak_infra
c0zak Infra repository

ДЗ 5

Результаты работы.
Общее ДЗ:
	Каталог packer:
	ubuntu16.json - общее дз, использует параметры из variable.json (но параметры, как просили, в .gitignore)
	scripts/*.sh - общие скрипты запуска. Так как в облаке непонятные проблемы с использованием apt из пакера, пришлось добавить цикличный инсталл, пока не встанет.
	Создан дополнительно каталог stubs с файлом key.json, т.к. тест требует чтобы файл по вымышленному пути - существовал. Вы там в порядке вообще?)))
	Вот прям из теста:
	×  Command: `cd packer && packer validate -var-file=variables.json.example ubuntu16.json` stdout should eq "Template validated successfully.\n"
	expected: "Template validated successfully.\n"
        got: "Template validation failed. Errors are shown below.\n\nErrors validating build 'yandex'. 1 error(s) ...rvice account key file: key file 'SOME_PATH' read fail: open SOME_PATH: no such file or directory\n"

-------------------------

Дополнительное задание:
10.1*. Построение bake-образа (по10.1*. Построение bake-образа (по
желанию)желанию)
Чтобы попрактиковать подход к управлению инфраструктурой
Immutable infrastructure, о котором говорили на вебинаре,
попробуйте "запечь" (bake) в образ ВМ все зависимости
приложения и сам код приложения. Результат должен быть таким:
запускаем инстанс из созданного образа и на нем сразу же имеем
запущенное приложение.
Созданный шаблон должен называться immutable.json и
содержаться в директории packer, image_family у получившегося
образа должен быть reddit-full. Дополнительные файлы можно
положить в директорию packer/files. Для запуска приложения при
старте инстанса необходимо использовать systemd unit. Этот образ
можно строить как поверх нашего базового образа, так и поверх
стандартного образа ОС.


Решение:
В каталоге files лежат необходимые файлы, запуск через immutable.json, с использованием variable.json

-------------------------

Дополнительное задание:
Создайте скрипт create-reddit-vm.sh в директории config-
scripts, который будет создавать ВМ с помощью Yandex.Cloud CLI.
В скрипт не нужно включать инициализацию профиля в
Yandex.Cloud.

Скрипт лежит в корне репозитория/config-scripts/create-reddit-vm.sh
Использует изменённый metadata.yaml из каталога packer/files
Создаёт bake образ и запускает машину с ним. Использует переменную folder_id_var из файла variable.json при создании ВМ.

-------------------------

ДЗ 4

Дополнительное задание:
В качестве доп. задания используйте созданные ранее скрипты для создания startup
script , который будет запускаться при создании инстанса.
В результате применения данной команды CLI мы должны получать инстанс с уже
запущенным приложением. Startup скрипт необходимо закомитить, а используемую
команду CLI добавить в описание репозитория (README.md)

Решение:

В репе создан файл metadata.yaml, в котором описан процесс создания пользователя,
сам startup_script и его запуск.

CLI:

yc compute instance create \
 --name reddit-app \
 --hostname reddit-app \
 --memory=4 \
 --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
 --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
 --zone ru-central1-a \
 --metadata serial-port-enable=1 \
 --metadata-from-file user-data=./metadata.yaml

-------------------------

testapp_IP = 158.160.40.104
testapp_port = 9292

-------------------------

ДЗ 3

Исследовать способ подключения к someinternalhost в одну команду из вашего
рабочего устройства, проверить работоспособность найденного решения и внести
его в README.md в вашем репозитории

Решение:

ssh -J bastion_IP someinternalhost

-------------------------

Дополнительное задание:
Предложить вариант решения для подключения из консоли при помощи команды
вида ssh someinternalhost из локальной консоли рабочего устройства, чтобы
подключение выполнялось по алиасу someinternalhost и внести его в README.md в
вашем репозитории


Решение:

Надо запилить конфиг, файл ~/.ssh/config

Добавить в него такие секции:

Host bastion
        Hostname bastion_IP
        User appuser
        IdentityFile ~/.ssh/appuser

Host someinternalhost
        Hostname someinternalhost_IP
        ProxyJump bastion
        User appuser
        IdentityFile ~/.ssh/appuser

После этого можно выполнить просто:
ssh someinternalhost

Кстати, после этого на бастионе можно также авторизоваться без указания ip:
ssh bastion

-------------------------

Дополнительное задание:
Сейчас веб-интерфейс VPN-сервера Pritunl работает с самоподписанным
сертификатом. И браузер постоянно ругается на это.
С помощью сервисов nip.io и реализуйте использование валидного сертификата для
панели управления VPNсервера

Решение:

Во первых вопрос, "С помощью сервисов nip.io и реализуйте" <- это что за чудное задание?))
Предположу что имелось ввиду использование сервиса Let's Encrypt

Решается посредством подстановки внешнего ip адреса vpn сервера с хвостом в виде nip.io
в конфигурацию Pritunl, что и было проделано.

-------------------------

bastion_IP = 84.201.130.36
someinternalhost_IP = 10.128.0.32

-------------------------
