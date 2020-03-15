# About setup
1、有时候我们需要在执行真正的测试之前做一下配置工作，我们可以使用 setup 和 setup_all 这两个宏。setup 在某个测试用例之前都会被运行，setup_all 只会在整套测试之前运行一次。它们两个的返回值是元组：{:ok, state}，其中 state 可以再后续的测试中被使用。这个state将会以第二参数回传的test方法中


