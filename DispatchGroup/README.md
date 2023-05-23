# DispatchGroup 

Use `DispatchGroup` when you have 2 or more endpoints and need to be notified when a network job is done.

```swift

    private func fetchDataAndLoadViews () {
        let group = DispatchGroup()
        
        group.enter()
        fetchProfile(forUserID: "1") { result in
            switch result {
            case .success(let profile):
                self.profile = profile
                self.configureHeader(with: profile)
               
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        
        group.enter()
        fetchAccounts(forUserID: "1") { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
                self.configureTableCells(with: accounts)
               
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.isLoaded = true
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }

 
```




