<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script svc=""></script>

    <style>

            body{
                background-color: bisque;
            }
            header {
                display: flex;
                justify-content: center;
                gap: 20px;
                text-align: center;
                margin-bottom: 50px;
            }

            .contingut{
                display: flex;
            }

            .list{
                background-color: aliceblue;
                width: 35%;
                text-align: center;
                margin-left: 25px;
                border-style: solid;
                border-color: #000000;
            }

            header h3 {
                margin: 0;
                font-weight: normal;
            }

            canvas{
                margin-left: 30px;
                background-color: aliceblue;
            }

            .parameters{
                display: flex;
                justify-content: center;
                gap: 20px;
                text-align: center;
            }

            a{
                text-decoration: none;
                color: #000000;
            }

            .content{
                height: 62%;
                background-color: rgb(248, 206, 155);
                height: 250px;
                overflow-y: auto;
            }
        </style>

</head>
<body>

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

    <div class="contingut">

        <canvas id="myCanvas" width="600" height="400" style="border:3px solid #000000;"></canvas>

        <div class="list">

          <h2>Figures</h2>

            <div class="content" id="figureList">
             <!-- Aquí se mostrarán las figuras añadidas -->
            </div>

            <div class="butonfinish">
               <p>Name:</p>
               <input type="text" id="namepaint" name="namepaint" placeholder="Enter drawing name">
               <input type="hidden" name="stringobjectes" id="inputobjectes">
               <button type="button" id="saveButton">Save Drawing</button>
            </div>

        </div>

    </div>

    <div class="parameters">
        <div>
            <h4>TYPE</h4>
            <select id="shapeType">
                <option value="square">SQUARE</option>
                <option value="circle">CIRCLE</option>
                <option value="triangle">TRIANGLE</option>
                <option value="star">STAR</option>
                <option value="hand">HANDS UP</option>
            </select>
        </div>
        <div>
            <h4>COLOR</h4>
            <select id="colorInput">
                <option value="#000">BLACK</option>
                <option value="#ff0000">RED</option>
                <option value="#009bff">BLUE</option>
                <option value="#00ff32">GREEN</option>
                <option value="#ffd500">YELLOW</option>
                <option value="#c900ff">PURPLE</option>
                <option value="#996401">BROWN</option>
            </select>
        </div>
        <div>
            <h4>SIZE</h4>
            <select id="sizeInput">
                <option value="35">SMALL</option>
                <option value="60">MEDIUM</option>
                <option value="95">BIG</option>
            </select>
        </div>
        <div>
            <h4>FILL</h4>

              <select id="fillShape">
                 <option value="true">Yes</option>
                 <option value="false">No</option>
              </select>

        </div>

    </div>

    <script>

document.getElementById("saveButton").addEventListener("click", handleSaveDrawing);
const canvas = document.getElementById("myCanvas");
const ctx = canvas.getContext("2d");
let isDrawing = false;
const shapes = [];

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

const startDrawing = (x, y, color, size) => {
    isDrawing = true;
    ctx.beginPath();
    ctx.lineWidth = size / 5;
    ctx.strokeStyle = color;
    ctx.moveTo(x, y);
};

const drawLine = (x, y) => {
    if (!isDrawing) return;
    ctx.lineTo(x, y);
    ctx.stroke();
};

const stopDrawing = () => {
    isDrawing = false;
    ctx.closePath();
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

const updateShapeList = () => {
    figureList.innerHTML = "";
    shapes.forEach((shape, index) => {

        const shapeItem = document.createElement("p");

        shapeItem.innerText = `${index + 1} | Form: ${shape.type} | Color: ${shape.color} | Size: ${shape.size} `;

        const deleteButton = document.createElement("button");
        deleteButton.innerText = "X";
        deleteButton.style.marginLeft = "10px";

        deleteButton.addEventListener("click", () => {
            shapes.splice(index, 1);
            updateShapeList();
            redrawCanvas();
        });


        shapeItem.appendChild(deleteButton);
        figureList.appendChild(shapeItem);
    });
};

const redrawCanvas = () => {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    shapes.forEach(shape => {

        if (shape.type === "square") {
            drawRect(shape.x, shape.y, shape.size, shape.size, shape.color, shape.filled);
        } else if (shape.type === "circle") {
            drawCircle(shape.x, shape.y, shape.size / 2, shape.color, shape.filled);
        } else if (shape.type === "triangle") {
            drawTriangle(shape.x, shape.y, shape.size, shape.color, shape.filled);
        } else if (shape.type === "star") {
            drawStar(shape.x, shape.y, shape.size, shape.color, shape.filled);
        }
    });
};

canvas.addEventListener("mousedown", (event) => {
    const x = event.clientX - canvas.getBoundingClientRect().left;
    const y = event.clientY - canvas.getBoundingClientRect().top;
    const size = parseInt(document.getElementById("sizeInput").value, 10);
    const color = document.getElementById("colorInput").value;
    const type = document.getElementById("shapeType").value;
    const filled = document.getElementById("fillShape").value === "true";

    if (type === "square") {
        drawRect(x, y, size, size, color, filled);
        shapes.push({ type: "square", x, y, size, color, filled });
    } else if (type === "circle") {
        drawCircle(x, y, size / 2, color, filled);
        shapes.push({ type: "circle", x, y, size, color, filled });
    } else if (type === "triangle") {
        drawTriangle(x, y, size, color, filled);
        shapes.push({ type: "triangle", x, y, size, color, filled });
    } else if (type === "star") {
        drawStar(x, y, size, color, filled);
        shapes.push({ type: "star", x, y, size, color, filled });
    } else if (type === "hand") {
        startDrawing(x, y, color, size);
    }

    document.getElementById("inputobjectes").value = JSON.stringify(shapes);
    updateShapeList();
});

canvas.addEventListener("mousemove", (event) => {
    const x = event.clientX - canvas.getBoundingClientRect().left;
    const y = event.clientY - canvas.getBoundingClientRect().top;
    drawLine(x, y);
});

canvas.addEventListener("mouseup", stopDrawing);
canvas.addEventListener("mouseout", stopDrawing);

function handleSaveDrawing() {
    const drawingName = document.getElementById("namepaint").value;
    const shapesData = JSON.stringify(shapes);

    if (shapes.length === 0) {
        alert("Please add at least one shape before saving.");
        return;
    }

    // Cream el objete FormData
    const formData = new FormData();
    formData.append("name", drawingName);
    formData.append("drawingData", shapesData);

    fetch("/paint", {
        method: "POST",
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name: drawingName, drawingData: shapesData }),
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert("Drawing saved!");
            window.location.href = data.redirect;
        } else {
            alert("Server error: " + data.message);
        }
    })
    .catch(error => {
        alert("Failed to connect to the server.");
    });
}

function clearCanvas() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    shapes.length = 0;
    updateShapeList();
    document.getElementById("namepaint").value = "";
}

    </script>

</body>

</html>