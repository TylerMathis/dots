# lazy git
lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

# thefuck
if ! command -v thefuck &> /dev/null
then
    eval $(thefuck --alias)
fi

# cp
alias c='g++ -g -O2 -std=c++17'
alias r='./a.out < input.in'

init() {
	cp ~/progteam/templates/template.cpp $1.cpp
	code . $1.cpp
}
