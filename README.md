# Coscidata 开发手册

> 用来记录前后端代码风格、开发环境配置、服务器脚本等

<!-- TOC -->

- [技术栈](#技术栈)
- [加速开发](#加速开发)
    - [brew 换源](#brew-换源)
    - [pip 换源](#pip-换源)
    - [npm 换源](#npm-换源)
- [开发环境](#开发环境)
    - [后端环境](#后端环境)
        - [Python3](#python3)
        - [virtualenvwrapper](#virtualenvwrapper)
        - [格式化代码](#格式化代码)
- [最佳实践](#最佳实践)
    - [React 实践](#react-实践)
        - [Container and Presentational Components](#container-and-presentational-components)

<!-- /TOC -->

## 技术栈

后端：[Python3](https://www.python.org/download/releases/3.0/) + [flask](http://flask.pocoo.org/) + [mysql](https://www.mysql.com/)

前端：[React](https://reactjs.org/) + [Ant Design](https://ant.design/index-cn)

服务器：[Centos 7](https://www.centos.org/)

## 加速开发

因为不可抗力，前后端系统安装软件及依赖时，有时会非常缓慢，强烈安利以下方式，节约时间。

### brew 换源

使用中科大源（或者清华源，不过最近经常抽风，并且修复速度慢，先不推荐）

- [替换 homebrew 默认源](https://lug.ustc.edu.cn/wiki/mirrors/help/brew.git)
- [替换 homebrew bottles 默认源](https://lug.ustc.edu.cn/wiki/mirrors/help/homebrew-bottles)

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

#### 格式化代码

使用 [yapf](https://github.com/google/yapf)、[isort](https://github.com/timothycrosley/isort) 和 [flake8](http://flake8.pycqa.org/en/latest/) 来检查、格式化代码

##### 安装

```bash
pip3 install yapf isort flake8

curl https://raw.githubusercontent.com/coscidata/about_code/master/python/.isort.cfg > ~/.isrot.cfg
```

##### 使用

```bash
yapf -ir . -e migrations
isort -rc --atomic .
```

##### 编辑器配置

###### vim

```config
Plug 'fisadev/vim-isort'
autocmd FileType python nnoremap <leader>a :0,$!yapf<Cr>
```

###### vscode

参考[文章](https://github.com/DonJayamanne/pythonVSCode/wiki)配置并使用 flake8 和 yapf

## 最佳实践

### React 实践

#### Container and Presentational Components

在 React 开发中，我们推荐将一个功能拆分为一个 Container 组件和作为其子组件的多个 Presentational 组件。

Container 主要负责获取数据、以及和服务端的交互，然后通过 props 将特定的数据传递给对应的 Presentational 子组件。

这样的好处是能够保证 Presentational 组件拥有良好的复用性，以及它的数据结构是清晰地，大部分的 Presentational 组件都可以写成纯函数的形式：

```
// 没错，每个介绍的文章都要以 CommentList 举例
const CommentList = props => {
  const { comments, handleDelete } = props;
  return (
    <ul> 
      {comments.map(<Comment onDelete={handleDelete} />)} 
    </ul>
  );
};
```

每个 Presentational 组件都会通过 props 中的数据和事件回调与其父级的 Container 组件通信。

使用纯函数编写的组件是无法使用 State 的，但并不等于所有 Presentational 组件都不允许使用 State。我们只是不推荐在 Presentational 组件中直接获取数据，但是依旧可以使用 State 去维持一些样式上的状态，例如 Loading 状态或是切换不同的样式。

我们并不强制要求一个功能只能有一个 Container 组件和多个 Presentational 组件，试想一下如果一个功能所使用的组件数量很多、层级很深，所有事件回调和数据获取都放在最外层的 Container 组件下的话，反而会使代码变得更加混乱，不过我们暂时也没遇到这种复杂的场景。

参考资料：

- [Container Components](https://medium.com/@learnreact/container-components-c0e67432e005)
- [Presentational and Container Components](https://medium.com/@dan_abramov/smart-and-dumb-components-7ca2f9a7c7d0)



