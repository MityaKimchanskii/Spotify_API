# RefreshControl 

Create variable `UIRefreshControl`

```swift

    let refreshControl = UIRefreshControl()

```
Create method setupRefreshControl and assign it to a tableView.refreshControl (scrollView, collectionView)

```swift

    private func setupRefreshControl() {
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

```

When work is done add the `refreshControl.endRefreshing()` method.


