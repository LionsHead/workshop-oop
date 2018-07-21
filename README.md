# ConverterFeed

Утилита выводит результат в STDOUT.
Исходный feed может быть локальным файлом, stdin, так и http адресом по которому нужно его забрать.

```
$ bin/convert-feed --out rss data/feed.xml
$ cat data/feed.xml | bin/convert_feed.rb --out atom
$ bin/convert-feed --out atom https://ru.hexlet.io/lessons.rss
```
