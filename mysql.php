<?php
$host = 'localhost';
$db = 'brecho_online';
$user = 'usuario';
$password = '';

try {
    // Conectar ao banco de dados
    $pdo = new PDO("mysql:host=$host;dbname=$db", $user, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // Obter o termo de pesquisa
    if (isset($_GET['q'])) {
        $query = "%" . $_GET['q'] . "%";
        
        // Preparar a consulta SQL para buscar os produtos
        $stmt = $pdo->prepare("SELECT * FROM produtos WHERE nome LIKE :query");
        $stmt->bindParam(':query', $query, PDO::PARAM_STR);
        $stmt->execute();
        
        // Obter os resultados
        $resultados = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        // Retornar os resultados como JSON
        echo json_encode($resultados);
    }
} catch (PDOException $e) {
    echo "Erro: " . $e->getMessage();
}
?>
                                                   