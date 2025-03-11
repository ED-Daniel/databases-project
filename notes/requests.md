# Примеры запросов к базе

## 1. Подсчет выручки за месяц по продаже эксклюзивных лицензий для трека с ID 4

```sql
SELECT 
    SUM(o.amount) AS total_revenue,
    COUNT(DISTINCT ot.id) AS total_sales,
    DATE_TRUNC('month', o.created_at) AS month
FROM orders o
JOIN order_tracks ot ON o.id = ot.order_id
JOIN licenses l ON ot.license_id = l.id
WHERE l.track_id = 4 
    AND l.name ILIKE '%Exclusive%'
    AND DATE_TRUNC('month', o.created_at) = DATE_TRUNC('month', NOW())
GROUP BY month;
```

## 2. Получение списка пользователей, купивших более 3 лицензий, с их полной информацией

```sql
SELECT 
    u.id, 
    u.email, 
    ui.full_name, 
    ui.nickname, 
    COUNT(ot.id) AS total_licenses_purchased
FROM users u
JOIN user_info ui ON u.id = ui.user_id
JOIN orders o ON u.id = o.user_id
JOIN order_tracks ot ON o.id = ot.order_id
GROUP BY u.id, ui.full_name, ui.nickname
HAVING COUNT(ot.id) > 3
ORDER BY total_licenses_purchased DESC;
```

## 3. Список треков, по которым за последние 6 месяцев было продано более 5 лицензий, с указанием владельцев

```sql
SELECT 
    t.id AS track_id,
    t.name AS track_name,
    u.id AS owner_id,
    u.email AS owner_email,
    COUNT(ot.id) AS total_licenses_sold
FROM tracks t
JOIN users u ON t.owner_id = u.id
JOIN licenses l ON t.id = l.track_id
JOIN order_tracks ot ON l.id = ot.license_id
JOIN orders o ON ot.order_id = o.id
WHERE o.created_at >= NOW() - INTERVAL '6 months'
GROUP BY t.id, u.id
HAVING COUNT(ot.id) > 5
ORDER BY total_licenses_sold DESC;
```

## 4. Определить ТОП-3 реферальных пользователей по количеству приведенных рефералов и их выручке

```sql
SELECT 
    u.id AS referrer_id,
    u.email AS referrer_email,
    COUNT(r.referred_id) AS total_referrals,
    COALESCE(SUM(o.amount), 0) AS total_revenue
FROM users u
JOIN referrals r ON u.id = r.referrer_id
LEFT JOIN orders o ON r.referred_id = o.user_id
GROUP BY u.id
ORDER BY total_referrals DESC, total_revenue DESC
LIMIT 3;
```

## 5. Вывести список пользователей, у которых есть неоплаченные заказы или заказы в статусе 'pending'

```sql
SELECT 
    u.id, 
    u.email, 
    o.id AS order_id, 
    o.amount, 
    o.currency, 
    o.status, 
    o.created_at
FROM users u
JOIN orders o ON u.id = o.user_id
WHERE o.status ILIKE 'pending' OR o.amount = 0
ORDER BY o.created_at DESC;
```

## 6. Получить средний BPM всех треков, проданных за последние 12 месяцев, с разделением по типу лицензии

```sql
SELECT 
    l.name AS license_type,
    AVG(t.bpm) AS avg_bpm,
    COUNT(DISTINCT ot.id) AS total_sales
FROM licenses l
JOIN order_tracks ot ON l.id = ot.license_id
JOIN orders o ON ot.order_id = o.id
JOIN tracks t ON l.track_id = t.id
WHERE o.created_at >= NOW() - INTERVAL '12 months'
GROUP BY l.name
ORDER BY total_sales DESC;
```

## 7. Вывести детальную статистику по продажам для владельцев треков: общее количество продаж, сумма выручки, средняя цена продажи

```sql
SELECT 
    u.id AS owner_id,
    u.email AS owner_email,
    COUNT(DISTINCT ot.id) AS total_sales,
    SUM(o.amount) AS total_revenue,
    AVG(o.amount) AS average_sale_price
FROM users u
JOIN tracks t ON u.id = t.owner_id
JOIN licenses l ON t.id = l.track_id
JOIN order_tracks ot ON l.id = ot.license_id
JOIN orders o ON ot.order_id = o.id
GROUP BY u.id
ORDER BY total_revenue DESC;
```