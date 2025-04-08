<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    @php dump(session()->all()) @endphp
    <form action="{{ route('password.email') }}" method="post">
        @csrf
        @error('email')
            <div class="">Erro: {{ $message }}</div>
        @enderror
        <label for="email">E-mail</label>
        <input 
            type="email" 
            name="email" 
            id="email"
        />
        <button type="submit">Enviar</button>
    </form>
</body>
</html>