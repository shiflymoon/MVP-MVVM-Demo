# MVP-MVVM-Demo
MVP和MVVM Demo
MVP和MVVM比较类似，唯一区别是MVVM多了一层数据和VM的双向或者单向绑定
这个绑定不通过响应式函数编程ReactiveCocoa实现（一、太重量级，学习成本高；二、不方便调试以及问题定位和追踪）
采用FaceBook的KVOController来完成View和VM的绑定。
另外会把数据访问层单独抽离出来，最终其实是MVPS和MVVMS

