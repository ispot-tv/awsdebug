# awsdebug
If someone has a AWS permission issue, have them run `./awsdebug.sh` and send you the output.
You'll instantly get all sorts of information you can use to solve the issue.


## Contributing
Please try to keep the script simple and make heavy use of comments.
## Testing
To quickly test run `echo -e "mock command \n mock error" | ./awsdebug.sh`
For debugging you can run `export TRACE=1`
