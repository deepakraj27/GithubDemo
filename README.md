# GithubDemo

## Summary
This app demonstrates the Fetching the list of closed pull request from GitHub with simple API call with Authorization. We have used authorization provided by github inorder to overcome the "Rate limiting".

## Third Party Framewroks
I have used ALAMOFIRE to handle API Calls and Mapped JSON's to my CODABLE MODEL. All the codable models are tested with UNIT test with mock data.
I have used SDWebImage to fetch the images

## Architecture

I have implemented this feature with MVVM architecture, Where the ViewController speaks to ViewModel and In ViewModel, we will communicate to Service <In turn that has protocol to fetch the list>. The service speaks to network manager and Network manager expects the URLRequest from the APIHandler. Once we get the data we map into respective models and converted to UIModels and Passed back data to Viewcontroller

### Pagination Logic
The above api is a paginated api, The logic for pagination is, if the fetcheditems count is less than itemsPerBatch (i.e., 10) then we dont make a api call until then new page details will be fetched

```
if newItems.count < self.itemsPerBatch {
  self.reachedEndOfItems = true
  print("reached end of data. Batch count: \(newItems.count)")
}

self.page += 1
```

### Loader UI
Since its a pagination api we need to show loader to the tableview, so we have created a loader and added it to the section 1 of tableview, so whenever we fetch a data in background, the loader happens in frontend

## Screenshots
### UI Screenshot
  
First Fetch             |  Batch Request with Loader
:-------------------------:|:-------------------------:
![](https://github.com/deepakraj27/GithubDemo/blob/main/Screenshots/1.png)  |  ![](https://github.com/deepakraj27/GithubDemo/blob/main/Screenshots/2.png)

### Test Cases Screenshot
ViewModel with MOCK Data             |  Model with Mock Data
:-------------------------:|:-------------------------:
![](https://github.com/deepakraj27/GithubDemo/blob/main/Screenshots/3.png)  |  ![](https://github.com/deepakraj27/GithubDemo/blob/main/Screenshots/4.png)
