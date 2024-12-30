#  Fetch Recipes Take Home Project

### Steps to Run the App
 1. In the Mac terminal, in a folder of your choice, type `git clone git@github.com:davidrynn/FetchRecipesProject.git`
 2. Open Xcode and under the "File" selection in the top menu bar select "Open..."
 3. Find and open the `FetchRecipesProject` folder. Inside the folder select and open the `FetchRewardsRecipes.xcodeproj` file.
 4. Next to the play button on the top bar, below the menu bar, select the iOS simulator device of your choise, or a physical device if it is connected.
 5. Press the play button.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas? 
#### Caching images. Since Apple has not yet made a caching image loader, I found this to take a lot of work - especially when trying to use Swift concurrency. There are many competing ideas online and I'm not completely familiar with any. I attempted to use what Apple has done in their demonstrations. A lot of solutions used dictionaries which are not necessarily thread safe, though may have been fine for the purposes of a simple app. Instead I used tasks - what Apple uses.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time? 
#### 5 hours on-and-off. 

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
#### Using SwiftUI vs UIKit. For my prior job I used SwiftUI and felt very comfortable with it. I feel that it's better for state, for using with Apple's newer frameworks, and makes structured concurrency easier. However, with my current job, I only use UIKit, so it took me a little time to get back up to speed.
#### Using a "DataService" layer. In production ready apps, a data layer can be very helpful. However, for this app, it's not really necessary. Also the issue of whether or not to make it an "actor." Since it has a "cache" property which could potentially be accessed in a way that would cause a race condition, using an actor is more thread safe.
#### Using XCTests vs Swift Testing. I initially tried Swift Testing but I'm not familiar with it and want to limit how many new things I use on a interview project. So, I went back to using XCTest.

### Weakest Part of the Project: What do you think is the weakest part of your project?
#### UI and UI testing. Make take-away from the instructions were to focus on swift concurrency, caching/network efficiency, and unit testing, so I didn't spend too much time on UI. I didn't do any UI testing.
#### Endpoint management, ideally would be handled by backend for both better maintainability - changes can be done in one place, and also potentially more secure.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
#### First, I always like to use the simplest architecture that is appropriate for a project because the more complex the code, the more difficult it will be for other engineers, or even myself, to do more work on later. MVVM tends to do the job well. In this specific project it's not entirely necessary - I could've just used the client and linked it directly to the view, but I used MVVM for demonstration purposes. I could've also not used injection and used an Enviromental Object, but I wanted to keep with MVVM.
#### Second, I like to do things the "Apple" way. If I find a way Apple has demonstrated something, like using caches or networking, I use it. There's a stronger chance that their way will work with their products than anything I might make or someone on social media. So I took much of my work from Apple demonstrations, WWDC lectures and tutorials.
