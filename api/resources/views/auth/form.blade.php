<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    @php dump(session()) @endphp
    <form action="http://192.168.1.100:8000/forgot-password" method="post">
        @csrf
        <label for="">E-mail</label>
        <input type="email">

        <button>Enviar</button>
    </form>    

</body>
</html>