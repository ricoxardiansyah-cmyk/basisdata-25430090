-- p01_lingkungan_25430090.sql
-- Password sengaja diganti penanda. JANGAN commit password asli.
CREATE DATABASE kopma_090
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'mhs_090'@'localhost' IDENTIFIED BY '<password_kerja>';
GRANT ALL PRIVILEGES ON kopma_090.* TO 'mhs_090'@'localhost';