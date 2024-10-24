<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
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

    header h3 {
        margin: 0;
    }

    canvas{
        margin-left: 30px;
    }

    .parameters{
        display: flex;
        justify-content: center;
        gap: 20px;
        text-align: center;
    }
</style>
<body>

<header>
    <h3>
        <a href="/login">LOGIN</a>
    </h3>
    <h3>
        <a href="/paint">PAINT</a>
    </h3>
    <h3>
        <a href="/myGalery">MY GALERY</a>
    </h3>
    <h3>
        <a href="/pubGalery">PUBLIC GALERY</a>
    </h3>
</header>


<canvas id="myCanvas" width="600" height="400" style="border:1px solid #000000;"></canvas>

<div class="parameters">
    <div>
        <h4>TYPE</h4>
        <select id="shapeType">
            <option value="hand">HANDS UP</option>
            <option value="circle">CIRCLE</option>
            <option value="triangle">TRIANGLE</option>
            <option value="star">STAR</option>
        </select>
    </div>
    <div>
        <h4>COLOR</h4>
        <select id="color">
            <option value="black">BLACK</option>
            <option value="red">RED</option>
            <option value="blue">BLUE</option>
            <option value="green">GREEN</option>
            <option value="yellow">YELLOW</option>
            <option value="purple">PURPLE</option>
        </select>
    </div>
    <div>
        <h4>SIZE</h4>
        <select id="size">
            <option value="2">SMALL</option>
            <option value="5">MEDIUM</option>
            <option value="10">BIG</option>
        </select>
    </div>
    <div>
        <h4>FILL</h4>
        <input type="checkbox" id="fillShape">
    </div>
</div>

</body>
</html>