# MVVM in Swift

`MVVM` was proposed by John Gossman in 2005. Interestingly the view should consist only of visual elements — and not make network calls or similar.All architectures have advantages and disadvantages, but MVVM has become increasingly popular in implementations.

<img src='https://github.com/MityaKimchanskii/Spotify_API_And_Swift_Library/blob/main/MVVMExample/img/2.png' title='image' width='' alt='image' />
MVVM stands for “Model View ViewModel”, and it’s a software architecture often used by Apple developers to replace MVC. In MVC the way most Apple developers practice it, the view controller forms part of the Controller layer (the C in MVC), which means it’s responsible for doing lots of layout as well as being a general dumping ground for functionality. In MVVM view controllers are considered part of the V layer, which means their job is to focus specifically on layout and the view lifecycle – viewDidLoad() and so on. In its place a new object is created called the view model, which is effectively most of the code you had in your view controller before except without UIKit attached. That is, it should be capable of responding to requests for data, and so on, except it shouldn’t reference any user interface controls. This might seem like you’re just pointlessly moving code around, but the difference is important: because your view model is more like a model than like a view you can write tests for it more easily. Rather than having to mock up a UITextField to insert some data, you should be able to call a method that accepts a string because your view model shouldn’t rely on any user interface components. While all this sounds positive, MVVM does have a big drawback on iOS: it relies on a system of two-way bindings that can communicate view data to your view model, otherwise you need to do a lot of work shuttling data around yourself.

### MVVM basically contains 3 components.

`Model` – Model is a wrapper which hold the data.

`View` – Representation of UI or Views in the hierarchy.

`View Model` –  It is responsible for all business logic. If the ViewController has a label, it triggers entire calls and sends & receives data. It is completely independent of the ViewController. It receives information from the ViewController, processes all this information & sends the results back to ViewController.

`ViewController` – It is responsible for setting up UI views. There is no direct interaction between the ViewController & Model and it no longer needs to worry about business logic. It should go through ViewModel and request for what it requires in a ready-to-display format.

<img src='https://github.com/MityaKimchanskii/Spotify_API_And_Swift_Library/blob/main/MVVMExample/img/1.png' title='image' width='' alt='image' />


### Data Flow in MVVM
`View –> View Model –> Model` - user will take action on view and those action will update the data in View Model. Then View Model will update the Model after putting bussiness logic or simply directly update the model.
<img src='https://github.com/MityaKimchanskii/Spotify_API_And_Swift_Library/blob/main/MVVMExample/img/3.png' title='image' width='' alt='image' />

`Model –> View Model –> View` - once model get updated with the latest data it will notify to the View Model and View Model will update the newly data to view.
<img src='https://github.com/MityaKimchanskii/Spotify_API_And_Swift_Library/blob/main/MVVMExample/img/4.png' title='image' width='' alt='image' />
