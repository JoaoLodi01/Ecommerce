<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
    <body>
        <div class="flex-center">
            <div class="reset-form">
                <h1 class="reset-title">Recuperar senha</h1>
                <form action="{{ route('password.update') }}" method="post">
                    @csrf
                   
                    <input type="hidden" name="token" value="{{ $token }}">
    
                    <input 
                        type="email" 
                        name="email" 
                        id="email"
                        placeholder="Digite o seu e-mail ..."
                        class="input-spacing"
                    />
                   
                    <input 
                        type="password" 
                        name="password" 
                        id="password"
                        placeholder="Digite a sua nova senha ..."
                        class="input-spacing"
                    />
                    <br>
                    <input 
                        type="password" 
                        name="password" 
                        id="password"
                        placeholder="Confirme a sua nova senha ..."
                        class="input-spacing"
                    />
                    <br>
                    <button type="submit">Alterar senha</button>
                </form>
            </div>
        </div>
</body>

<style>
    .reset-form {
        position: relative;
        left: 27rem;
        top: 5rem;
        width: 13rem;
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

</style>


</html>