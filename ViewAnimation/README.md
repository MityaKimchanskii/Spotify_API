# UIView Animation

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

## Fade and bounce transition animation

```swift

    func fadeAndBounce(label: UILabel, text: String, offset: CGPoint) {
        let auxLabel = UILabel(frame: label.frame)
        auxLabel.text = text
        auxLabel.font = label.font
        auxLabel.textAlignment = label.textAlignment
        auxLabel.textColor = label.textColor
        auxLabel.backgroundColor = .clear
        
        auxLabel.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
        auxLabel.alpha = 0
        view.addSubview(auxLabel)
        
        UIView.animate(withDuration: 1, delay: 0.0, options: [.repeat, .curveEaseIn]) {
            label.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
            label.alpha = 0.0
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [.repeat, .curveEaseIn], animations: {
            auxLabel.transform = .identity
            auxLabel.alpha = 1.0
        }, completion: { _ in
            auxLabel.removeFromSuperview()
            label.text = text
            label.alpha = 1.0
            label.transform = .identity
        })
    }

```
<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/ViewAnimation/img/4.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Keyframe Animation .animateKeyframes(withDuration:delay:options:animations:completion:)

The options for keyframes are defferent. 
UIViewKeyFrameAnimationOptions enumeration 

```swift

    private func hitTheBall() {
        let originalCenter = ballImage.center
        
        UIView.animateKeyframes(withDuration: 5, delay: 0, options: [.repeat], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.25) {
                self.ballImage.center.x += 400
                self.ballImage.center.y -= 500
                self.ballImage.alpha = 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
              self.ballImage.transform = CGAffineTransform(rotationAngle: 5 * .pi)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01) {
                self.ballImage.transform = .identity
                self.ballImage.center = CGPoint(x: 0, y: originalCenter.y)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.45) {
                self.ballImage.alpha = 1
                self.ballImage.center = originalCenter
            }
        })
    }

```
<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/ViewAnimation/img/5.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## AutoLayout Animation

```swift

    @objc private func plusButtonTapped() {
        isOpen = !isOpen
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: [.curveEaseIn]) {
            self.titleLabel.text = self.isOpen ? "Close" : "Open"
            self.topViewHeightConstranint?.constant = self.isOpen ? 160 : 80
            let angle: CGFloat = self.isOpen ? .pi/4 : 0
            self.plusButton.transform = CGAffineTransform(rotationAngle: angle)
            self.view.layoutIfNeeded()
        }
    }
    
```
<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/ViewAnimation/img/6.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

# Core Animanimation

Animatable properties :
 - position and size
    - bounds
    - position
    - transform
 - border
    - borderColor
    - cornerRadius
    - borderWidth
 - shadow
    - shadowOffset: appear closer or away
    - shadowOpacity: shadow fade in or out
    - shadowRadius: control the blur of the shadow
 - contents
    - contents: modify to assign raw TIFF or PNG data as the layer contents
    - mask: establish the shape
    - opacity: animate the transparency

A `CABasicAnimation` object is just a data model, which is not bound to any particular layer.
`add(_:forKey:)` makes a copy of the animation object. 


```swift
    
    private func basicAnimation() {
        let rightMove = CABasicAnimation(keyPath: "position.x")
        rightMove.fromValue = -view.bounds.size.width/2
        rightMove.toValue = view.bounds.size.width/2
        rightMove.duration = 3
        rightMove.fillMode = CAMediaTimingFillMode.both
        titleLabel.layer.add(rightMove, forKey: nil)
        
        rightMove.beginTime = CACurrentMediaTime()+1
        usernameTexField.layer.add(rightMove, forKey: nil)
        usernameTexField.isHidden = false
       
        rightMove.beginTime = CACurrentMediaTime()+2
        passwordTextField.layer.add(rightMove, forKey: nil)
        passwordTextField.isHidden = false
    }
    
```

    - fromValue: position at the beginning of the animation
    - toValue: position at the end of the animation
    - duration: duration of the animation
    - beginTime: specific time when to start the animation
    - .layer.add(rightMove, forKey: nil): method to animate layer
    - CAMediaTimingFillMode: very important property, because it controls the behavior at the beginnigd and at the end.
        it has a three values:
            - forwards: retains the final frame
            - backwards: displays the first frame of your animation instantly on the screen, regardless of the actual start time of the animation, and starts the animation at a later time
            - both: combination forwards and backwards
            - remove: removes visible representation from the screen ("phantom"). By default is true.
   
<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/ViewAnimation/img/7.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

fade in effect for clouds:

```swift

    private func cloudAnimation() {
        let fadeIn = CABasicAnimation(keyPath: "opacity")
        fadeIn.fromValue = 0.0
        fadeIn.toValue = 1.0
        fadeIn.duration = 3
        fadeIn.fillMode = CAMediaTimingFillMode.backwards
        cloudImage1.layer.add(fadeIn, forKey: nil)
        
        fadeIn.beginTime = CACurrentMediaTime()+1
        cloudImage2.layer.add(fadeIn, forKey: nil)
        
        fadeIn.beginTime = CACurrentMediaTime()+2
        cloudImage3.layer.add(fadeIn, forKey: nil)
    }

```
<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/ViewAnimation/img/8.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
