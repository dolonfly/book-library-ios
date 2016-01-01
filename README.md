# book-library-ios

book-library-ios 是一个简单的内部图书管理系统

主要功能

* 添加图书(条形码扫描、isbn录入)
* 搜索图书(书名、作者)
* 查看图书详情
* 添加购买图书申请
* 预购清单

book-library-ios is a simple internal library management system.

major function

* scanning book and store it
* search books by book name or author
* show book details
* request for book buying
* pre order list

## snapshot

![snapshot](doc/images/snapshot.png)


## preparation

this project is use `CocoaPods` to manage code dependence,so you need install `CocoaPods` first.

CocoaPods is built with Ruby and is installable with the default Ruby available on OS X. if you allready install RubyGems you can skip the follow two steps.

### install ruby on OS X

refer to [How to Install Ruby on a Mac](http://code.tutsplus.com/tutorials/how-to-install-ruby-on-a-mac--net-21664)

### install RubyGems

refer to [Download RubyGems](https://rubygems.org/pages/download)

you may need change official gem source to taobao gem source,you can open [RubyGems 镜像 - 淘宝网](http://ruby.taobao.org/) for more information.

### install coocapods

Using the default Ruby install will require you to use sudo when installing gems. (This is only an issue for the duration of the gem installation, though.)

    sudo gem install cocoapods

for more information , you can visit official website guide [Getting Started](https://guides.cocoapods.org/using/getting-started.html#getting-started)

### install your code dependence

enter you project floder

    cd $projectDir

install dependence

    pod update --verbose --no-repo-update

after you run above command , a file named `*.xcworkspace` will created in your project floder. open it from xcode and you can use the defined dependences in `Podfile`.

## other useful link

[cocoapods install usage](http://code4app.com/article/cocoapods-install-usage)

