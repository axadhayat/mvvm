# mvvm
Simple implementation of mvvm "template"

To overcome <b>massive view controller</b> problem, and to make our code easily testable we keep our view controllers very thin. There are many thin view controllers architectures like <b>mvvm</b>, <b>viper</b> etc. This repository decpits how can we use mvvm to make our <a href="https://github.com/axadhayat/mvc/blob/main/mvc/ViewController.swift"> mvc view controller </a> bit thin.

<h3> Data binding </h3> 
At the core the most important thing about mvvm is how the "view model" communicates with view controller. Data binding helps us create smooth communication between view models and view controllers. We will be using <b>Boxing</b> for data binding. We can also do this with delegate/protocol pattern or FRP.
