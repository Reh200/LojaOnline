// Obtém os elementos do DOM
const profilePhoto = document.getElementById("profile-photo");
const fileInput = document.getElementById("file-input");
const profileIcon = document.getElementById("profile-icon");

// Verifica se já há uma imagem salva no LocalStorage
if (localStorage.getItem("profilePic")) {
    profilePhoto.style.backgroundImage = `url(${localStorage.getItem("profilePic")})`;
    profileIcon.style.display = 'none'; // Esconde o ícone "+" se houver uma foto
}

// Função para atualizar a foto de perfil
fileInput.addEventListener("change", function(event) {
    const file = event.target.files[0];

    if (file) {
        const reader = new FileReader();

        reader.onloadend = function() {
            // Salva a imagem no LocalStorage
            localStorage.setItem("profilePic", reader.result);
            // Atualiza a foto de perfil com a nova imagem
            profilePhoto.style.backgroundImage = `url(${reader.result})`;
            profileIcon.style.display = 'none'; // Esconde o ícone "+"
        };

        // Lê a imagem selecionada
        reader.readAsDataURL(file);
    }
});

// Função para quando o usuário clicar na foto de perfil para selecionar uma nova imagem
profilePhoto.addEventListener("click", function() {
    fileInput.click(); // Simula o clique no input de arquivo
});
