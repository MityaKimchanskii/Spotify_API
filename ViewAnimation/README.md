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

## Layer animation

    - fromValue: position at the beginning of the animation
    - toValue: position at the end of the animation
    - duration: duration of the animation
    - beginTime: specific time when to start the animation
    - .layer.add(rightMove, forKey: nil): method to animate layer
    - CAMediaTimingFillMode: very important property, because it controls the behavior at the beginnigd and at the end.
        it has a three values:
            - forwards: retains the final frame
            - backwards: displays the first frame of your animation instantly on the screen, 
                regardless of the actual start time of the animation, and starts the animation at a later time
            - both: combination forwards and backwards
            - remove: removes visible representation from the screen ("phantom"). By default is true.
   
<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/ViewAnimation/img/7.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

fade in effect for clouds:

```swift

    private func cloudFadeInAnimation() {
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
    
    private func cloudAnimation(layer: CALayer) {
        let cloudSpeed = 60 / Double(view.layer.frame.size.width)
        let duration: TimeInterval = Double(view.layer.frame.size.width - layer.frame.origin.x) * cloudSpeed
        
        let cloudMove = CABasicAnimation(keyPath: "position.x")
        cloudMove.duration = duration
        cloudMove.toValue = self.view.bounds.width + layer.bounds.width / 2
        cloudMove.delegate = self
        cloudMove.setValue("cloud", forKey: "name")
        cloudMove.setValue(layer, forKey: "layer")
        layer.add(cloudMove, forKey: nil)
        
    }
    
    private func fadeInLabelAnimation() {
        let leftMove = CABasicAnimation(keyPath: "position.x")
        leftMove.fromValue = infoLabel.layer.position.x + view.frame.size.width
        leftMove.toValue = infoLabel.layer.position.x
        leftMove.duration = 5
        infoLabel.layer.add(leftMove, forKey: "infoappear")
        
        let fadeLabelIn = CABasicAnimation(keyPath: "opacity")
        fadeLabelIn.fromValue = 0.1
        fadeLabelIn.toValue = 1
        fadeLabelIn.duration = 5
        infoLabel.layer.add(fadeLabelIn, forKey: "fadein")
        
        titleLabel.layer.add(fadeLabelIn, forKey: "fadein")
    }

```
<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/ViewAnimation/img/8.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Animation Keys and Delegates

Core Animation gives opportunity react to animation events, we can receive delegate callbacks for when an animations begins and ends.
CAAnimation and its subclass CABasicAnimation implement the delegate pattern and let you respond to animation events.

`CAAnimationDelegate`:

```swift

    extension BasicsOfCALayuerAndCoreAnimation: CAAnimationDelegate {
        func animationDidStart(_ anim: CAAnimation) {
            print("animation did start")
        }
    
        func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
            guard let name = anim.value(forKey: "name") as? String else { return }
        
            if name == "form" {
                let layer = anim.value(forKey: "layer") as? CALayer
                anim.setValue(nil, forKey: "layer")
            
                let pulse = CABasicAnimation(keyPath: "transform.scale")
                pulse.fromValue = 1.25
                pulse.toValue = 1
                pulse.duration = 3
                layer?.add(pulse, forKey: nil)
            }
        }
    }

```

Call `removeAllAnimations()` on the layer to stop all running animations or `removeAnimation(forKey:)` to remove just one.

<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/ViewAnimation/img/9.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
## CAAnimationGroup and Animation easing
        CAMediaTimingFunctionName.easeInEaseOut
        CAMediaTimingFunctionName.easeIn
        CAMediaTimingFunctionName.easeOut
        CAMediaTimingFunctionName.linear

```swift

    @objc private func loginButtonTapped() {
        let groupAnimation = CAAnimationGroup()
        groupAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        groupAnimation.beginTime = CACurrentMediaTime()+0.5
        groupAnimation.duration = 0.5
        groupAnimation.fillMode = CAMediaTimingFillMode.backwards
        
        let scaleDown = CABasicAnimation(keyPath: "transform.scale")
        scaleDown.fromValue = 3.5
        scaleDown.toValue = 1
        
        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.fromValue = Double.pi/4
        rotate.toValue = 0
        
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 0
        fade.toValue = 1
        
        groupAnimation.animations = [scaleDown, rotate, fade]
        loginButton.layer.add(groupAnimation, forKey: nil)
    }

```
<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/ViewAnimation/img/10.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Layer Springs CASpringAnimation class
Damped harmonic oscillator systems are what drive the spring animations in iOS. 
- dumping: 10
- mass: 1.0
- stiffness: 100.0
- initialVelocity: 0.0 the initial push

```swift

    @objc private func buttonTapped() {
        let jump = CASpringAnimation(keyPath: "position.y")
        jump.initialVelocity = 100
        jump.mass = 10
        jump.stiffness = 1500
        jump.damping = 50
        jump.fromValue = button.layer.position.y + 30
        jump.toValue = button.layer.position.y
        jump.duration = jump.settlingDuration
        
        button.layer.add(jump, forKey: nil)
    }
    
    private func flashButton() {
        let flash = CASpringAnimation(keyPath: "borderColor")
        flash.damping = 5
        flash.stiffness = 1
        flash.fromValue = UIColor.red.cgColor
        flash.toValue = UIColor.blue.cgColor
        flash.duration = flash.settlingDuration
        flash.repeatCount = .infinity
        button.layer.add(flash, forKey: nil)
    }
    
```
<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/ViewAnimation/img/11.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Layer keyframe animations CAKeyframeAnimation

```swift

    let wobble = CAKeyframeAnimation(keyPath: "transform.rotation")
    wobble.duration = 3
    wobble.repeatCount = 5
    wobble.values = [0.0, 90, 180, 270, 360]
    wobble.keyTimes = [0, 0.25, 0.75, 1]
        
    label.layer.add(wobble, forKey: nil)
    
```

Animating struct values

```swift

    private func flight() {
        let balloon = CALayer()
        balloon.contents = UIImage(systemName: "balloon.fill")?.cgImage
        
        balloon.frame = CGRect(x: -50, y: 0, width: 60, height: 120)
        view.layer.insertSublayer(balloon, below: label.layer)
        
        let flight = CAKeyframeAnimation(keyPath: "position")
        flight.duration = 12
        flight.values = [
            CGPoint(x: view.frame.width, y: 820),
            CGPoint(x: -50.0, y: 360.0),
            CGPoint(x: view.frame.width, y: 0.0),
        ].map { NSValue(cgPoint: $0) }
        flight.keyTimes = [0.0, 0.5, 1.0]
        
        balloon.add(flight, forKey: nil)
        
        balloon.position = CGPoint(x: -50.0, y: button.center.y)
    }

```
<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/ViewAnimation/img/12.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Shapes and masks animation

- path: Morph the layer's shape into a different shape
- lineDashPhase: effect around the shape
- lineWidth: grow or shink the size of the stroke line of your shape

Setup layers: 

```swift

    private func setupLayers() {
        // Draw the photoLayer
        let batmanImage = UIImage(named: "batman")
        photoLayer.contents = batmanImage?.cgImage
        photoLayer.bounds = CGRect(
            x: .zero,
            y: .zero,
            width: 120,
            height: 120
        )
        photoLayer.position = CGPoint(x: 60, y: 0)
        
        // Draw the circleShapeLayer
        circleShalpeLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        circleShalpeLayer.strokeColor = UIColor.white.cgColor
        circleShalpeLayer.lineWidth = lineWidth
        circleShalpeLayer.fillColor = UIColor.clear.cgColor
        circleShalpeLayer.position = CGPoint(x: 0, y: -56)
        
        // Size the maskShapelayer
        maskShapeLayer.path = circleShalpeLayer.path
        maskShapeLayer.position = CGPoint(x: 0.0, y: 10.0)
        
        // add sublayers and mask
        layer.addSublayer(photoLayer)
        photoLayer.mask = maskShapeLayer
        layer.addSublayer(circleShalpeLayer)
    }

```

Add animation:

```swift

    func startAnimation(point: CGPoint, morphSize: CGSize) {
        let originalCenter = center
        
        // UIView animation move to center
        UIView.animate(withDuration: animationDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0) {
            self.center = point
        }
        
        // UIView animation move to originalCenter
        UIView.animate(withDuration: animationDuration, delay: animationDuration, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0,
            animations: { self.center = originalCenter }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self.startAnimation(point: point, morphSize: morphSize)
            }
        }
        
        let morphedFrame = (originalCenter.x > point.x) ?
        CGRect(x: 0.0,y: bounds.height - morphSize.height, width: morphSize.width, height: morphSize.height) :
        CGRect(x: bounds.width - morphSize.width, y: bounds.height - morphSize.height, width: morphSize.width, height: morphSize.height)
        
        let morphAnimation = CABasicAnimation(keyPath: "path")
        morphAnimation.duration = animationDuration
        morphAnimation.toValue = UIBezierPath(ovalIn: morphedFrame).cgPath
        morphAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        circleShalpeLayer.add(morphAnimation, forKey: nil)
        maskShapeLayer.add(morphAnimation, forKey: nil)
    }

```

<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/ViewAnimation/img/14.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Stroke and path layer animation

First create oval shape layer

```swift

    private func drawOvalShapeLayer() {
        ovalShapeLayer.strokeColor = UIColor.white.cgColor
        ovalShapeLayer.fillColor = UIColor.clear.cgColor
        ovalShapeLayer.lineWidth = 5
        ovalShapeLayer.lineDashPattern = [10, 2]
        
        let refreshRadius = frame.size.height/2*0.8
        ovalShapeLayer.path = UIBezierPath(ovalIn: CGRect(
            x: frame.size.width/2-refreshRadius,
            y: frame.size.height/2-refreshRadius,
            width: 2*refreshRadius,
            height: 2*refreshRadius)
        ).cgPath
        
        layer.addSublayer(ovalShapeLayer)
    }

```

Second add airplane layer

```swift

    private func drawAirplaneLayer() {
        let planeImage = UIImage(named: "plane")
        airPlaneLayer.contents = planeImage?.cgImage
        airPlaneLayer.bounds = CGRect(
            x: 0,
            y: 0,
            width: planeImage?.size.width ?? 10,
            height: (planeImage?.size.height) ?? 10
        )
        
        airPlaneLayer.position = CGPoint(
            x: frame.size.width/2 + frame.size.height/2 * 0.8,
            y: frame.size.height/2)
        
        layer.addSublayer(airPlaneLayer)
        airPlaneLayer.opacity = 1
    }
    
```

Third add animation

```swift 

    private func startAnimation() {
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = -0.5
        strokeStartAnimation.toValue = 1.0
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.0
        strokeEndAnimation.toValue = 1.0
        
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1.5
        strokeAnimationGroup.repeatDuration = .infinity
        strokeAnimationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        ovalShapeLayer.add(strokeAnimationGroup, forKey: nil)
        
        let flightAnimation = CAKeyframeAnimation(keyPath: "position")
        flightAnimation.path = ovalShapeLayer.path
        flightAnimation.calculationMode = .paced
        
        let airplaneOrientationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        airplaneOrientationAnimation.fromValue = 0
        airplaneOrientationAnimation.toValue = 2.0 * .pi
        
        let flightAnimationGroup = CAAnimationGroup()
        flightAnimationGroup.duration = 1.5
        flightAnimationGroup.repeatDuration = .infinity
        flightAnimationGroup.animations = [
            flightAnimation,
            airplaneOrientationAnimation
        ]
        airPlaneLayer.add(flightAnimationGroup, forKey: nil)
    }

```
<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/ViewAnimation/img/13.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Gradient Animation

```swift

    private func setupLayers() {
        // Define endpoints
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        // Define colors
        let colors: [CGColor] = [ UIColor.black.cgColor, UIColor.white.cgColor, UIColor.black.cgColor]
        gradientLayer.colors = colors
        
        // Define locations
        let locations: [NSNumber] = [0.25, 0.5, 0.75]
        gradientLayer.locations = locations
        
        // Defin frame
        gradientLayer.frame = CGRect(
            x: -bounds.size.width,
            y: bounds.origin.y,
            width: 3*bounds.size.width,
            height: bounds.size.height)
        
        // Add sublayer
        layer.addSublayer(gradientLayer)
    }
    
    private func setupText() {
        let image = UIGraphicsImageRenderer(size: bounds.size).image { _ in
            "Hello World!".draw(in: bounds, withAttributes: textAttributes)
        }
        
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.clear.cgColor
        maskLayer.frame = bounds.offsetBy(dx: bounds.size.width, dy: 0)
        maskLayer.contents = image.cgImage
        
        gradientLayer.mask = maskLayer
    }
    
    private func gradientAnimated() {
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0, 0, 0.25]
        gradientAnimation.toValue = [0.75, 1, 1]
        gradientAnimation.duration = 5
        gradientAnimation.repeatCount = Float.infinity
        
        gradientLayer.add(gradientAnimation, forKey: nil)
    }

```
<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/ViewAnimation/img/15.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />


## Replicating Animations

CAReplicatorLayer properties:
- instanceCount: number of copies
- instanceTransform: sets the transform
- instanceDelay: sets the animation delay

```swift 

    private func createReplicator() {
        replicatorLayer.frame = view.bounds
        view.layer.addSublayer(replicatorLayer)
        
        dotLayer.frame = CGRect(x: replicatorLayer.frame.size.width-dotSize,
                                y: replicatorLayer.position.y,
                                width: dotSize,
                                height: dotSize)
        dotLayer.backgroundColor = UIColor.black.cgColor
        
        dotLayer.borderColor = UIColor.red.cgColor
        dotLayer.borderWidth = 1
        dotLayer.cornerRadius = 5
        
        replicatorLayer.addSublayer(dotLayer)
        replicatorLayer.instanceCount = Int(view.frame.size.width/dotSize)
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(-dotOffset, 0, 0)
        replicatorLayer.instanceDelay = 0.5
    }

```

<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/ViewAnimation/img/16.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Particle Emitters

```swift

    private func createEmitterLayer() {
        let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        let emitterLayer = CAEmitterLayer()
        emitterLayer.frame = rect
        view.layer.addSublayer(emitterLayer)
        
        emitterLayer.emitterShape = .rectangle
        emitterLayer.emitterPosition = CGPoint(x: rect.width/2, y: rect.height/2)
        emitterLayer.emitterSize = rect.size
        
        let emitterCell = CAEmitterCell()
    
//        emitterCell.contents = UIImage(named: "balloon")?.cgImage
        emitterCell.contents = UIImage(named: "balloon")?.cgImage
//        emitterCell.color = UIColor(red: 0.9, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
//        emitterCell.greenRange = 0.3
//        emitterCell.redRange = 0.3
//        emitterCell.blueRange = 0.3
        emitterCell.birthRate = 3
        emitterCell.lifetime = 3.5
        emitterCell.yAcceleration = 70
        emitterCell.scale = 0.8
        emitterCell.scaleRange = 0.8
//        emitterCell.xAcceleration = 50
        emitterCell.velocityRange = 200
        emitterCell.velocity = 20
        emitterCell.emissionLongitude = .pi * -0.5
        emitterLayer.emitterCells = [emitterCell]
    }
}


```

<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/ViewAnimation/img/17.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
