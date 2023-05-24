# How to create Skeleton while data is loading

- step 1 - Create protocol

```swift

protocol SkeletonLoadable {}

extension SkeletonLoadable {
    func makeAnimationGroup(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
        
        let animationDuration: CFTimeInterval = 1.5
        
        let anim1 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim1.fromValue = UIColor.systemGray6.cgColor
        anim1.toValue = UIColor.systemGray.cgColor
        anim1.duration = animationDuration
        anim1.beginTime = 0.0
        
        let anim2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim2.fromValue = UIColor.systemGray.cgColor
        anim2.toValue = UIColor.systemGray6.cgColor
        anim2.duration = animationDuration
        anim2.beginTime = anim1.beginTime + anim2.duration
        
        let group = CAAnimationGroup()
        group.animations = [anim1, anim2]
        group.repeatCount = .greatestFiniteMagnitude
        group.duration = anim2.beginTime + anim2.duration
        group.isRemovedOnCompletion = false
        
        if let previousGroup = previousGroup {
            group.beginTime = previousGroup.beginTime + 0.33
        }
        
        return group
    }
}

```
- step 2 - Create skeleton view and confirm protocol. In this case it is tableViewCell. Add two methods:

```swift

    private func setupLayers() {
        profileImageLayer.startPoint = CGPoint(x: 0, y: 0.5)
        profileImageLayer.endPoint = CGPoint(x: 1, y: 0.5)
        profileImageView.layer.addSublayer(profileImageLayer)
        
        nameLabelLayer.startPoint = CGPoint(x: 0, y: 0.5)
        nameLabelLayer.endPoint = CGPoint(x: 1, y: 0.5)
        nameLabel.layer.addSublayer(nameLabelLayer)
        
        occupationLabelLayer.startPoint = CGPoint(x: 0, y: 0.5)
        occupationLabelLayer.endPoint = CGPoint(x: 1, y: 0.5)
        occupationLabel.layer.addSublayer(occupationLabelLayer)
    }
    
    private func setupAnimation() {
        let imageGroup = makeAnimationGroup()
        imageGroup.beginTime = 0.0
        profileImageLayer.add(imageGroup, forKey: "backgroundColor")
        
        let nameGroup = makeAnimationGroup(previousGroup: imageGroup)
        nameLabelLayer.add(nameGroup, forKey: "backgroundColor")
        
        let occupationGroup = makeAnimationGroup(previousGroup: nameGroup)
        occupationLabelLayer.add(occupationGroup, forKey: "backgroundColor")
    }
    
```

- step 3 - Override `layoutSubviews()` method. Everything else is the same as in ProfileCell.

```swift

    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageLayer.frame = profileImageView.bounds
        
        nameLabelLayer.frame = nameLabel.bounds
        nameLabelLayer.cornerRadius = nameLabel.bounds.height/2
        
        occupationLabelLayer.frame = occupationLabel.bounds
        occupationLabelLayer.cornerRadius = occupationLabel.bounds.height/2
    }
    
```

- step 4 - In the viewController , create a boolean variable to check if the network is working. Show the skeleton view first, then when all data is loaded, reload the view.

```swift

    private func fetchData() {
        Networking.shared.fetchCharacters { resulst in
            switch resulst {
            case .success(let profiles):
                self.profiles = profiles
                print(profiles)
                self.isLoaded = true
                self.configureTableCells(with: profiles)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
        }
    }
        
       
```

<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/Skeleton/1.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />




