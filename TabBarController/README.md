# Create TabBarController and NavigationController programmatically


```swift
   private func setupTabBarController() {
        let vc1 = ViewController1()
        let vc2 = ViewController2()
        let vc3 = ViewController3()
        
        vc1.title = "Controller 1"
        vc2.title = "Controller 2"
        vc3.title = "Controller 3"
        
        let nc1 = UINavigationController(rootViewController: vc1)
        let nc2 = UINavigationController(rootViewController: vc2)
        let nc3 = UINavigationController(rootViewController: vc3)
        
        nc1.tabBarItem = UITabBarItem(title: "Controller 1", image: UIImage(systemName: "person.fill"), tag: 1)
        nc2.tabBarItem = UITabBarItem(title: "Controller 2", image: UIImage(systemName: "person.2.fill"), tag: 2)
        nc3.tabBarItem = UITabBarItem(title: "Controller 3", image: UIImage(systemName: "person.3.fill"), tag: 3)
        
        
        for nav in [nc1, nc2, nc3, ] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([nc1, nc2, nc3], animated: true)
    }
    
```

<img src='https://github.com/MityaKimchanskii/Spotify_API_And_Swift_Library/blob/main/TabBarController/img/1.gif' title='image' width='' alt='image' />
