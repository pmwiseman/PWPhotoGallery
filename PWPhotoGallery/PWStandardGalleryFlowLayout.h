//
//  PWStandardGalleryFlowLayout.h
//  PWPhotoGallery
//
//  Created by Patrick Wiseman on 3/19/16.
//  Copyright © 2016 Patrick Wiseman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PWStandardGalleryFlowLayout : UICollectionViewFlowLayout

+(PWStandardGalleryFlowLayout *)generateStandardPhotoGalleryFlowLayout;
+(PWStandardGalleryFlowLayout *)generateStandardCameraRollFlowLayoutInView:(UIView *)view
                                                         minimumCellSpacing:(int)cellSpacing
                                                     maxNumberOfCellsPerRow:(int)numberPerRow;

@end
