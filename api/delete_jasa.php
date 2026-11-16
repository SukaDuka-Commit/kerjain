<?php
header('Content-Type: application/json');
include 'koneksi.php';

$id = $_POST['id'] ?? 0;

$stmt = $conn->prepare("DELETE FROM jasa WHERE id=?");
$stmt->bind_param("i", $id);

if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "Jasa dihapus"]);
} else {
    echo json_encode(["success" => false, "message" => $stmt->error]);
}
$stmt->close();
$conn->close();
