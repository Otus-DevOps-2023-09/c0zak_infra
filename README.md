# c0zak_infra
c0zak Infra repository

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


bastion_IP = 84.201.130.36
someinternalhost_IP = 10.128.0.32
