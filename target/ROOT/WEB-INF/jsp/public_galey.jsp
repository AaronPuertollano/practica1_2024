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

    <h2>Public Gallery</h2>

    <div class="gallery-container" id="gallery-container">
        <!-- Aquí se insertarán las imágenes de la galería personal -->
    </div>

<script>

    const galleryData = [
        { name: "Sunset", owner: "User123" },
        { name: "Mountains", owner: "User123" },
        { name: "Beach", owner: "User123" }
    ];

    const galleryContainer = document.getElementById("gallery-container");

    function renderGallery(data) {
        data.forEach(item => {
            const galleryItem = document.createElement("div");
            galleryItem.classList.add("gallery-item");

            galleryItem.innerHTML = `
                <h4>${item.name}</h4>
                <p>Owner: ${item.owner}</p>
            `;

            galleryContainer.appendChild(galleryItem);
        });
    }

    renderGallery(galleryData);

</script>

</body>
</html>