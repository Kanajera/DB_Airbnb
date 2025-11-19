CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  email VARCHAR UNIQUE,
  email_verified_at TIMESTAMP,
  password VARCHAR,
  remember_token VARCHAR,
  updated_at TIMESTAMP,
  phone_number VARCHAR,
  description VARCHAR,
  profile_image VARCHAR,
  created_at TIMESTAMP DEFAULT now()
);

INSERT INTO users (id, name, email, email_verified_at, password, phone_number, description, profile_image, created_at)
VALUES
(1,'Carlos Ruiz','carlos@example.com',now(),'pass123','+34123456789','Viajero frecuente','img_carlos.jpg',now()),
(2,'Ana López','ana@example.com',now(),'pass123','+34987654321','Amante del mar','img_ana.jpg',now()),
(3,'Jorge Martínez','jorge@example.com',NULL,'pass123','+34666666666','Fotógrafo','img_jorge.jpg',now()),
(4,'María Gómez','maria@example.com',now(),'pass123','+34777777777','Host amigable','img_maria.jpg',now()),
(5,'Lucía Pérez','lucia@example.com',now(),'pass123','+34555555555','Turista curiosa','img_lucia.jpg',now()),
(6,'David Torres','david@example.com',now(),'pass123','+34111111111','Fan de viajes largos','img_david.jpg',now()),
(7,'Sofía Herrera','sofia@example.com',NULL,'pass123','+34222222222','Amante del café','img_sofia.jpg',now()),
(8,'Pedro García','pedro@example.com',now(),'pass123','+34333333333','Explorador urbano','img_pedro.jpg',now()),
(9,'Laura Díaz','laura@example.com',NULL,'pass123','+34444444444','Diseñadora','img_laura.jpg',now()),
(10,'Miguel Santana','miguel@example.com',now(),'pass123','+34543212345','Arquitecto','img_miguel.jpg',now()),
(11,'Valeria Navarro','valeria@example.com',now(),'pass123','+34121212121','Amante del arte','img_valeria.jpg',now()),
(12,'Tomás Ferreyra','tomas@example.com',now(),'pass123','+34989898989','Chef profesional','img_tomas.jpg',now()),
(13,'Daniel Rivas','daniel@example.com',NULL,'pass123','+34959595959','Nómada digital','img_daniel.jpg',now()),
(14,'Carmen Jiménez','carmen@example.com',now(),'pass123','+34949494949','Profesora','img_carmen.jpg',now()),
(15,'Hugo Salas','hugo@example.com',now(),'pass123','+34878787878','Deportista','img_hugo.jpg',now());


CREATE TABLE rooms (
  id SERIAL PRIMARY KEY,
  home_type VARCHAR,
  room_type VARCHAR,
  total_occupancy INT,
  total_bedrooms INT,
  total_bathrooms INT,
  summary VARCHAR,
  address VARCHAR,
  has_tv BOOLEAN,
  has_kitchen BOOLEAN,
  has_air_con BOOLEAN,
  has_heating BOOLEAN,
  has_internet BOOLEAN,
  price INT,
  published_at TIMESTAMP,
  owner_id INT,
  created_at TIMESTAMP DEFAULT now(),
  updated_at TIMESTAMP DEFAULT now(),
  latitude FLOAT,
  longitude FLOAT
);
CREATE TABLE reservations (
  id SERIAL PRIMARY KEY,
  user_id INT,
  room_id INT,
  start_date TIMESTAMP,
  end_date TIMESTAMP,
  price INT,
  total INT,
  created_at TIMESTAMP DEFAULT now(),
  updated_at TIMESTAMP DEFAULT now()
);
CREATE TABLE reviews (
  id SERIAL PRIMARY KEY,
  reservation_id INT,
  rating INT,
  comment VARCHAR
);
CREATE TABLE media (
  id SERIAL PRIMARY KEY,
  model_id INT,
  model_type VARCHAR,
  file_name VARCHAR,
  mime_type VARCHAR
);
ALTER TABLE reservations
  ADD CONSTRAINT reservations_user_fk
  FOREIGN KEY (user_id) REFERENCES users(id);

  ALTER TABLE reservations
  ADD CONSTRAINT reservations_room_fk
  FOREIGN KEY (room_id) REFERENCES rooms(id);
  
ALTER TABLE reviews
  ADD CONSTRAINT reviews_reservation_fk
  FOREIGN KEY (reservation_id) REFERENCES reservations(id);

INSERT INTO rooms (id, home_type, room_type, total_occupancy, total_bedrooms, total_bathrooms, summary, address,
  has_tv, has_kitchen, has_air_con, has_heating, has_internet, price, published_at, owner_id, created_at, latitude, longitude)
VALUES
(1,'Apartment','Entire place',4,2,1,'Moderno y céntrico','Madrid, España',true,true,true,true,true,80,now(),1,now(),40.4168,-3.7038),
(2,'House','Entire place',6,3,2,'Casa familiar luminosa','Barcelona, España',true,true,true,true,true,120,now(),2,now(),41.3851,2.1734),
(3,'Studio','Private room',2,1,1,'Estudio compacto','Valencia, España',true,true,false,true,true,45,now(),3,now(),39.4699,-0.3763),
(4,'Villa','Entire place',8,4,3,'Villa con piscina','Málaga, España',true,true,true,true,true,200,now(),4,now(),36.7213,-4.4217),
(5,'Cabin','Entire place',3,1,1,'Cabaña rústica','Andorra',false,true,false,true,false,70,now(),5,now(),42.5063,1.5218),
(6,'Apartment','Private room',2,1,1,'Habitación cómoda','Sevilla, España',true,false,true,true,true,35,now(),6,now(),37.3891,-5.9845),
(7,'House','Entire place',5,2,2,'Casa cerca del mar','Lisboa, Portugal',true,true,true,true,true,110,now(),7,now(),38.7223,-9.1393),
(8,'Loft','Entire place',3,1,1,'Loft moderno','Porto, Portugal',true,true,true,false,true,95,now(),8,now(),41.1579,-8.6291),
(9,'Hostel','Private room',1,0,1,'Habitación económica','Madrid, España',false,false,false,true,true,20,now(),9,now(),40.4168,-3.7038),
(10,'Villa','Entire place',10,5,4,'Villa de lujo','Ibiza, España',true,true,true,true,true,500,now(),10,now(),38.9067,1.4206),
(11,'Apartment','Entire place',3,1,1,'Apartamento moderno','Bilbao, España',true,true,true,true,true,75,now(),11,now(),43.2630,-2.9350),
(12,'Cabin','Entire place',4,2,1,'Cabaña en bosque','Asturias, España',false,true,false,true,false,60,now(),12,now(),43.3614,-5.8494),
(13,'Studio','Private room',1,1,1,'Estudio económico','Granada, España',false,true,false,true,true,30,now(),13,now(),37.1773,-3.5986),
(14,'House','Entire place',7,3,3,'Casa espaciosa','Pamplona, España',true,true,false,true,true,95,now(),14,now(),42.8125,-1.6458),
(15,'Apartment','Entire place',2,1,1,'Apartamento minimalista','Zaragoza, España',true,true,false,true,true,50,now(),15,now(),41.6488,-0.8891);

INSERT INTO reservations (id, user_id, room_id, start_date, end_date, price, total, created_at)
VALUES
(1,1,3,'2025-02-01','2025-02-05',45,180,now()),
(2,2,1,'2025-03-10','2025-03-12',80,160,now()),
(3,3,4,'2025-04-01','2025-04-07',200,1200,now()),
(4,4,2,'2025-01-15','2025-01-18',120,360,now()),
(5,5,5,'2025-05-02','2025-05-06',70,280,now()),
(6,6,10,'2025-06-10','2025-06-12',500,1000,now()),
(7,7,9,'2025-02-20','2025-02-22',20,40,now()),
(8,8,8,'2025-03-01','2025-03-05',95,380,now()),
(9,9,7,'2025-04-14','2025-04-17',110,330,now()),
(10,10,6,'2025-07-01','2025-07-03',35,70,now()),
(11,11,11,'2025-08-20','2025-08-25',75,375,now()),
(12,12,12,'2025-09-10','2025-09-15',60,300,now()),
(13,13,14,'2025-10-01','2025-10-04',95,285,now()),
(14,14,13,'2025-11-12','2025-11-15',30,90,now()),
(15,15,15,'2025-12-20','2025-12-23',50,150,now());

INSERT INTO reviews (id, reservation_id, rating, comment)
VALUES
(1,1,5,'Excelente ubicación'),
(2,2,4,'Muy limpio y cómodo'),
(3,3,5,'Increíble experiencia'),
(4,4,3,'Bien, pero un poco ruidoso'),
(5,5,4,'Hermosa cabaña'),
(6,6,5,'Villa espectacular'),
(7,7,3,'Cumple, pero básico'),
(8,8,4,'Loft moderno y acogedor'),
(9,9,5,'Casa perfecta cerca del mar'),
(10,10,3,'Habitación aceptable'),
(11,11,4,'Bonito apartamento'),
(12,12,5,'Cabaña encantadora'),
(13,13,4,'Amplia y cómoda'),
(14,14,2,'Estudio muy simple'),
(15,15,5,'Gran experiencia');

INSERT INTO media (id, model_id, model_type, file_name, mime_type)
VALUES
(1,1,'room','room1_img1.jpg','image/jpeg'),
(2,1,'room','room1_img2.jpg','image/jpeg'),
(3,2,'room','room2_main.jpg','image/jpeg'),
(4,3,'room','room3_main.jpg','image/jpeg'),
(5,4,'room','villa_piscina.jpg','image/jpeg'),
(6,5,'room','cabin_forest.jpg','image/jpeg'),
(7,6,'room','sevilla_room.jpg','image/jpeg'),
(8,7,'room','lisboa_house.jpg','image/jpeg'),
(9,8,'room','porto_loft.jpg','image/jpeg'),
(10,9,'room','hostel_room.jpg','image/jpeg'),
(11,10,'room','ibiza_villa.jpg','image/jpeg'),
(12,11,'room','bilbao_modern.jpg','image/jpeg'),
(13,12,'room','asturias_cabin.jpg','image/jpeg'),
(14,13,'room','granada_studio.jpg','image/jpeg'),
(15,1,'user','user1_profile.jpg','image/jpeg');
