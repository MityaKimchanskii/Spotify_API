# No Storyboard


### Create App programmatically
- 1. Remove Storyboard file from the left panel
- 2. Open Targets and then Info and remove Main storyboard file base name and Storyboard Name in Applicatin Scene Manifest
<img src='https://github.com/MityaKimchanskii/NoStoryboard/blob/main/Simple_Animation/img/1.gif' title='image' width='' alt='image' />
- 3. Last step add code


```swift
        func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
        self.window = window
        
    }
```


### Create TabBarController programmatically
```swift

```
