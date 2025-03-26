<?php
// Conectar ao banco de dados
$conn = new mysqli('localhost', 'usuario', 'senha', 'brecho_online');

// Verificar se há erro na conexão
if ($conn->connect_error) {
    die("Falha na conexão: " . $conn->connect_error);
}

// Buscar produtos com base na pesquisa
$pesquisa = isset($_POST['pesquisa']) ? $_POST['pesquisa'] : '';

// Consultar produtos
$sql = "SELECT * FROM produtos WHERE nome_produto LIKE '%$pesquisa%' OR descricao LIKE '%$pesquisa%'";
$result = $conn->query($sql);

// Exibir produtos encontrados
if ($result->num_rows > 0) {
    while ($produto = $result->fetch_assoc()) {
        echo '<div class="produto-card">';
        echo '<img src="' . $produto['imagem'] . '" alt="' . $produto['nome_produto'] . '">';
        echo '<h2>' . $produto['nome_produto'] . '</h2>';
        echo '<p>' . $produto['descricao'] . '</p>';
        echo '<span>R$ ' . number_format($produto['preco'], 2, ',', '.') . '</span>';
        echo '<a href="produto.php?id=' . $produto['id'] . '">Ver detalhes</a>';
        echo '</div>';
    }
} else {
    echo "<p>Nenhum produto encontrado.</p>";
}

// Fechar a conexão com o banco de dados
$conn->close();
?>
