<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <?php dump(session()->all()) ?>
    <form action="<?php echo e(route('password.email')); ?>" method="post">
        <?php echo csrf_field(); ?>
        <?php $__errorArgs = ['email'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
            <div class="">Erro: <?php echo e($message); ?></div>
        <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
        <label for="email">E-mail</label>
        <input 
            type="email" 
            name="email" 
            id="email"
        />
        <button type="submit">Enviar</button>
    </form>
</body>
</html><?php /**PATH C:\Gabriel\Projetos\SGBR\1_Hotel_Ecommerce\api\resources\views/auth/forgot-password.blade.php ENDPATH**/ ?>