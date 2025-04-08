<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Document</title>
</head>
<body>
    <div class="flex-center">
        <div class="reset-form">
            <h1 class="reset-title">Recuperar senha</h1>
            <form action="<?php echo e(route('password.email')); ?>" method="post">
                <?php echo csrf_field(); ?>
        
                <input 
                    type="email" 
                    name="email" 
                    id="email"
                    placeholder="Digite um e-mail para envio ..."
                    class="input-spacing"
                />
                <br>
                <button type="submit">Enviar</button>  
            </form>
        
            <div class="status">
                <?php if(session('status') === 'We have emailed your password reset link.'): ?>
                    <div>Verifique a sua caixe de e-mail</div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</body>
<style>
    .reset-form {
        position: relative;
        left: 20rem;
        top: 5rem;
        width: 20rem;
        border: 1px solid black;
        padding: 1.25rem; /* equivalente a p-5 */
        border-radius: 0.5rem; /* equivalente a rounded-lg */
        box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05); /* shadow-xl */
    }

    .reset-title {
        font-size: 1.25rem; /* text-xl */
        border-bottom: 1px solid black;
        width: max-content;
        margin-bottom: 1rem;
    }

    .input-spacing {
        margin-bottom: 1rem; /* mb-4 */
        width: 12rem;

    }

    .status{
        margin-top: 1rem;
        width: 12rem;
        
    }
</style>
</html><?php /**PATH C:\Gabriel\Projetos\SGBR\1_Hotel_Ecommerce\api\resources\views/auth/forgot-password.blade.php ENDPATH**/ ?>