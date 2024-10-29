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
        }
    </style>

</head>
<body>

    <header>
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

            <div class="content">

            </div>

            <div class="buton">
                <p>Name:</p>
                <input type="text" name="namepaint">
                <input type="hidden" name="stringobjectes" id="inputobjectes">
                <input type="submit">
            </div>

        </div>

    </div>

    <div class="parameters">
        <div>
            <h4>TYPE</h4>
            <select id="shapeType">
                <option value="hand">HANDS UP</option>
                <option value="square">SQUARE</option>
                <option value="circle">CIRCLE</option>
                <option value="triangle">TRIANGLE</option>
                <option value="star">STAR</option>
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
            <input type="checkbox" id="fillShape">
        </div>

    </div>

    <script>
            const canvas = document.getElementById("myCanvas");
            const ctx = canvas.getContext("2d");
            let isDrawing = false;

            const drawRect = (x, y, w, h, color) => {
                ctx.beginPath();
                ctx.fillStyle = color;
                ctx.fillRect(x, y, w, h);
            };

            const drawCircle = (x, y, radius, color) => {
                ctx.beginPath();
                ctx.arc(x, y, radius, 0, Math.PI * 2);
                ctx.fillStyle = color;
                ctx.fill();
                ctx.closePath();
            };

            const drawTriangle = (x, y, size, color) => {
                ctx.beginPath();
                ctx.moveTo(x, y);
                ctx.lineTo(x - size / 2, y + size);
                ctx.lineTo(x + size / 2, y + size);
                ctx.closePath();
                ctx.fillStyle = color;
                ctx.fill();
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

            const drawStar = (x, y, size, color) => {
                const points = 7;
                const outerRadius = size;
                const innerRadius = size / 2.5;
                const angle = Math.PI / points;

                ctx.beginPath();
                ctx.fillStyle = color;

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
                ctx.fill();
            };

            canvas.addEventListener("mousedown", (event) => {
                const x = event.clientX - canvas.getBoundingClientRect().left;
                const y = event.clientY - canvas.getBoundingClientRect().top;
                const size = parseInt(document.getElementById("sizeInput").value, 10);
                const color = document.getElementById("colorInput").value;
                const type = document.getElementById("shapeType").value;
                const filled = document.getElementById("fillShape").value;

                if (type === "square") {
                    drawRect(x, y, size, size, color);
                } else if (type === "circle") {
                    drawCircle(x, y, size / 2, color);
                } else if (type === "triangle") {
                    drawTriangle(x, y, size, color);
                } else if (type === "star") {
                    drawStar(x, y, size, color);
                } else if (type === "hand") {
                    startDrawing(x, y, color, size);
                }

                let element = document.getElementById("inputobjectes");
                element.value = Object;
            });


            canvas.addEventListener("mousemove", (event) => {
                const x = event.clientX - canvas.getBoundingClientRect().left;
                const y = event.clientY - canvas.getBoundingClientRect().top;
                drawLine(x, y);
            });

            canvas.addEventListener("mouseup", stopDrawing);
            canvas.addEventListener("mouseout", stopDrawing);
        </script>

</body>

</html>