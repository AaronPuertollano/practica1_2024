<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<body>
    <style>
        body {
            background-color: bisque;
            margin: 0;
            padding: 0;
        }
        header {
            display: flex;
            justify-content: center;
            gap: 20px;
            text-align: center;
            margin: 20px 0 50px 0;
            padding: 10px;
        }
        header h3 {
            margin: 0;
            font-weight: normal;
        }
        a {
            text-decoration: none;
            color: #000;
            font-weight: bold;
        }
        h2 {
            text-align: center;
        }
        .gallery-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            padding: 20px;
        }
        .gallery-item {
            background-color: #fff;
            border: 3px solid #000;
            overflow: hidden;
            width: 200px;
            text-align: center;
            transition: transform 0.2s;
        }
        .gallery-item:hover {
            transform: scale(1.05);
        }
    </style>

    <header>
        <h3><a href="/register">REGISTER</a></h3>
        <h3><a href="/login">LOGIN</a></h3>
        <h3><a href="/paint">PAINT</a></h3>
        <h3><a href="/pergalery">MY GALLERY</a></h3>
        <h3><a href="/pubgalery">PUBLIC GALLERY</a></h3>
    </header>

    <h2>Public Gallery</h2>

    <div class="gallery-container" id="gallery-container"></div>

    <script type="application/json" id="datajson">
        ${publicPaintsJson}
    </script>

    <script>
        // Capturam el JSON
        const jsonData = document.getElementById('datajson').textContent.trim(); // Asegurarse de que no haya espacios en blanco

        try {

            const galleryItems = JSON.parse(jsonData);
            console.log("Datos de la galería parseados:", galleryItems); // Verificación en consola
            const galleryContainer = document.getElementById('gallery-container');

            galleryItems.forEach(paint => {

                console.log("Elemento paint:", paint);

                const galleryItem = document.createElement('div');
                galleryItem.classList.add('gallery-item');

                galleryItem.innerHTML = `
                    <h3>Name: \${paint.name}</h3>
                    <p>Owner: \${paint.owner}</p>
                `;

                galleryContainer.appendChild(galleryItem);
            });
        } catch (error) {
            console.error("Error al parsear JSON o al generar el HTML:", error);
        }
    </script>
</body>
</html>
