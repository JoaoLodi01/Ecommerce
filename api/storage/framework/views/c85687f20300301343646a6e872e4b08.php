<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <?php dump(session()->all()) ?>
    <form action="<?php echo e(route('password.update')); ?>" method="post">
        <?php echo csrf_field(); ?>
        <h1>Token do reset-password.blade.php <?php echo e($token); ?>, </h1>
        <input type="hidden" name="token" value="<?php echo e($token); ?>">

        <label for="email">E-mail</label>
        <input 
            type="email"
            name="email"
        />

        <label for="password">Senha</label>
        <input 
            type="password"
            name="password"
        />

        <label for="password_confirmation">Senha 2</label>
        <input 
            type="password"
            name="password_confirmation"
        />
        
        <button type="submit">Alterar senha</button>
    </form>
</body>
</html><?php /**PATH C:\Gabriel\Projetos\SGBR\1_Hotel_Ecommerce\api\resources\views/auth/reset-password.blade.php ENDPATH**/ ?>