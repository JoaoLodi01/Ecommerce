<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <?php dump(session()->all('status')) ?>
    <form action="<?php echo e(route('password.email')); ?>" method="post">
        <?php echo csrf_field(); ?>

        <label for="email">E-mail</label>
        <input 
            type="email" 
            name="email" 
            id="email"
        />
        <button type="submit">Enviar</button>  
    </form>

    <?php if(session('status') === null): ?>
        <div class="">Carregando...</div>
    <?php endif; ?>
    <?php if(session('status') === 'We have emailed your password reset link.'): ?>
        <div>Verifique a sua caixe de seu e-mail</div>
    <?php endif; ?>
</body>
</html><?php /**PATH C:\Gabriel\Projetos\SGBR\1_Hotel_Ecommerce\api\resources\views/auth/forgot-password.blade.php ENDPATH**/ ?>