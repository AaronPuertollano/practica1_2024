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
            <a href="/pergalery">MY GALERY</a>
        </h3>
        <h3>
            <a href="/pubgalery">PUBLIC GALERY</a>
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
                <p>Name: <input type="text" id="namepaint" name="namepaint" placeholder="Put a name please"></p>

                <input type="hidden" name="stringobjectes" id="inputobjectes">
                <button type="button" id="saveButton">Save Drawing</button>
                <button type="button" id="deleteButton">Delete all</button>
                <button type="button" id="left"><-</button>
                <button type="button" id="right">-></button>
            </div>

        </div>

    </div>

    <div class="parameters">
        <div>
            <h4>MODE</h4>
            <select id="shapeType">
                <option value="selectshape">SELECT SHAPE</option>
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
    // Extraer parámetros de la URL
    const urlParams = new URLSearchParams(window.location.search);
    const dataN = urlParams.get('data');
    const drawingName = dataN;

    // Asignar el valor al campo de texto
    if (drawingName) {
        const nameInput = document.getElementById("namepaint");
        if (nameInput) {
            nameInput.value = drawingName;
        }
    }

    document.getElementById("saveButton").addEventListener("click", handleSaveDrawing);

    const canvas = document.getElementById("myCanvas");
    const ctx = canvas.getContext("2d");
    let isDrawing = false;
    const shapes = [];

    //figures
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

            const editButton = document.createElement("button");
            editButton.innerText = editingShapeIndex === index ? "Save" : "Edit";
            editButton.style.marginLeft = "10px";

            deleteButton.addEventListener("click", () => {
                saveToHistory();
                shapes.splice(index, 1);
                updateShapeList();
                redrawCanvas();
                saveShapesToLocalStorage();
                handleSaveDrawing();
            });

            editButton.addEventListener("click", () => {

                if (editingShapeIndex === index) {
                    saveToHistory();

                    // Guarda i aplica valors
                    const newColor = document.getElementById("colorInput").value;
                    const newSize = parseInt(document.getElementById("sizeInput").value, 10);
                    const newFill = document.getElementById("fillShape").value === "true";

                    shapes[index].color = newColor;
                    shapes[index].size = newSize;
                    shapes[index].filled = newFill;
                    editingShapeIndex = null;
                    handleSaveDrawing();
                } else {
                    editMode(index); // Activa mode edició

                    // Aplica valors del shape als selects

                    const shapeColor = shapes[index].color;
                    const shapeSize = shapes[index].size;
                    const shapeFill = shapes[index].filled;

                    document.getElementById("colorInput").value = shapeColor;
                    document.getElementById("fillShape").value = shapeFill;
                    document.getElementById("sizeInput").value = shapeSize;

                }
                updateShapeList();
                redrawCanvas();
                saveShapesToLocalStorage();
            });

            shapeItem.appendChild(deleteButton);
            shapeItem.appendChild(editButton);
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

    // Almacenar en el localStorage y actualitza
    const saveShapesToLocalStorage = () => {
        localStorage.setItem("shapes", JSON.stringify(shapes));
        updateShapeList();
        redrawCanvas();
    };

    document.addEventListener("DOMContentLoaded", () => {
        const savedShapes = localStorage.getItem("shapes");

        if (savedShapes) {
            shapes.push(...JSON.parse(savedShapes));
            redrawCanvas();
            updateShapeList();
        }
    });

    document.addEventListener("DOMContentLoaded", () => {
        if (shapes.length) {
            redrawCanvas();
            updateShapeList();
        }
    });

    canvas.addEventListener("mousedown", (event) => {
        saveToHistory();
        const x = event.clientX - canvas.getBoundingClientRect().left;
        const y = event.clientY - canvas.getBoundingClientRect().top;

    // Depenent si estam en mode edició el canvas fara una cosa o altre
        if (editingShapeIndex !== null) {
            shapes[editingShapeIndex].x = x;
            shapes[editingShapeIndex].y = y;

            updateShapeList();
            redrawCanvas();
            saveShapesToLocalStorage();
        } else {
            const size = parseInt(document.getElementById("sizeInput").value, 10);
            const color = document.getElementById("colorInput").value;
            const type = document.getElementById("shapeType").value;
            const filled = document.getElementById("fillShape").value === "true";

            if (type === "square") {
                drawRect(x, y, size, size, color, filled);
                shapes.push({ type: "square", x, y, size, color, filled });
                handleSaveDrawing();
            } else if (type === "circle") {
                drawCircle(x, y, size / 2, color, filled);
                shapes.push({ type: "circle", x, y, size, color, filled });
                handleSaveDrawing();
            } else if (type === "triangle") {
                drawTriangle(x, y, size, color, filled);
                shapes.push({ type: "triangle", x, y, size, color, filled });
                handleSaveDrawing();
            } else if (type === "star") {
                drawStar(x, y, size, color, filled);
                shapes.push({ type: "star", x, y, size, color, filled });
                handleSaveDrawing();
            } else if (type === "selectshape") {
                for (let i = shapes.length - 1; i >= 0; i--) {
                    const shape = shapes[i];
                    let isInside = false;

                    if (shape.type === "square") {
                        isInside = isPointInRect(x, y, shape);
                    } else if (shape.type === "circle") {
                        isInside = isPointInCircle(x, y, shape);
                    } else if (shape.type === "triangle") {
                        isInside = isPointInTriangle(x, y, shape);
                    } else if (shape.type === "star") {
                        isInside = isPointInStar(x, y, shape);
                    }

                    if (isInside) {
                        //si toca una figura aquesta es posa en mode edicio
                        editingShapeIndex = i;

                        const shapeColor = shape.color;
                        const shapeSize = shape.size;
                        const shapeFill = shape.filled;

                        document.getElementById("colorInput").value = shapeColor;
                        document.getElementById("sizeInput").value = shapeSize;
                        document.getElementById("fillShape").value = shapeFill;

                        updateShapeList();
                        return;
                    }
                }
            }

            document.getElementById("inputobjectes").value = JSON.stringify(shapes);
            updateShapeList();
            saveShapesToLocalStorage();
        }
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

    let editingShapeIndex = null;

    const editMode = (index) => {
        if (editingShapeIndex === index) {

            editingShapeIndex = null;
            updateShapeList();
            redrawCanvas();
            return;
        }

        editingShapeIndex = index;
        updateShapeList();
    };

    document.getElementById("deleteButton").addEventListener("click", () => {
        saveToHistory();
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        shapes.length = 0;
        localStorage.removeItem("shapes");
        updateShapeList();
    });

    // Historial
    const historyStack = [];
    const redoStack = [];

    const saveToHistory = () => {
        historyStack.push(JSON.stringify(shapes));
        if (historyStack.length > 25) {
            historyStack.shift();
        }
        redoStack.length = 0;
    };

    // Retrocedeix al estat anterior
    document.getElementById("left").addEventListener("click", () => {
        if (historyStack.length === 0) {
            alert("No previous state to revert to.");
            return;
        }

        redoStack.push(JSON.stringify(shapes));
        const previousState = historyStack.pop();
        shapes.length = 0;
        shapes.push(...JSON.parse(previousState));

        redrawCanvas();
        updateShapeList();
    });

    // Avança el estat
    document.getElementById("right").addEventListener("click", () => {
        if (redoStack.length === 0) {
            alert("No future state to redo.");
            return;
        }

        historyStack.push(JSON.stringify(shapes));
        const nextState = redoStack.pop();
        shapes.length = 0;
        shapes.push(...JSON.parse(nextState));

        redrawCanvas();
        updateShapeList();
    });

    //funcions per comprovar si toca a una figura

    const isPointInRect = (x, y, rect) => {
        return x >= rect.x && x <= rect.x + rect.size &&
               y >= rect.y && y <= rect.y + rect.size;
    };

    const isPointInCircle = (x, y, circle) => {
        const dx = x - circle.x;
        const dy = y - circle.y;
        return Math.sqrt(dx * dx + dy * dy) <= circle.size / 2;
    };

    const isPointInTriangle = (x, y, triangle) => {
        const { x: tx, y: ty, size } = triangle;
        const x1 = tx, y1 = ty;
        const x2 = tx - size / 2, y2 = ty + size;
        const x3 = tx + size / 2, y3 = ty + size;

        const area = Math.abs((x1*(y2-y3) + x2*(y3-y1) + x3*(y1-y2)) / 2.0);
        const area1 = Math.abs((x*(y2-y3) + x2*(y3-y) + x3*(y-y2)) / 2.0);
        const area2 = Math.abs((x1*(y-y3) + x*(y3-y1) + x3*(y1-y)) / 2.0);
        const area3 = Math.abs((x1*(y2-y) + x2*(y-y1) + x*(y1-y2)) / 2.0);

        return (area === area1 + area2 + area3);
    };

    const isPointInStar = (x, y, star) => {
        const dx = x - star.x;
        const dy = y - star.y;
        const distance = Math.sqrt(dx * dx + dy * dy);
        return distance <= star.size;
    };
</script>

</body>
</html>