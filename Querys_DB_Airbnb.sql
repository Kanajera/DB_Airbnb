// 1. CONSULTAS BÁSICAS
SELECT * FROM users;

// 2. Obtener todas las habitaciones publicadas
SELECT id, home_type, room_type, price
FROM rooms;

// 3. Listar todas las reservas con fechas
SELECT id, user_id, room_id, start_date, end_date
FROM reservations;

//4. CONSULTAS CON JOINS Mostrar reservas con nombre del usuario y dirección del room
SELECT 
  r.id AS reservation_id,
  u.name AS user_name,
  rm.address AS room_address,
  r.start_date,
  r.end_date
FROM reservations r
JOIN users u ON r.user_id = u.id
JOIN rooms rm ON r.room_id = rm.id;

//5. Mostrar reviews con nombre del usuario que hizo la reserva
SELECT 
  rv.id AS review_id,
  u.name AS reviewer,
  rv.rating,
  rv.comment
FROM reviews rv
JOIN reservations r ON rv.reservation_id = r.id
JOIN users u ON r.user_id = u.id;

//6. CONSULTAS CON AGREGACIONES Contar número de reservas por usuario
SELECT 
  u.name,
  COUNT(r.id) AS total_reservations
FROM users u
LEFT JOIN reservations r ON u.id = r.user_id       
GROUP BY u.id, u.name;

//8. Calcular el ingreso total generado por cada room
SELECT 
  rm.id AS room_id,
  rm.address,
  SUM(r.total) AS total_income  
FROM rooms rm
JOIN reservations r ON rm.id = r.room_id
GROUP BY rm.id, rm.address; 

//9. Promedio de calificaciones por room
SELECT 
  rm.id AS room_id,
  rm.address,
  AVG(rv.rating) AS average_rating
FROM rooms rm
JOIN reservations r ON rm.id = r.room_id
JOIN reviews rv ON r.id = rv.reservation_id
GROUP BY rm.id, rm.address;

//10. CONSULTAS CON FILTROS Y ORDENAMIENTOS Obtener rooms con precio mayor a 100 ordenados por precio descendente
SELECT 
  id,
  address,
  price
FROM rooms
WHERE price > 100
ORDER BY price DESC;

//11. Listar usuarios que han hecho más de 2 reservas
SELECT 
  u.id,
  u.name,
  COUNT(r.id) AS reservation_count
FROM users u
JOIN reservations r ON u.id = r.user_id
GROUP BY u.id, u.name
HAVING COUNT(r.id) > 2;

//12. Mostrar reviews con calificación menor a 3
SELECT 
  rv.id,
  u.name AS reviewer,
  rv.rating,
  rv.comment
FROM reviews rv
JOIN reservations r ON rv.reservation_id = r.id
JOIN users u ON r.user_id = u.id
WHERE rv.rating < 3;

//13. Reservations hechas por usuarios con email verificado
SELECT r.*
FROM reservations r
JOIN users u ON r.user_id = u.id
WHERE u.email_verified_at IS NOT NULL;

//14. Rooms que tienen TV e Internet
SELECT  
  id,
  address,
  has_tv,
  has_internet              
FROM rooms
WHERE has_tv = true AND has_internet = true;

//15. Número total de reservas
SELECT COUNT(*) AS total_reservations
FROM reservations;

//16. Usuarios que han hecho al menos una reserva
SELECT *
FROM users
WHERE id IN (
  SELECT DISTINCT user_id
  FROM reservations
);

//17. Rooms sin reservas

SELECT 
  rm.id,
  rm.address    
FROM rooms rm
LEFT JOIN reservations r ON rm.id = r.room_id
WHERE r.id IS NULL; 

//18. Reviews con comentarios que contienen la palabra 'excelente'
SELECT
    rv.id,
    u.name AS reviewer,
    rv.rating,
    rv.comment  
FROM reviews rv
JOIN reservations r ON rv.reservation_id = r.id
JOIN users u ON r.user_id = u.id
WHERE rv.comment ILIKE '%excelente%';  

//19.Usuarios con mayor gasto total
SELECT 
  u.id,
  u.name,
  SUM(res.total) AS total_spent
FROM users u
JOIN reservations res ON u.id = res.user_id
GROUP BY u.id
ORDER BY total_spent DESC;

//20.Ganancias por ciudad (derivado de address)
SELECT 
  SUBSTRING(rm.address FROM '^[^,]+') AS city,
  SUM(res.total) AS total_earnings
FROM rooms rm
JOIN reservations res ON rm.id = res.room_id
GROUP BY city
ORDER BY total_earnings DESC;

    // 21. CONSULTAS CON VENTANAS (WINDOW FUNCTIONS)
   // Ranking de habitaciones por precio
   SELECT 
  id,
  address,
  price,
  RANK() OVER (ORDER BY price DESC) AS price_rank
FROM rooms;

//22.Ranking de usuarios por cantidad de reservas
SELECT 
  u.id,
  u.name,
  COUNT(r.id) AS reservation_count,
  RANK() OVER (ORDER BY COUNT(r.id) DESC) AS reservation_rank
FROM users u
LEFT JOIN reservations r ON u.id = r.user_id
GROUP BY u.id, u.name;

//23. Ingreso acumulado por room ordenado por fecha de reserva  
SELECT 
  rm.id AS room_id,
  rm.address,
  r.start_date,
  SUM(r.total) OVER (PARTITION BY rm.id ORDER BY r.start_date) AS cumulative_income
FROM rooms rm
JOIN reservations r ON rm.id = r.room_id
ORDER BY rm.id, r.start_date;

