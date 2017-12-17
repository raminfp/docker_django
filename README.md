
### Docker container for django development in Ubuntu 17.10

[How Installing Docker on Ubuntu 17.10 Artful?](https://gist.github.com/raminfp/fa78bfd8a12274aa159513ee96f2438e)

```terminal
root@raminfp$ sudo docker-compose up

root@raminfp$ sudo docker build -t ubuntu_django:v1 .

root@raminfp$ sudo docker-compose -f docker-compose.yml run web python manage.py runserver

root@raminfp$ sudo docker run -i -t ubuntu_django:v1 /bin/bash
```
