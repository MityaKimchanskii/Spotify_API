# Animation

UIView animate method with duration: 

```swift

    private func buttonsActivation() {
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .primaryActionTriggered)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .primaryActionTriggered)
    }
    
    @objc private func leftButtonTapped() {
        UIView.animate(withDuration: 1) {
            self.lineView.backgroundColor = .systemPink
            self.lineView.frame = CGRect(x: 0, y: 48, width: self.stackView.frame.width/2, height: 5)
        }
    }
    
    @objc private func rightButtonTapped() {
        UIView.animate(withDuration: 1) {
            self.lineView.backgroundColor = .systemCyan
            self.lineView.frame = CGRect(x: 100, y: 48, width: self.stackView.frame.width/2, height: 5)
        }
    }

```

<img src='https://github.com/MityaKimchanskii/Spotify_API_And_Swift_Library/blob/main/Simple_Animation/images/1.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

CASpringAnimation:

```swift

        private func scaleAnimation() {
        let scaleAnimation = CASpringAnimation(keyPath: "transform.scale")
        
        scaleAnimation.fromValue = 2
        scaleAnimation.toValue = 1
        scaleAnimation.duration = 5
        scaleAnimation.damping = 10
        
        button.layer.add(scaleAnimation, forKey: "scale")
    }
    
```

<img src='https://github.com/MityaKimchanskii/Spotify_API_And_Swift_Library/blob/main/Simple_Animation/images/2.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

CABasicAnimation:

```swift

    private func colorAnimation() {
        let colorAnimation = CABasicAnimation(keyPath: "borderColor")
        colorAnimation.fromValue = UIColor.black.cgColor
        colorAnimation.toValue = UIColor.systemRed.cgColor
        colorAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        colorAnimation.duration = 3
        colorAnimation.speed = 1
        colorAnimation.repeatCount = .infinity
        colorAnimation.autoreverses = true
        
        imageView.layer.add(colorAnimation, forKey: "borderColor")
    }
    
```

<img src='https://github.com/MityaKimchanskii/Spotify_API_And_Swift_Library/blob/main/Simple_Animation/images/3.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Animation using NSLayoutConstraints:

```swift

    public func animate() {
        let animation1 = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
            self.labelLeadingAnchor?.constant = 0
            self.layoutIfNeeded()
        }
        animation1.startAnimation()
    }

```
<img src='https://github.com/MityaKimchanskii/Spotify_API_And_Swift_Library/blob/main/Simple_Animation/images/4.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
