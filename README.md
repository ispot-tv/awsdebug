# awsdebug
If someone has a AWS permission issue, have them run `./awsdebug.sh` and send you the output.
It's a quick way of getting the following information:
* AWS Config file
* Command or code that was ran
* Full error
* Identity
* Where identity is configured from
* hostname
* Private IP address (if in EC2)


The output is yaml so it's equally easy for humans and machines to read. If you want to get fancy, you can design another program to read in the yaml and do further debugging!

# Usage
Send the user the following message:

Can you run the following and send me the output please? It will help me debug your issue.

`curl -s 'https://raw.githubusercontent.com/ispot-tv/awsdebug/main/awsdebug.sh' | bash`


## Contributing
Please try to keep the script simple and make heavy use of comments.

## Testing
To quickly test run `echo -e "mock command \n mock error" | ./awsdebug.sh`.
For debugging you can run `export TRACE=1`
