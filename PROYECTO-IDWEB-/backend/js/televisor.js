document.addEventListener('DOMContentLoaded', () => {
    
    const detallesTitulo = document.querySelectorAll('.producto-card .detail-box h3');
    detallesTitulo.forEach(title => {
        
        title.style.cursor = 'pointer'; 
        title.addEventListener('click', () => {
            const detailBox = title.closest('.detail-box');     
            if (detailBox) {
                detailBox.classList.toggle('is-open');
            }
        });
    });
});