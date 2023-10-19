#!/bin/bash
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./awsdebug.sh

Gathers information to help determine the cause of your aws issue

'
    exit
fi

indent(){ sed 's/^/  /'; }

echo "What is the command or line of code you tried to run? Only type in a single line that is most relevant: "
read command

echo "Copy and paste the error you got here. Only type in a single line: "
read error

echo Gathering more debug information...
identity=$(aws sts get-caller-identity 2>&1)
config=$(aws configure list)
hostname=$(hostname)
awsip=$(curl --silent --max-time 3 http://169.254.169.254/latest/meta-data/local-ipv4)

debugfile=/tmp/aws-$RANDOM.yaml

# | syntax allows yaml to have multiline strings
# it will guess indentation based on first line
# BUT guess may be incorrect. We always indent 2
# so we specify |2 so yaml knows indentation
echo 'Aws config file: |2' >> $debugfile
cat ~/.aws/config | indent >> $debugfile
echo -e '\nCommand: |2\n' >> $debugfile
echo "$command" | indent >> $debugfile
echo -e '\nError: |2\n' >> $debugfile
echo "$error" | indent >> $debugfile
echo -e '\nIdentity: |2\n' >> $debugfile
echo "$identity" | indent >> $debugfile
echo -e '\nConfig: |2\n' >> $debugfile
echo -e "$config" | indent >> $debugfile
echo -e "\nHostname: $hostname" >> $debugfile
echo -e "\nAws private ip: $awsip" >> $debugfile

echo "Done! Please give your sysadmin the report at $debugfile"
echo "To read the report type cat $debugfile"
