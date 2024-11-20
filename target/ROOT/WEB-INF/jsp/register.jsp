<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<body>

    <style>
        body{
        background-color: bisque;
        }

        h2{
            text-align: center;
            padding-top: 25px;
            padding-bottom: 25px;
        }

        .form{
            text-align: center;
        }
    </style>

<h2>REGISTER USER</h2>

<div class="form">
    <form method="post">

        <p>NAME</p>

        <input type="text" name="name">

        <p>USERNAME</p>

        <input type="text" name="username">

        <p>PASSWORD</p>

        <input type="password" name="password">
        <p></p>
        <input type="submit" name="SEND">
    </form>
    <p style="color: red;">${errorMess}</p>
</div>

</body>
</html>