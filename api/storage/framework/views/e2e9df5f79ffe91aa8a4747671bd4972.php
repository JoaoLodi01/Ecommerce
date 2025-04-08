<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <?php dump(session()) ?>
    <form action="http://192.168.1.100:8000/forgot-password" method="post">
        <?php echo csrf_field(); ?>
        <label for="">E-mail</label>
        <input type="email">

        <button>Enviar</button>
    </form>    

</body>
</html><?php /**PATH C:\Gabriel\Projetos\SGBR\1_Hotel_Ecommerce\api\resources\views/auth/form.blade.php ENDPATH**/ ?>