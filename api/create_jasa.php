<?php
header('Content-Type: application/json');
include 'koneksi.php';

$nama      = $_POST['nama'] ?? '';
$kategori  = $_POST['kategori'] ?? '';
$harga     = $_POST['harga'] ?? 0;
$deskripsi = $_POST['deskripsi'] ?? '';

$stmt = $conn->prepare("INSERT INTO jasa (nama, kategori, harga, deskripsi) VALUES (?, ?, ?, ?)");
$stmt->bind_param("ssis", $nama, $kategori, $harga, $deskripsi);

if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "Jasa ditambahkan"]);
} else {
    echo json_encode(["success" => false, "message" => $stmt->error]);
}
$stmt->close();
$conn->close();
