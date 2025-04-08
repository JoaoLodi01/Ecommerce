<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    @php dump(session()->all('status')) @endphp
    <form action="{{ route('password.email') }}" method="post">
        @csrf

        <label for="email">E-mail</label>
        <input 
            type="email" 
            name="email" 
            id="email"
        />
        <button type="submit">Enviar</button>  
    </form>

    @if(session('status') === null)
        <div class="">Carregando...</div>
    @endif
    @if(session('status') === 'We have emailed your password reset link.')
        <div>Verifique a sua caixe de seu e-mail</div>
    @endif
</body>
</html>