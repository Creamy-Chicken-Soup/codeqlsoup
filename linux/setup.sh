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


`wget -c https://github.com/github/codeql-cli-binaries/releases/download/v2.5.8/codeql-linux64.zip -O codeql-linux64.zip`
git clone "https://github.com/github/codeql"
git clone "https://github.com/github/codeql-go"

mv ./codeql ./codeql-main

unzip ./codeql-linux64.zip

sudo apt-get install -y jq





