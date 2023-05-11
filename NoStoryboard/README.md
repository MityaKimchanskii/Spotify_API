# Create App programmatically

- 1 Remove Storyboard file from the left panel
- 2 Open Targets and then Info and remove Main storyboard file base name and Storyboard Name in Applicatin Scene Manifest
<img src='https://github.com/MityaKimchanskii/NoStoryboard/blob/main/NoStoryboard/img/1.gif' title='image' width='' alt='image' />
- 3 Last step add code

    A <strong> UIWindowScene <strong/>  object manages one instance of your app’s UI, including one or more windows that you display from that scene. The scene object manages the display of your windows on the user’s device, and the life cycle of that scene as the user interacts with it. When the state of the scene changes, the scene object notifies its delegate object, which adopts the UIWindowSceneDelegate protocol. The scene also posts appropriate notifications to registered observers. Use the delegate object or notification observers to respond to any changes.
    
    <strong>Windows<strong/> work with your view controllers to handle events and to perform many other tasks that are fundamental to your app’s operation. UIKit handles most window-related interactions, working with other objects as needed to implement many app behaviors.
    
    <strong>makeKeyAndVisible()<strong/> Shows the window and makes it the key window.

```swift
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
        self.window = window
        
    }
```
