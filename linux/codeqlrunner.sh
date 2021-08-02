#projectname
databsename="./databases/pixi"

#language for your project   
language="javascript"

#command for some language like java.if not need set $null                      
command=""   

#source code you want to test                          
source_root="./apps/Pixi" 

#number of thread for analysis       
threads=1

#type of the output.it's csv or sarif-latest
format="sarif-latest"

#output location
output="./results/xssreflect.json"

#query for test
query="./codeql-main/javascript/ql/src/Security/CWE-079/ReflectedXss.ql"

#total result in cve location
TotalResultPath="./results/total.csv"

####################################################################################

echo "

╔═══╗────╔╗─────╔╗
║╔═╗║────║║─────║║
║║─╚╬══╦═╝╠══╦══╣║─╔══╦══╦╗╔╦══╗
║║─╔╣╔╗║╔╗║║═╣╔╗║║─║══╣╔╗║║║║╔╗║
║╚═╝║╚╝║╚╝║║═╣╚╝║╚╗╠══║╚╝║╚╝║╚╝║
╚═══╩══╩══╩══╩═╗╠═╝╚══╩══╩══╣╔═╝
───────────────║║───────────║║
───────────────╚╝───────────╚╝                                                                                                     
Twitter: @creamychickens1

"


codeql_binary="./codeql/codeql"

mkdir -p databases
mkdir -p results

#make database

if [ -z "$command" ]
then
    `$codeql_binary database create $databsename --language=$language --source-root=$source_root`
else
    `$codeql_binary database create $databsename --language=$language --command=$command --source-root=$source_root`
fi

#update database

`$codeql_binary database upgrade $databsename`

##analysis

`$codeql_binary database analyze --threads=$threads --format=$format --output=$output $databsename $query`

echo "Analysis Finished!"

#show result
if [[ "$format" == "sarif-latest" ]]
	then
		echo "Path line Start_column End_column code" > $TotalResultPath
total=`cat ./results/xssreflect.json | jq '.runs[].results[].codeFlows[].threadFlows[].locations[].location[] | .artifactLocation.uri,.region.startLine,.region.startColumn,.region.endColumn,.text' | sed '/null/d' | xargs -L5` 

		echo "Path line Start_column End_column code \n$total"
		echo "$total" >> $TotalResultPath

fi




