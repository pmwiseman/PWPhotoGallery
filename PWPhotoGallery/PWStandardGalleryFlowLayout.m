//
//  PWStandardGalleryFlowLayout.m
//  PWPhotoGallery
//
//  Created by Patrick Wiseman on 3/19/16.
//  Copyright © 2016 Patrick Wiseman. All rights reserved.
//

#import "PWStandardGalleryFlowLayout.h"

@implementation PWStandardGalleryFlowLayout

//Preset Layout
+(PWStandardGalleryFlowLayout *)generateStandardPhotoGalleryFlowLayout
{
    float minItemSpacing = 15.0f;
    PWStandardGalleryFlowLayout *flowLayout = [[PWStandardGalleryFlowLayout alloc] init];
    //Various properties set for the flowLayout.
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:minItemSpacing];
    
    return flowLayout;
}

//Custom Layout
+(PWStandardGalleryFlowLayout *)generateStandardCameraRollFlowLayoutInView:(UIView *)view
                                                        minimumCellSpacing:(int)cellSpacing
                                                    maxNumberOfCellsPerRow:(int)numberPerRow
{
    PWStandardGalleryFlowLayout *flowLayout = [[PWStandardGalleryFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = cellSpacing;
    flowLayout.minimumInteritemSpacing = cellSpacing;
    flowLayout.itemSize = [self getFlowLayoutCellSizeWithCellSpacing:cellSpacing maxNumberOfCellsPerRow:numberPerRow];
    flowLayout.headerReferenceSize = CGSizeMake(view.frame.size.width, 0);
    
    return flowLayout;
}

+(CGSize)getFlowLayoutCellSizeWithCellSpacing:(int)cellSpacing maxNumberOfCellsPerRow:(int)numberPerRow
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat size = (screenWidth-(cellSpacing*(numberPerRow - 1)))/numberPerRow;
    CGSize cellSize = CGSizeMake(size, size);
    
    return cellSize;
}

@end
