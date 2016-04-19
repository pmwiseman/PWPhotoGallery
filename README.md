# PWPhotoGallery

App Store Link:  https://itunes.apple.com/us/app/cropcapt/id1101942465?mt=8

Example UICollectionView Photo Gallery Setup (Full Screen).  This collection view utilizes a custom paging method that will allow snapping to the left edge of a cell.  The benefit of having a custom paging method is it allows the user to specify spacing between the cells.

# General
When creating the photo gallery view for Yumscore we thought it would look better to have some spacing in between each of 
the full screen collection view cells that hold the reviews.   In order to accomplish this we specified the spacing 
within the collection view flow layout.  Unfortunately this messes up the built in paging functions.  The built in paging counts a "page" as one full cell width. So if you have a full cell width of 320pts and a spacing of 10pts it will calculate each page as 320pts. The first page will look fine but the second page will include our 10pt spacing and cut off the last 10pts of the cell.  How do we fix this?  The best way we found was to abandon the built in paging function and create our 
own.

# UIScrollView Delegate
In order to accomplish the custom paging effect utilized the UIScrollView delegate.  Since UICollectionView is a Subclass of UIScrollView this is possible.  There are two sets of delegates that we utilized, one when the user drags their finger accross the collection view and one when the user presses the scroll buttons we added.

There were a few properties we needed to define:<br><br>
<b>pageWidth:</b>  The width of each "page" in the collection view.  Since we wanted to have a 15 pt divider between the cells we added the 15 points to the previous cell.  So each cell except the last cell would have 15 points added on.

<b>currentPage:</b>  The current page that the user was on.  The calculation here looks tricky but it is actually quite simple.
`currentPage = floor((self.collectionView.contentOffset.x - pageWidth/2)/pageWidth)+1;`  Say the pageWidth is 320+15 and we are currently at index 0 of the collectionView so contentOffset.x = 0.  When this function is called we would get this:
((0 - 335/2)/335)+1 = 0.5  Let's break it up further:

(0-335) = -335<br>
-335/2 = -167.5<br>
-167.5/335 = -0.5<br>
-0.5 + 1 = 0.5<br>

Now this is where the floor() function comes in.  Our result of 0.5 is passed into floor and it returns with a value of 0.  So now we know we are on page 0 or indexPath.row 0 in our collectionView.

<b>currentIndexPath:</b>  This is calculated using the currentPage value above.  But instead of being stored as an integer it is stored as an NSIndexPath object.  This allows us to utilize various collectionView methods such as reloadItemsAtIndexPaths.

<b>newPage:</b>  The page where the user is scrolling to.  This is calculated when the scroll view ends decelerating or ends dragging, depending on whether the user taps the button or physically drags the collection view.

# User Drags the Collection View
<b>scrollViewWillBeginDragging:</b>When the user drags on the collection view the `scrollViewWillBeginDragging` delegate method is called, in here we define the page width and determine the current page the user was on.  This would give a us a reference point to determine where the user was in the collection view and where they could scroll (forwards or backwards).  The method referenced above to calculate current page is also utilized.  Once the current page is determined nothing else will be calculated until the scroll view beings to decelerate (user stops scrolling).

<b>scrollViewWillEndDragging:</b>The delegate method of `scrollViewWillEndDragging` is called when the user is scrolling inside the collection view and the velocity of the scroll begins to slow down (as the name implies when it begins to slow down it assumes it will end dragging).  So as the user continuously scrolls this method will run and update the current page value.  In here we must determine the newPage value and then snap the collection view to this new page.  First we must set the newPage equal to our currentPage to give ourselves a reference point.  There are three cases that we must consider:<br><br>

If the velocity of the collection view is equal to 0<br>
If the velocity of the collection view is greater than 0 (moving forward)<br>
If the velocity of the collection view is less than 0 (moving backwards)<br>

If the velocity is equal to 0 then we know that the user has not moved the collection view enough to warrant a page change. So the newPage is equal to the currentPage value.  If the user is moving the collection view forward (velocity greater than 0) we can increment the current page value by one to get our newPage.    If the user is moving the colleciton view backward (velocity less than 0) we can decrement the current page value by one to get the newPage.

Now that newPage value is calculated we have to consider two corner cases that could potentially trip us up.  The newPage value cannot be less than 0 and it cannot be greater than the maximum size of the collection view.  Therefore we must perform two checks.  If the newPage value is less than zero, simply reset it to 0 (first page in the collection view).  If the newPage value is greater than the number of pages found within the collection view `collectionView.contentSize.width/pageWidth` then set it to the last page of the collection view.  This ensures that the user will not be able to scroll out of the used bounds of our collection view.

The last portion of this method is the most important.  This will create the "paging" effect that we wanted.  At the end of the method call we can set the targetContentOffset which will automatically snap the collection view to the newPage value.  As mentioned above the currentPage value is continually updated as it is used to find the newPage value which defines where the collection view should snap to.  The call is as follows:<br>

`*targetContentOffset = CGPointMake(newPage * pageWidth, targetContentOffset -> y);`<br>

This tells the collection view that we want it to snap to the target content offset of our newPage's x value.  The y value specified does not changes and remains the same.  As this collection view can only scroll along the y axis.

<b>scrollViewDidEndDecelerating:</b> When the collection view finally ends the dragging operation (as opposed to WillEndDragging, this method is only called once when the collection view full stops dragging).  Here we want to use the newPage value calculated in the previously called method to set the currentIndexPath.  The currentIndexPath value will only be updated if it has changed.  Hence the if statement checking if the value we want to write is the same as the value already contained in currentIndexPath. 

# User uses UIButtons to Scroll
<b>scrollViewDidEndScrollingAnimation:</b> Instead of calling the scrollViewDidEndDecelerating method, when a button to change the page is tapped this method will be called.  Both contain the same code, although one is only called when the user initiates the scroll action programmatically.

# Usage
You can feel free to use these files in any of your projects.  There is a collection view cell file and flow layout provided.  The methods to handle the custom paging method are already setup.  So all you need to do is design your cell and add in the data.

# License

The MIT License (MIT)
Copyright (c) 2016 Patrick Wiseman

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
