<?php
header('Content-Type: application/json');
include 'koneksi.php';

$result = $conn->query("SELECT * FROM jasa ORDER BY id DESC");
$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}
echo json_encode(["success" => true, "data" => $data]);
$conn->close();
