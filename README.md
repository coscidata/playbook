# Coscidata 开发手册

> 用来记录前后端代码风格、开发环境配置、服务器脚本等

## 技术栈

后端：[Python3](https://www.python.org/download/releases/3.0/) + [flask](http://flask.pocoo.org/) + [mysql](https://www.mysql.com/)

前端：[React](https://reactjs.org/) + [And Design](https://ant.design/index-cn)

服务器：[Centos 7](https://www.centos.org/)

## 加速开发

因为不可抗力，前后端系统安装软件及依赖时，有时会非常缓慢，强烈安利以下方式，节约时间。

### brew 换源

使用中科大源（或者清华源，不过最近经常抽风，并且修复速度慢，先不推荐）

* [替换 homebrew 默认源](https://lug.ustc.edu.cn/wiki/mirrors/help/brew.git)
* [替换 homebrew bottles 默认源](https://lug.ustc.edu.cn/wiki/mirrors/help/homebrew-bottles)

### pip 换源

[使用阿里源](http://mirrors.aliyun.com/help/pypi)

### npm 换源

使用淘宝源

1. `npm config set registry https://registry.npm.taobao.org`
1. [cnpm](https://npm.taobao.org/)（使用 create-react-app 时不会走 cnpm，所以更推荐第一个方法）

## 开发环境

### 后端环境

#### Python3

##### 安装

```bash
brew install python3
```

#### virtualenvwrapper

##### 安装

用来管理 python 虚拟环境

```bash
pip3 install virtualenvwrapper
```

添加下列代码到 ~/.zshrc

```zsh
# virtualenvwrapper
if [ `id -u` != '0' ]; then
  export VIRTUALENV_USE_DISTRIBUTE=1        # <-- Always use pip/distribute
  export WORKON_HOME=$HOME/.virtualenvs       # <-- Where all virtualenvs will be stored
  source /usr/local/bin/virtualenvwrapper.sh
  export PIP_VIRTUALENV_BASE=$WORKON_HOME
  export PIP_RESPECT_VIRTUALENV=true
fi
```

##### 使用

在项目根目录，创建虚拟环境

```bash
mkvirtualenv seattle -p python3
```

激活虚拟环境

```bash
workon seattle
```

其它命令

```bash
deactivate # 退出虚拟环境
cdvirtualenv # 进入虚拟环境文件夹
```