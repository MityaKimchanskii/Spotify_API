# UIViewAnimation

## animate(withDuration:delay:options:animations:)

UIView class has a method animate(withDuration:delay:options:animations:)

- withDuration: the duration of the animation.
- delay: the amount of seconds before animation starts.
- optons: customization a animation with a array of different options
    - .repeat: make your animation loop
    - .autoreversw: play animation and the reverse
    - .curveLinear
    - .curveEaseIn: acceleration to the start of the animation
    - .curveEaseOut: decceleration to the end of the animation
    - .curveEaseInOut: acceleration and decceleration
- animation: the closure to provide your animation
- completion: the closure to execute when the animation completes

```swift

        UIView.animate(withDuration: 1.5, delay: 0, options: [.repeat, .autoreverse, .curveEaseOut]) {
            self.titleLable.center.x += self.view.bounds.width
        }
        
        UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 0.2, initialSpringVelocity: 0) {
            self.loginButton.center.y -= 30
            self.loginButton.alpha = 1
        }
        
        UIView.animate(withDuration: 1.5, delay: 0.3) {
            self.usernameTexField.center.x += self.view.bounds.width
        }
        
        UIView.animate(withDuration: 1.5, delay: 0.6) {
            self.passwordTextField.center.x += self.view.bounds.width
        }
        
        UIView.animate(withDuration: 3, delay: 0) {
            self.cloudImage1.alpha = 1
        }
        
        UIView.animate(withDuration: 3, delay: 0.5) {
            self.cloudImage2.alpha = 1
        }
        
        UIView.animate(withDuration: 3, delay: 1) {
            self.cloudImage3.alpha = 1
        }
        
        private func cloudAnimation(cloud: UIImageView, delay: TimeInterval) {
            let cloudSpeed = 30.0 / view.frame.size.width
            let cloudDuration = (view.frame.size.width - cloud.frame.origin.x) * cloudSpeed
        
            UIView.animate(withDuration: cloudDuration, delay: delay, options: [.repeat, .curveLinear], animations: {
                cloud.frame.origin.x = self.view.frame.size.width
            }) { _ in

            }
        }

```

## Animatable properties

Not all view properties can be animated.

- bounds: reposition view's content' within the view's frame
- frame: move or scale the view
- center: move view to a new location on screen
- backgroundColor: to change color of the view
- alpha: to change fade-in/fade-out property
- transform: rotation, scale, position animation

The properties like size and center are mutable so we can move verticaly and horizontaly by changing `center.y` 
    or shrink a view by decreasing `frame.size.width`

## Spring Animation

- usingSpringWithDamping: amount of dumping from value 0.0 to 1.0. 
- initialSpringVelocity: controls the initial velocity of the animation. A value from 0.0 to 1.0

```swift

        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0) {
            self.loginButton.bounds.size.width -= 30
            self.loginButton.alpha = 1
        }
   
```

<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/ViewAnimation/img/1.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Transition Animation transition(with:duration:options:animations:completion:)
- transitionFlipFromLeft
- transitionFlipFromRight
- transitionCurlUp
- transitionCurlDown
- transitionCrossDissolve
- transitionFlipFromTop
- transitionFlipFromBottom

```swift

    private func transitionAnimation(index: Int) {
        messageLabel.text = statusMessages[index]
        
        UIView.transition(with: statusImageView, duration: 1, options: [.curveEaseOut, .transitionCurlDown], animations: {
            self.statusImageView.isHidden = false
        }) { _ in
           
        }
    }
   
```

<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/ViewAnimation/img/2.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Cube Transition Animation

```swift

        private func cubeTransition(label: UILabel, text: String, direction: AnimationDirection) {
        let auxLabel = UILabel(frame: label.frame)
        auxLabel.text = text
        auxLabel.font = label.font
        auxLabel.textColor = label.textColor
        auxLabel.textAlignment = label.textAlignment
        
        let auxLabelOffset = CGFloat(direction.rawValue) * label.frame.size.height / 2.0
        
        auxLabel.transform = CGAffineTransform(translationX: 0.0, y: auxLabelOffset).scaledBy(x: 1.0, y: 0.1)
        label.superview?.addSubview(auxLabel)
        
        UIView.animate(withDuration: 5, delay: 0.0, options: [.repeat, .autoreverse, .curveEaseOut], animations: {
            auxLabel.transform = .identity
            label.transform = CGAffineTransform(translationX: 0.0, y: -auxLabelOffset).scaledBy(x: 1.0, y: 0.1)
        }, completion: { _ in
            label.text = auxLabel.text
            label.transform = .identity
            
            auxLabel.removeFromSuperview()
        })
    }
    
```
<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/ViewAnimation/img/3.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
