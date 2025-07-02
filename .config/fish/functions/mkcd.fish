function mkcd --description "Create a directory and enter it"
    mkdir -p $argv
    cd $argv
end
