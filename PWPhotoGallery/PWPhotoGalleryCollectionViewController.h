//
//  PWPhotoGalleryCollectionViewController.h
//  PWPhotoGallery
//
//  Created by Patrick Wiseman on 3/19/16.
//  Copyright © 2016 Patrick Wiseman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PWPhotoGalleryCollectionViewController : UICollectionViewController <UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray *photoArray;

@end
