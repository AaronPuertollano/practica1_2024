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
            width: 300px;
            text-align: center;
            transition: transform 0.2s;
        }

        .gallery-item:hover {
            transform: scale(1.05);
        }

    </style>

    <header>
        <h3>
            <a href="/register">REGISTER</a>
        </h3>
        <h3>
            <a href="/login">LOGIN</a>
        </h3>
        <h3>
            <a href="/paint">PAINT</a>
        </h3>
        <h3>
            <a href="/pergalery">MY GALLERY</a>
        </h3>
        <h3>
            <a href="/pubgalery">PUBLIC GALLERY</a>
        </h3>
    </header>

    <h2>Personal Gallery</h2>

    <div class="gallery-container" id="gallery-container">
        <!-- Aquí se insertarán las imágenes de la galería personal -->
    </div>

    <script type="application/json" id="datajson">
        ${userPaintsJson}
    </script>

    <script>

    const drawRect = (x, y, w, h, color, filled) => {
        ctx.beginPath();
        if (filled) {
            ctx.fillStyle = color;
            ctx.fillRect(x, y, w, h);
        } else {
            ctx.strokeStyle = color;
            ctx.rect(x, y, w, h);
            ctx.stroke();
        }
    };

    const drawCircle = (x, y, radius, color, filled) => {
        ctx.beginPath();
        ctx.arc(x, y, radius, 0, Math.PI * 2);
        ctx.fillStyle = color;
        ctx.strokeStyle = color;
        if (filled) {
            ctx.fill();
        } else {
            ctx.stroke();
        }
        ctx.closePath();
    };

    const drawTriangle = (x, y, size, color, filled) => {
        ctx.beginPath();
        ctx.moveTo(x, y);
        ctx.lineTo(x - size / 2, y + size);
        ctx.lineTo(x + size / 2, y + size);
        ctx.closePath();
        ctx.fillStyle = color;
        ctx.strokeStyle = color;
        if (filled) {
            ctx.fill();
        } else {
            ctx.stroke();
        }
    };

    const drawStar = (x, y, size, color, filled) => {
        const points = 7;
        const outerRadius = size;
        const innerRadius = size / 2.5;
        const angle = Math.PI / points;

        ctx.beginPath();
        ctx.fillStyle = color;
        ctx.strokeStyle = color;

        for (let i = 0; i < points * 2; i++) {
            const radius = i % 2 === 0 ? outerRadius : innerRadius;
            const px = x + radius * Math.cos(i * angle);
            const py = y + radius * Math.sin(i * angle);
            if (i === 0) {
                ctx.moveTo(px, py);
            } else {
                ctx.lineTo(px, py);
            }
        }

        ctx.closePath();
        if (filled) {
            ctx.fill();
        } else {
            ctx.stroke();
        }
    };

         // Capturam el JSON
      const jsonData = document.getElementById('datajson').textContent.trim(); // Asegurarse de que no haya espacios en blanco

         try {

             const galleryItems = JSON.parse(jsonData);
             console.log("Datos de la galería parseados:", galleryItems); // Verificación en consola
             const galleryContainer = document.getElementById('gallery-container');

             galleryItems.forEach(paint => {

                 const galleryItem = document.createElement('div');
                 galleryItem.classList.add('gallery-item');

                 galleryItem.innerHTML = `
                     <h3>Name: \${paint.name}</h3>
                     <p>Owner: \${paint.owner}</p>
                     <canvas width="280" height="280"></canvas>
                     <button class="delete-button" data-id="${paint.id}">Delete</button>
                 `;

                const deleteButton = galleryItem.querySelector('.delete-button');
                deleteButton.addEventListener('click', () => deletePaint(galleryItem, paint.id));

                // Render the shapes on the canvas
                const canvas = galleryItem.querySelector('canvas');
                drawShapesOnCanvas(canvas, paint.data);

                galleryContainer.appendChild(galleryItem);
             });
         } catch (error) {
             console.error("Error al parsear JSON:", error);
         }

         function drawShapesOnCanvas(canvas, data) {
                     const context = canvas.getContext('2d');
                     const shapes = JSON.parse(data);

                     shapes.forEach(shape => {
                         context.fillStyle = shape.color;
                         context.strokeStyle = shape.color;

                         if (shape.type === 'square') {
                             if (shape.filled) {
                                 context.fillRect(shape.x, shape.y, shape.size, shape.size);
                             } else {
                                 context.strokeRect(shape.x, shape.y, shape.size, shape.size);
                             }
                         }

                         // Añadir otros tipos de formas (si las hay) en condiciones adicionales:
                         // if (shape.type === 'circle') { ... }
                     });
                 }

         function deletePaint(galleryItem, paintId) {
                 // Eliminar del DOM
                 galleryItem.remove();

                 // Realizar solicitud de eliminación al servidor
                 fetch(`/pergalery`, {
                     method: 'POST',
                     headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                     body: `action=delete&id=${paintId}`
                 })
                 .then(response => {
                     if (response.ok) {
                         console.log(`Dibuix eliminat`);
                     } else {
                         console.error("Error al eliminar");
                     }
                 })
                 .catch(error => console.error("Error en la solicitud:", error));
             }

    </script>

</body>
</html>