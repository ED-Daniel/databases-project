# Работа по базам данных
## Магазин битов/треков

### Информация о базе
Соотвествует 3NF

### Полезные команды
#### Залогиниться под пользователем базы
```sh
psql -U sales_user -d bdsm -h postgres -W
```

#### Вызов процедур
```sql
CALL add_user_with_info(
    'new_user@example.com',
    'SuperSecurePass123',
    'Иван Иванов',
    'ivan_the_best',
    'Люблю SQL!'
);
```