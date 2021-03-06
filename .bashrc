# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias adbs='adb logcat -b system'
    alias d='adb devices'
    alias rr='adb root;adb remount'
    alias rrs='adb root;adb remount;adb shell'
    alias 51='lsusb;sudo subl /etc/udev/rules.d/51-android.rules'
    alias fn='find -iname'
    alias mycode='nautilus /home/ubuntu/file/My_Code/'
    alias code='cd /home/ubuntu/file/Code/'
    alias tool='nautilus /home/ubuntu/file/Tools/'
    alias fd='sudo fdisk -l'
    # alias adb='cd /home/ubuntu/Android/Sdk/platform-tools;./adb'
    alias dex='sh /home/ubuntu/file/Tools/Decompile/dex2jar-2.0/d2j-dex2jar.sh'
    # alias jd_gui='cd /home/ubuntu/file/Tools/Decompile/jd-gui-0.3.5.linux.i686/;./jd-gui'
    alias apktool='/home/ubuntu/file/Tools/Decompile/apktool'
    # alias c='adb shell dumpsys window | grep mCurrentFocus'
    alias c='sh /home/ubuntu/桌面/Github/Diy_Tool/c.sh'
    alias ard='adb root;adb disable-verity'

    alias work='. '/home/ubuntu/桌面/My_platform/shell.sh' '
    alias am='adb shell am start -n '
    # alias plm='adb shell pm list packages'
    alias rs='repo forall -c "pwd && git clean -df && git checkout . && git pull" ; repo sync -j8'
    alias fa='adb reboot bootloader && export ANDROID_PRODUCT_OUT=./ && fastboot flashall'
    alias show='git log -p '
    # alias adbver='adb shell getprop | grep ro.semc.version'
    alias getp='adb shell getprop | grep '
    alias bashrc='sudo subl ~/.bashrc'
    alias mem='cat /proc/meminfo  | grep MemFree'
    alias gc='git checkout .'
    alias gp='git pull'
    alias gd='git clean -df'
    alias aa='aapt dump badging'
    alias ylog='chmod 777 ./analyzer.py && ./analyzer.py'
    alias sign='jarsigner -verify -verbose -certs  '
    alias plm='sh /home/ubuntu/桌面/Github/Diy_Tool/package.sh  '

fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

function gw {
	grep -i -E "$1" * -nr
}

function gw2 {
	echo	"find -name '*.php'|xargs grep 'include'//在当前目录及其子目录的php文件中查找include字符串"
	read NAME
	find -name "$1"|xargs grep "$2"
}


function pid {
    adb logcat --pid="$1"
}


function code_help {
	echo "$ source build/envsetup.sh"
	echo "$ mmm development/tools/idegen/"
	echo "$ development/tools/idegen/idegen.sh"

	source build/envsetup.sh
	lunch
	mmm development/tools/idegen/
	sudo development/tools/idegen/idegen.sh
	ls |grep android.i*

}


function _git_help_branch {
	echo    "$ git branch -a"
	echo    "$ repo start Black_Monster2 --all origin/ZQL1818_INFINIX"
    echo    "$ git add .            （将当前目录下所有修改过的文件添加至索引库中）"
    echo    "$ git commit -m \"[QL1819-1][XLESQLYBYJ-516][BUG][COMMON][SimSettings][JIRA]There is a wrong word name in Portuguese \""
    echo    "$ repo upload ."

    echo    "$ git branch -D 分支名(删除分支)"
    echo    "$ repo start huaqin .(提交代码直接目录下新建分支)"

}

function seLinux {
	echo    "$ setenforce 0"
	echo    "$ 设置SELinux 成为permissive模式 宽容模式。违反 SELinux 规则的行为只会记录到日志中。一般为调试用。"
	echo    "$ setenforce 1"
	echo    "$ 设置SELinux 成为enforcing模式 强制模式。违反 SELinux 规则的行为将被阻止并记录到日志中。"
	echo	"$ getenforce 获取当前 SELinux 运行状态"
}


#查找文件夹
function fdir {
	sudo find ./  -name "$1" -type d
}



export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo/'

function gh {
    echo    "
    查看分支：git branch

    创建分支：git branch <name>

    切换分支：git checkout <name>

    创建+切换分支：git checkout -b <name>

    合并某分支到当前分支：git merge <name>

    删除分支：git branch -d <name>

    克隆项目：git clone https://github.com/huoyahuoya/other.git

    创建一个全新的仓库：    …or create a new repository on the command line

    echo \"# other\" >> README.md

    git init

    git add README.md

    git commit -m \"first commit\"

    git remote add origin https://github.com/huoyahuoya/other.git

    git push -u origin master

    将一个已经存在的仓库上传到github：    …or push an existing repository from the command line

    git remote add origin https://github.com/huoyahuoya/other.git
    
    git push -u origin master"


}


function _git_help_log {
	echo	"commit失败：
	git reset --hard cd7814c8b0a14c4d346a128a9ac1558f43d129fb   返回某个节点
	git pull --rebase   修改不变更新
	git commit --amend

	git stash
	git stash pop

	repo start gly --all master 创建分支
	git status .
	git diff Android.mk
	git diff .
	git add .
	git commit -m \"[QL1818-1][BUG][Infinix][Settings][][] test\"
	repo upload .
	git checkout BASE
	git branch -a
	提交代码步骤
	 git status .
	git diff .
	 git add .
	git commit -m \"[QL1819-634][Infinix][BUG][Settings][][] clear defaults缺失左边框\"
	repo upload .
	去服务器填review人

	git log
	git log --pretty=oneline
	git reset --hard 1094a(--hard干掉修改)
	git clean -df
	git reflog 记录你的每一次命令
	git reset HEAD readme.txt  撤销add之后
	git checkout -- file add之前还原文件
	git reset HEAD^	回退到最新的上一笔"
}

function _git_help_diff {
	echo	"Git diff branch1 branch2 --stat   显示出所有有差异的文件列表"
	echo	"Git diff branch1 branch2 文件名(带路径)   显示指定文件的详细差异"
	echo	"Git diff branch1 branch2                   显示出所有有差异的文件的详细差异"
	echo	"git diff --binary  commit_ID1 -> commit_ID2 >~/modem.diff 包括二进制文件的diff文件(从状态1diff到状态2)"
}

function ghelp {
    clear
    echo    "(1)git_help_branch
(2)git_help_diff
(3)git_help_log"
    read git_help_number
    case $git_help_number in
        1)
            _git_help_branch
            ;;
        2)
            _git_help_diff  
            ;;
        3)
            _git_help_log
            ;;
    esac
}


function tomcat8_help {
    echo    "    tomcat8 常用命令
    sudo service tomcat8 start   启动Tomcat服务
    sudo service tomcat8 stop    关闭Tomcat服务
    sudo service tomcat8 status  查看Tomcat服务状态
    sudo service tomcat8 restart 重启Tomcat服务"
}

function _skip_the_boot_Guide {
    # 跳过开机向导
    adb shell settings put secure user_setup_complete 1
    adb shell settings put global device_provisioned 1
    adb reboot
}

function log_analyse {
    echo "/home/ubuntu/file/Code/A6_ali/frameworks/base/services/core/java/com/android/server/am/EventLogTags.logtags"
    echo "/home/ubuntu/file/Code/1628_HTC/frameworks/base/preloaded-classes"
}


function modem_4.9 {
	sudo rm /usr/bin/gcc
	sudo rm /usr/bin/gcc-ar
	sudo rm /usr/bin/gcc-nm
	sudo rm /usr/bin/gcc-ranlib
	sudo ln -s gcc-4.9 gcc
	sudo ln -s gcc-ar-4.9 gcc-ar
	sudo ln -s gcc-nm-4.9 gcc-nm
	sudo ln -s gcc-ranlib-4.9 gcc-ranlib

}


function modem_5 {
	sudo rm /usr/bin/gcc
	sudo rm /usr/bin/gcc-ar
	sudo rm /usr/bin/gcc-nm
	sudo rm /usr/bin/gcc-ranlib
	sudo ln -s gcc-5 gcc
	sudo ln -s gcc-ar-5 gcc-ar
	sudo ln -s gcc-nm-5 gcc-nm
	sudo ln -s gcc-ranlib-5 gcc-ranlib
	
}

function modem_help {
    sudo apt install libswitch-perl
    sudo apt install libfile-copy-recursive-perl
    sudo apt install libxml-simple-perl
}


function modem_code	{
	rm `find -name DbgInfo_DSP*`
	rm `find -name *.EDB*`
}

function temp_modem {
    cd src/mcu/temp_modem
    cp single_bin_modem.bin md1img.img
    zip -r md1img.zip md1img.img
}

LD_PRELOAD=/opt/sublime_text/libsublime-imfix.so