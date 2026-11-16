-- Database: kerjain_db
CREATE DATABASE IF NOT EXISTS kerjain_db;
USE kerjain_db;

CREATE TABLE IF NOT EXISTS jasa (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nama VARCHAR(150) NOT NULL,
  kategori VARCHAR(50) NOT NULL,
  harga INT NOT NULL,
  deskripsi TEXT NOT NULL
);

-- Data awal supaya tampilan tidak kosong
INSERT INTO jasa (nama, kategori, harga, deskripsi) VALUES
('Desain Poster Kreatif', 'Desain', 75000, 'Poster orisinal untuk acara kampus.'),
('Editing Video Reels', 'Video', 150000, 'Edit video reels dengan subtitle.');
