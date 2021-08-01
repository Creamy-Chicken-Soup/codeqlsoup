#########################################################
####################configuration########################
$mylocation=Get-Location

#projectname
$databsename="$mylocation\databases\pixi"

#language for your project   
$language="javascript"

#command for some language like java.if not need set $null                      
$command=$null    

#source code you want to test                          
$source_root="$mylocation/apps/Pixi" 

#number of thread for analysis       
$threads=1

#type of the output.it's csv or sarif-latest
$format="sarif-latest"

#output location
$output="$mylocation\results\xssreflect.json"

#query for test
$query="$mylocation/codeql-main/javascript/ql/src/Security/CWE-079/ReflectedXss.ql"

#total result in cve location
$TotalResultPath="$mylocation\results\total.csv"

####################################################################################


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


function makdir($path,$name){
    New-Item -Path $path -Name $name -ItemType "directory" -Force
}



$codeql_binary="$mylocation\codeql\codeql.exe"


makdir $mylocation "databases"
makdir $mylocation "results"


#make databese
if($command -eq $null){
    & $codeql_binary database create $databsename --language=$language --source-root=$source_root
}else{
    & $codeql_binary database create $databsename --language=$language --command=$command --source-root=$source_root
}

#update database
& $codeql_binary database upgrade $databsename

#analysis
& $codeql_binary database analyze --threads=$threads --format=$format --output=$output $databsename $query

Write-Host "Analysis Finished!"


#show result
if($format -like "sarif-latest"){
    if (Test-Path $output -PathType leaf)
    {
        $jsonfile= Get-Content -Raw -path $output | ConvertFrom-Json 
        $uri=$jsonfile.runs.results.codeFlows.threadFlows.locations.location.physicalLocation.artifactLocation.uri 
        $liner=$jsonfile.runs.results.codeFlows.threadFlows.locations.location.physicalLocation.region.startLine 
        $start=$jsonfile.runs.results.codeFlows.threadFlows.locations.location.physicalLocation.region.startColumn
        $end=$jsonfile.runs.results.codeFlows.threadFlows.locations.location.physicalLocation.region.endColumn
        $coder=$jsonfile.runs.results.codeFlows.threadFlows.locations.location.message.text
        $lastresalt=0..($uri.Length-1) | Select-Object @{n="Id";e={$_}}, @{n="Path";e={$uri[$_]}}, @{n="Line";e={$liner[$_]}}, @{n="Start column";e={$start[$_]}}, @{n="End column";e={$end[$_]}}, @{n="code";e={$coder[$_]}} 
        $lastresalt | Format-Table
        $lastresalt | Export-Csv -Path $TotalResultPath -NoTypeInformation
    }
}


