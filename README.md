# banlv_APP
IOS端的基于景点识别和智能翻译  
具体的说明文档请看imgs目录下的word文档，已经排版好的。
imgs/READme！.doc

大二寒假捣鼓出来的东西，这个基于Swift和ObjectiveC，开发工具是Xcode。实现的功能主要有:  
1️⃣翻译(支持语音，图片，文本，AR)，调用百度翻译的api  
2️⃣景点识别(基于GPS和Google Cloud Vision)  
3️⃣智能推荐周边的吃喝玩乐(尚未完全实现)  
```
```

## 用户登录
用户登录界面如图显示，用户登陆成功后即可进入app主界面。若没有账号，可以在注册卡项中注册新的账号。  
![Alt text](https://raw.githubusercontent.com/wuruofeng/banlv_APP/master/imgs/login1.png)
![Alt text](https://raw.githubusercontent.com/wuruofeng/banlv_APP/master/imgs/login2.png)  

### 推荐与周边

```
```

#### 美食
用户登录成功后就进入了app的推荐与周边界面，其中包括美食、景点、酒店和娱乐四个分推荐卡项，每个分推荐卡项中包含着用户们发布的原创推文，点开一篇推文，将展开此篇推文的详情页，在详情页中，用户可以对文章进行打赏和收藏的操作。
![Alt text](https://raw.githubusercontent.com/wuruofeng/banlv_APP/master/imgs/主界面.png)  

####  景点、酒店、娱乐
![Alt text](https://raw.githubusercontent.com/wuruofeng/banlv_APP/master/imgs/主界面2.png)  

## 翻译与工具
💞主界面  
点击底栏的翻译与工具按钮，即可进入翻译与工具界面，其中包括文本翻译、图片翻译、语音翻译和增强现实（AR）应用四个分卡项。  

![Alt text](https://raw.githubusercontent.com/wuruofeng/banlv_APP/master/imgs/文本翻译.png)  
![Alt text](https://raw.githubusercontent.com/wuruofeng/banlv_APP/master/imgs/语音翻译.png)  
![Alt text](https://raw.githubusercontent.com/wuruofeng/banlv_APP/master/imgs/图片翻译.png)  

## 增强现实（AR）应用
打开增强现实（AR）应用卡项，即会进入一个相机界面，底栏有附近、语言和翻译等按钮和一个象征着AR技术的立方体，点击附近，将跳出附近的分选项，包括美食、酒店、景点和交通设施，选择其中的分选项，将在相机中以AR技术呈现出这些热点；点击翻译，可以自动识别并以AR技术呈现在相机中的文字；点击语言，可以切换翻译的源语言和目标语言；点击小立方体，将以AR技术弹出附近景点的详细介绍，包括文字介绍或视频介绍（重点突出app的智能景点识别功能）。
![Alt text](https://raw.githubusercontent.com/wuruofeng/banlv_APP/master/imgs/二级子菜单.PNG)  
![Alt text](https://raw.githubusercontent.com/wuruofeng/banlv_APP/master/imgs/吃的锚点.PNG)  
![Alt text](https://raw.githubusercontent.com/wuruofeng/banlv_APP/master/imgs/%E5%9B%BE%E7%89%87%201.png)  
![Alt text](https://raw.githubusercontent.com/wuruofeng/banlv_APP/master/imgs/表面渲染.PNG)  
![Alt text](https://raw.githubusercontent.com/wuruofeng/banlv_APP/master/imgs/ar渲染.PNG)  



