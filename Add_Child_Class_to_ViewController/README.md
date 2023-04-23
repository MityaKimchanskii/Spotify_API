# Add Child ViewController
```swift
    private func addChildren() {
        addChild(greenVC)  - step 1
        scrollView.addSubview(greenVC.view) - step 2
        greenVC.didMove(toParent: self) - step 3
    }
```
- step 1 - addChild(greenVC) - This method creates a parent-child relationship between the current view controller and the object in the childController parameter. This relationship is necessary when embedding the child view controller’s view into the current view controller’s content. If the new child view controller is already the child of a container view controller, it is removed from that container before being added.This method is only intended to be called by an implementation of a custom container view controller. If you override this method, you must call super in your implementation.

- step 2 - addSubview(greenVC.view) - This method establishes a strong reference to view and sets its next responder to the receiver, which is its new superview. Views can have only one superview. If view already has a superview and that view is not the receiver, this method removes the previous superview before making the receiver its new superview.

- step 3 - didMove(toParent: self) - Your view controller can override this method when it wants to react to being added to a container.If you are implementing your own container view controller, it must call the didMove(toParent:) method of the child view controller after the transition to the new controller is complete or, if there is no transition, immediately after calling the addChild(_:) method.The removeFromParent() method automatically calls the didMove(toParent:) method of the child view controller after it removes the child.
    
        
<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/Add_Child_Class_to_ViewController/1.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />


GIF created with [LiceCap](http://www.cockos.com/licecap/).



