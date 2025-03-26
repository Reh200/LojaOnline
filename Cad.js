// Dados Temporários
let vendors = [];
let products = [];

// Referências dos Elementos
const vendorForm = document.getElementById('vendor-form');
const productForm = document.getElementById('product-form');
const vendorList = document.querySelector('#vendor-list .items');
const productList = document.querySelector('#product-list .items');
const productVendorSelect = document.getElementById('product-vendor');

// Alternar seções
document.getElementById('show-products').addEventListener('click', () => {
    productForm.style.display = 'block';
    vendorForm.style.display = 'none';
    productList.parentElement.style.display = 'block';
    vendorList.parentElement.style.display = 'none';
});

document.getElementById('show-vendors').addEventListener('click', () => {
    productForm.style.display = 'none';
    vendorForm.style.display = 'block';
    productList.parentElement.style.display = 'none';
    vendorList.parentElement.style.display = 'block';
});

// Adicionar Vendedor
document.getElementById('add-vendor').addEventListener('click', () => {
    const name = document.getElementById('vendor-name').value;
    const email = document.getElementById('vendor-email').value;

    if (name && email) {
        const id = vendors.length + 1;
        vendors.push({ id, name, email });

        const vendorOption = document.createElement('option');
        vendorOption.value = id;
        vendorOption.textContent = name;
        productVendorSelect.appendChild(vendorOption);

        renderVendors();
        document.getElementById('vendor-name').value = '';
        document.getElementById('vendor-email').value = '';
    }
});

// Adicionar Produto
document.getElementById('add-product').addEventListener('click', () => {
    const name = document.getElementById('product-name').value;
    const description = document.getElementById('product-description').value;
    const price = document.getElementById('product-price').value;
    const vendorId = productVendorSelect.value;

    if (name && price && vendorId) {
        const vendor = vendors.find(v => v.id == vendorId);
        products.push({ name, description, price, vendor });

        renderProducts();
        document.getElementById('product-name').value = '';
        document.getElementById('product-description').value = '';
        document.getElementById('product-price').value = '';
        productVendorSelect.value = '';
    }
});

// Renderizar Vendedores
function renderVendors() {
    vendorList.innerHTML = vendors.map(v => `<div class="item">${v.name} (${v.email})</div>`).join('');
}

// Renderizar Produtos
function renderProducts() {
    productList.innerHTML = products.map(p => `
        <div class="item">
            <h3>${p.name}</h3>
            <p>${p.description}</p>
            <p>Preço: R$ ${p.price}</p>
            <p>Vendedor: ${p.vendor.name}</p>
        </div>
    `).join('');
}