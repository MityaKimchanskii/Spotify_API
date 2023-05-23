# NotificationCenter

Use NotificationCenter when we need to pass a message from a view controller through multiple view controllers. To fire notification use post method:

```swift

    NotificationCenter.default.post(name: "NotificationName", object: nil)
    
```

To broadcast a message, use the addObserver method:

```swift

    NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: "NotificationName", object: nil)

```


