<?php
header('Content-Type: application/json');
include 'koneksi.php';

$id        = $_POST['id'] ?? 0;
$nama      = $_POST['nama'] ?? '';
$kategori  = $_POST['kategori'] ?? '';
$harga     = $_POST['harga'] ?? 0;
$deskripsi = $_POST['deskripsi'] ?? '';

$stmt = $conn->prepare("UPDATE jasa SET nama=?, kategori=?, harga=?, deskripsi=? WHERE id=?");
$stmt->bind_param("ssisi", $nama, $kategori, $harga, $deskripsi, $id);

if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "Jasa diperbarui"]);
} else {
    echo json_encode(["success" => false, "message" => $stmt->error]);
}
$stmt->close();
$conn->close();
