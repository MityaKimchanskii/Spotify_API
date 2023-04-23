# Protocol-Delegate

- step 1 - Protocol Declaration

    protocol ButtonsViewDelegate: AnyObject {
        func buttonsViewDelegateGreenButtonTapped(_ buttonsView: ButtonsView)
        func buttonsViewDelegateRedButtonTapped(_ buttonsView: ButtonsView)
    }

- step 2 - Applying in the Class

    weak var delegate: ButtonsViewDelegate?

- step 3 - Find the location when we want to fire the event

    @objc private func greenButtonTaped() {
        delegate?.buttonsViewDelegateGreenButtonTapped(self)
    }
    
    @objc private func redButtonTapped() {
        delegate?.buttonsViewDelegateRedButtonTapped(self)
    }
    
- step 4 - Link to protocol

        buttonsView.delegate = self

- step 5 - Confirm protocol methods in view controller

    extension ViewController: ButtonsViewDelegate {
        func buttonsViewDelegateGreenButtonTapped(_ buttonsView: ButtonsView) {
            label.text = "I am green!"
            label.textColor = .systemGreen
        }
    
        func buttonsViewDelegateRedButtonTapped(_ buttonsView: ButtonsView) {
            label.text = "I am red!"
            label.textColor = .systemRed
        }
    }

<img src='https://github.com/MityaKimchanskii/Spotify_API/blob/main/ProtocolDelegateButtonTapped/1.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).



