#  Fetch Recipes Take Home Project

### Steps to Run the App
 1. In the Mac terminal, in a folder of your choice, type `git clone git@github.com:davidrynn/FetchRecipesProject.git`
 2. Open Xcode and under the "File" selection in the top menu bar select "Open..."
 3. Find and open the `FetchRecipesProject` folder. Inside the folder select and open the `FetchRewardsRecipes.xcodeproj` file.
 4. Next to the play button on the top bar, below the menu bar, select the iOS simulator device of your choise, or a physical device if it is connected.
 5. Press the play button.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas? 
#### Caching images. Since Apple has not yet made a caching image loader, I found this to take a lot of work - especially when trying to use Swift concurrency. There are many competing ideas online and I'm not completely familiar with any. I attempted to use what Apple has done in their demonstrations. A lot of solutions used dictionaries which are not necessarily thread safe, though may have been fine for the purposes of a simple app. Instead I used tasks.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time? 
#### 5 hours on-and-off. 

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
#### Using SwiftUI vs UIKit. For my prior job I used SwiftUI and felt very comfortable with it. I feel that it's better for state and using Apple's newer frameworks, and makes structured concurrency easier. However, with my current job, I only use UIKit, so it took me a little time to get back up to speed.
#### Using a "DataService" layer. In a production ready apps, a data layer can be very helpful. However, for this app, it's not really necessary. Also the issue of whether or not to make it an "actor." Since it has a "cache" property, that could potentially be accessed in a way that causes a race condition, using an actor is a more thread safe, in theory, though I found no issues when testing.
#### Using XCTests vs Swift Testing. I'm not very familiar with Swift Testing so for this purposes of this project I continued to use XCTests. With more time I'd prefer to use Swift Testing.

### Weakest Part of the Project: What do you think is the weakest part of your project?
#### UI and UI testing. Make take-away from the instructions were to focus on swift concurrency, caching/network efficiency, and unit testing. 

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
#### First, I always like to use the simplest architecture that is appropriate for a project. MVVM tends to do the job well. In this specific projet it's not entirely necessary - I could've just used the client and linked it directly to the view, but I used MVVM for demonstration purposes.
#### Second, I like to do things the "Apple" way. If I find a way Apple has demonstrated something, like using caches or networking, I use it. There's a stronger chance that their way will work with their products than anything I might make or someone on social media. So I took much of my work from Apple demonstrations, WWDC lectures and tutorials.
#### Endpoint management, ideally would be handled by backend for both better maintainability - changes done in one place, and also potentially security.
