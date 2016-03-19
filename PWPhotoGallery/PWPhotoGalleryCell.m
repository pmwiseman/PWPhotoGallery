//
//  PWPhotoGalleryCell.m
//  PWPhotoGallery
//
//  Created by Patrick Wiseman on 3/19/16.
//  Copyright © 2016 Patrick Wiseman. All rights reserved.
//

#import "PWPhotoGalleryCell.h"

@implementation PWPhotoGalleryCell

//Default init method for this file.  Ununsed since we are utilizing storyboards.
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        /*
        //Top ribbon
        int topRibbonX = 0;
        int topRibbonY = 0;
        int topRibbonWidth = frame.size.width;
        int topRibbonHeight = 44;
        CGRect topRibbonFrame = CGRectMake(topRibbonX,
                                           topRibbonY,
                                           topRibbonWidth,
                                           topRibbonHeight);
        UIView *topRibbonView = [[UIView alloc] initWithFrame:topRibbonFrame];
        topRibbonView.backgroundColor = [UIColor blackColor];
        [self addSubview:topRibbonView];
        //Back button
        int backButtonX = 8;
        int backButtonY = 2;
        int backButtonWidth = 40;
        int backButtonHeight = 40;
        CGRect backButtonFrame = CGRectMake(backButtonX,
                                            backButtonY,
                                            backButtonWidth,
                                            backButtonHeight);
        self.backButton = [[UIButton alloc] initWithFrame:backButtonFrame];
        [self addSubview:self.backButton];
         */
        //Image View
        int imageX = 0;
        int imageY = 0;
        int imageWidth = frame.size.width;
        int imageHeight = frame.size.height;
        CGRect imageFrame = CGRectMake(imageX,
                                       imageY,
                                       imageWidth,
                                       imageHeight);
        self.imageView = [[UIImageView alloc] initWithFrame:imageFrame];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imageView];
    }
    return self;
}

@end
