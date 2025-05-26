<?php

function checkExists()
{
    $path = './public/auth/data_auth_.json';
    $dir = dirname($path);
    
    if(!is_dir($dir))
    {
        echo "O caminho não existe \n";
        return array(
            'exist' => false
        );
    }
    
    echo "O caminho existe \n";
    return array(
        'exist' => true,
        'path' => $path
    );
 
}

function saveAuthFile(array $owner, array $path)
{
    $file = $path['path'];
    if($path['exist'])
    {
        $fileData = fopen($file, 'a');
        
    }
}

function readAuthFile(string $token, array $path)
{
    if($path['exist'])
    {
        $jsonString = file_get_contents($path['path']);
        $jsonData = json_decode($jsonString, true);
        
        foreach ($jsonData as $data) {
            if(isset($data['owner_token']) && $data['owner_token'] === $token)
            {
                return 'tem';
            }
        }
        
        return 'não tem';
    }
        
}

$exists = checkExists();
    
$token = 'fgfghRTB';

$owner = array(
    'name' => 'Teste',
    'usse_id' => 'Sq55KazkrO'
    
);

echo readAuthFile($token, $exists);