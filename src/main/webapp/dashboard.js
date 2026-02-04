const sideMenu = document.querySelector("aside");
const menuBtn = document.querySelector("#menu-btn");
const closeBtn = document.querySelector("#close-btn");

// Afficher la barre latérale
menuBtn.addEventListener('click', () => {
    sideMenu.style.display = 'block';
});

// Fermer la barre latérale
closeBtn.addEventListener('click', () => {
    sideMenu.style.display = 'none';
});

// Remplir les commandes dans le tableau
const Orders = [
    {
        productName: 'Foldable Mini Drone',
        productNumber: '85631',
        paymentStatus: 'Due',
        shipping: 'Pending'
    },
    {
        productName: 'LARVENNDER KF1232 Drone',
        productNumber: '36378',
        paymentStatus: 'Refunded',
        shipping: 'Declined'
    },
    {
        productName: 'Ruko F11 Pro Drone',
        productNumber: '49347',
        paymentStatus: 'Due',
        shipping: 'Pending'
    },
    {
        productName: 'Drone with Camera',
        productNumber: '85631',
        paymentStatus: 'Paid',
        shipping: 'Delivered'
    },
    {
        productName: 'GPS 4K Drone',
        productNumber: '22821',
        paymentStatus: 'Paid',
        shipping: 'Pending'
    }
];

// Remplir le tableau avec les commandes
Orders.forEach(order => {
    const tr = document.createElement('tr');
    const trContent = `
        <td>${order.productName}</td>
        <td>${order.productNumber}</td>
        <td>${order.paymentStatus}</td>
        <td class="${order.shipping === 'Declined' ? 'danger' : order.shipping === 'Pending' ? 'warning' : 'primary'}">${order.shipping}</td>
    `;
    tr.innerHTML = trContent;
    document.querySelector('table tbody').appendChild(tr);
});

// Remplir les mises à jour récentes (sans photo)
const recentUpdates = [
    {
        nom: "John Doe",
        message: "a signalé un problème de plomberie.",
        timestamp: "2023-10-25 10:30"
    },
    {
        nom: "Jane Smith",
        message: "a demandé une réparation électrique.",
        timestamp: "2023-10-24 15:45"
    },
    {
        nom: "Alice Johnson",
        message: "a signalé un problème de chauffage.",
        timestamp: "2023-10-23 09:15"
    }
];

// Remplir la section des mises à jour récentes
recentUpdates.forEach(update => {
    const updateDiv = document.createElement('div');
    updateDiv.classList.add('update');

    const messageDiv = document.createElement('div');
    messageDiv.classList.add('message');

    const messageContent = `
        <p><b>${update.nom}</b> ${update.message}</p>
        <small class="text-muted">${update.timestamp}</small>
    `;
    messageDiv.innerHTML = messageContent;

    updateDiv.appendChild(messageDiv);
    document.querySelector('#recentUpdates').appendChild(updateDiv);
});