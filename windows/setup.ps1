$textart=@'

╔═══╗────╔╗─────╔╗
║╔═╗║────║║─────║║
║║─╚╬══╦═╝╠══╦══╣║─╔══╦══╦╗╔╦══╗
║║─╔╣╔╗║╔╗║║═╣╔╗║║─║══╣╔╗║║║║╔╗║
║╚═╝║╚╝║╚╝║║═╣╚╝║╚╗╠══║╚╝║╚╝║╚╝║
╚═══╩══╩══╩══╩═╗╠═╝╚══╩══╩══╣╔═╝
───────────────║║───────────║║
───────────────╚╝───────────╚╝                                                                                                     
Twitter: @creamychickens1

'@

Write-Host $textart


function downloader($url,$path){
    try{
        $WebClient = New-Object System.Net.WebClient
        $WebClient.DownloadFile($url,$path)
    }catch{
        Write-Host "Download not good!"
    }
}


function unziper($inpath,$outpath){
    try{
        Expand-Archive -LiteralPath $inpath -DestinationPath $outpath
    }catch{
        Write-Host "Unzip not good!"
    }
}

$mylocation=Get-Location


$codeql_binary="https://github.com/github/codeql-cli-binaries/releases/download/v2.5.8/codeql-win64.zip"
$codeql_mainpack="https://github.com/github/codeql/archive/refs/heads/main.zip"
$codeql_gopack="https://github.com/github/codeql-go/archive/refs/heads/main.zip"


downloader $codeql_binary $mylocation\codeql-win64.zip
Write-Host "Codeql Download Complete"

downloader $codeql_mainpack $mylocation\codeql-main.zip
Write-Host "Codeql query pack Download Complete"

downloader $codeql_gopack $mylocation\codeql-go-main.zip
Write-Host "GOlang pack Download Complete"


unziper $mylocation\codeql-win64.zip $mylocation\
Write-Host "Codeql pack unzip Complete"

unziper $mylocation\codeql-main.zip $mylocation\
Write-Host "Codeql query pack unzip Complete"

unziper $mylocation\codeql-go-main.zip $mylocation\
Write-Host "GOlang pack unzip Complete"

